# Import standard modules
import numpy, os, sys, time 

# Add environment variables and paths
os.environ['MANTRA_SOURCE'] = os.path.dirname(os.path.realpath(__file__)) # find mantra home directory
os.environ['MANTRA_MOFILE'] = os.path.join(os.environ['MANTRA_SOURCE'], '..', '..', 'ManualTracking.mo') # ManTra Modelica file
os.environ['MANTRA_RESOURCES'] = os.path.join(os.environ['MANTRA_SOURCE'], '..') # function scripts and Options
os.environ['MANTRA_DATA'] = os.path.join(os.environ['MANTRA_SOURCE'], '..', 'Data') # data storage in timestamped csv files
os.environ['MANTRA_TEMP'] = os.path.join(os.environ['MANTRA_SOURCE'], '..', 'Temp') # storage of compiler and log files
sys.path.insert(0, os.environ['MANTRA_RESOURCES'])
sys.path.insert(0, os.environ['MANTRA_SOURCE'])

# Load global options from Options.py
import Options
taskModel = Options.taskModel
taskName = taskModel.split('.')[-1]
saveFormat = Options.saveFormat
printVerbose = Options.printVerbose
odeSolver = Options.odeSolver
optMethod = Options.optMethod
tuneAnyParam = Options.tuneAnyParam
frameRateSimulation = Options.frameRateSimulation
frameRateExperiment = Options.frameRateExperiment

# Start OpenModelica Server
import fmi
os.chdir(os.environ['MANTRA_TEMP'])
fmi.start_openmodelica_server()

# Read Modelica file
with open(os.environ['MANTRA_MOFILE'], 'r') as moFile: 
    mofileText = moFile.readlines()

# Parse tracking task model
import tools
(controllerInfo, elementInfo, referenceInfo, disturbanceInfo, settingsInfo) = tools.get_task_info(mofileText, taskModel) 

# Unpack info tuples
(controllerModel, controllerName, controllerParams, controllerStr, controllerComments) = controllerInfo
(elementModel, elementName, elementParams, elementComments) = elementInfo
(referenceModel, referenceName, referenceParams, referenceComments) = referenceInfo
(disturbanceModel, disturbanceName, disturbanceParams, disturbanceComments) = disturbanceInfo
(finalTime, previewTime, backgroundVisible) = settingsInfo

# Calculate time variables
stepTime = 1.0/frameRateSimulation
numSteps = int(float(finalTime)/stepTime)
numFrames = numSteps + 1

# Define file names
logFile = os.path.join(os.environ['MANTRA_TEMP'], taskModel.replace('.','_') + '_log.txt')
resultFile = os.path.join(os.environ['MANTRA_TEMP'], taskModel.replace('.','_') + '_results.txt')
moFile = os.environ['MANTRA_MOFILE']


def run_tracking_simulation(FMUMODEL=False, modifiedParams=False, inputData=False, plotResults=False, saveResults=False, runOnce=False):
    if not FMUMODEL: # if FMU not provided, then compile FMU
        fmuName = fmi.compile_fmu_openmodelica(taskModel, moFile, saveDir=os.environ['MANTRA_TEMP'], printVerbose=printVerbose)
        FMUMODEL = fmi.load_fmu_pyfmi(fmuName, logFile, printVerbose=printVerbose)
    
    if modifiedParams: # go through modifiedParams dict
        for oneKey in modifiedParams.keys():
            paramString = controllerName + '.' + oneKey
            FMUMODEL.set(paramString, modifiedParams[oneKey])

    if inputData:
        (t_data, r_data, y_data, w_data, u_data) = inputData
        controlVecs = numpy.transpose(numpy.vstack((t_data, r_data, y_data, w_data)))
        controlInput = ([controllerName+'.r', controllerName+'.y', controllerName+'.w'], controlVecs)
    else: 
        controlInput = False 

    # Simulate model
    fmuOpts = fmi.set_fmu_options(True, resultFile, stepTime, solverName=odeSolver)
    fmuResults = FMUMODEL.simulate(options=fmuOpts, start_time=0, final_time=finalTime)
    FMUMODEL.reset()

    # Extract data
    t_sim = fmuResults['time']
    r_sim = fmuResults[controllerName+'.r']
    y_sim = fmuResults[controllerName+'.y']
    w_sim = fmuResults[controllerName+'.w']
    u_sim = fmuResults[controllerName+'.u']

    # Save results
    tools.write_data_csv(dirName=os.environ['MANTRA_TEMP'], fileName=taskName+'_sim.csv', dataCols=(t_sim, r_sim, y_sim, w_sim, u_sim))
    if saveResults:
        functionName = 'RunTrackingSimulation'
        timeStamp = time.strftime("%Y.%m.%d-%H.%M.%S", time.localtime())
        fileName = eval(saveFormat)
        tools.write_data_csv(dirName=os.environ['MANTRA_DATA'], fileName=fileName+'.csv', dataCols=(t_sim, r_sim, y_sim, w_sim, u_sim))

    if plotResults:
        tools.plot_variable_trajectories(t_sim, ((r_sim, y_sim, 'Reference State', 'Measured State'), (w_sim, u_sim, 'Disturbance Input', 'Control Input')), "Simulated Tracking Task")

    # Stop OMC Server if only running once
    if runOnce:
        fmi.stop_openmodelica_server()


def run_tracking_experiment(useSaved=False, plotResults=False, saveResults=False):
    import game    

    # Game frame rate
    expStepTime = 1.0/frameRateExperiment
    expNumSteps = int(float(finalTime)/expStepTime)
    expNumFrames = expNumSteps + 1

    if useSaved:
        if os.path.isfile(os.path.join(os.environ['MANTRA_TEMP'], taskName+'_exp.csv')):
            (t_exp, r_exp, y_exp, w_exp, u_exp) = tools.read_data_csv(dirName=os.environ['MANTRA_TEMP'], fileName=taskName+'_exp.csv')
        else:
            print "useSaved is set to True, but no saved data is found in Resources/Temp.\nFirst use run_tracking_experiment to generate new data.\n"    
    else:        
        # Make forcing functions
        frame_exp = range(0, expNumFrames, 1)
        t_exp = [expStepTime*frame for frame in frame_exp]
        print "Generating reference signal.\n"
        r_exp = tools.generate_fmu_signal(referenceModel, moFile, t_exp, referenceParams, expStepTime, saveDir=os.environ['MANTRA_TEMP'], odeSolver=odeSolver, printVerbose=printVerbose)
        print "Generating disturbance input.\n"
        w_exp = tools.generate_fmu_signal(disturbanceModel, moFile, t_exp, disturbanceParams, expStepTime, saveDir=os.environ['MANTRA_TEMP'], odeSolver=odeSolver, printVerbose=printVerbose)

        # Assign variables into 'game' module from TrackingTask 
        game.backgroundVisible = backgroundVisible
        game.previewTime = previewTime
        game.stepTime = expStepTime
        game.frameRate = frameRateExperiment
        game.frame_hist = frame_exp
        game.odeSolver = odeSolver
        game.t_hist = t_exp
        game.r_hist = r_exp
        game.w_hist = w_exp
        game.u_hist = len(t_exp)*[0]
        game.y_hist = len(t_exp)*[0]
        game.u_current = 0 # persistent variable needed for keyboard input

        # Run tracking experiment
        (u_exp, y_exp) = game.run_tracking_experiment(elementModel=elementModel, modelicaFile=os.environ['MANTRA_MOFILE'])

        # Save results
        tools.write_data_csv(dirName=os.environ['MANTRA_TEMP'], fileName=taskName+'_exp.csv', dataCols=(t_exp, r_exp, y_exp, w_exp, u_exp))
        if saveResults:
            functionName = 'RunTrackingExperiment'
            timeStamp = time.strftime("%Y.%m.%d-%H.%M.%S", time.localtime())
            fileName = eval(saveFormat)
            tools.write_data_csv(dirName=os.environ['MANTRA_DATA'], fileName=fileName+'.csv', dataCols=(t_exp, r_exp, y_exp, w_exp, u_exp))

    if plotResults:
        tools.plot_variable_trajectories(t_exp, ((r_exp, y_exp, 'Reference State', 'Measured State'), (w_exp, u_exp, 'Disturbance Input', 'Control Input')), "Experimental Tracking Task")

    # Stop OMC Server
    fmi.stop_openmodelica_server()


def tune_controller_simulation(plotResults=False, saveResults=False):    
    functionName = 'TuneControllerSimulation'

    # Allow user to select parameters to tune
    params2tune = tools.select_tuned_parameters(controllerParams, controllerStr, tuneAnyParam) # returns list of param names to tune

    # Assemble arguments and call function
    taskInfo = (controllerName, taskModel, os.environ['MANTRA_MOFILE']) 
    controllerInfo = (controllerParams, params2tune) 
    controllerParams_optimal = tools.tune_manual_controller(taskInfo, controllerInfo, saveDir=os.environ['MANTRA_TEMP'], inputData=False, printVerbose=printVerbose)       

    if plotResults:
        (t_sim, r_sim, y_sim, w_sim, u_sim) = tools.read_data_csv(dirName=os.environ['MANTRA_TEMP'], fileName=taskName+'_sim.csv')
        tools.plot_variable_trajectories(t_sim, ((r_sim, y_sim, 'Reference State', 'Measured State'), (w_sim, u_sim, 'Disturbance Input', 'Control Input')), "Simulated Tracking Task")

    print "Controller parameters chosen:"
    print params2tune
    print "Optimal parameter values:"
    print controllerParams_optimal
    
    # Stop OMC Server
    fmi.stop_openmodelica_server()


def tune_controller_experiment(useSaved=False, plotResults=False, saveResults=False):
    functionName = 'TuneControllerExperiment'

    # Allow user to select parameters to tune
    params2tune = tools.select_tuned_parameters(controllerParams, controllerStr, tuneAnyParam) # returns list of param names to tune

    # Run experiment if not using previously saved data
    if os.path.isfile(os.path.join(os.environ['MANTRA_TEMP'], taskName+'_exp.csv')):
        (t_exp, r_exp, y_exp, w_exp, u_exp) = tools.read_data_csv(dirName=os.environ['MANTRA_TEMP'], fileName=taskName+'_exp.csv')
    else:
        print "No saved data is found in Resources/Temp.\nFirst use run_tracking_experiment to generate new data.\n"                
    
    # Assemble arguments and call function
    inputData = (t_exp, r_exp, y_exp, w_exp, u_exp)
    taskInfo = (controllerName, taskModel, os.environ['MANTRA_MOFILE']) 
    controllerInfo = (controllerParams, params2tune) 
    controllerParams_optimal = tools.tune_manual_controller(taskInfo, controllerInfo, saveDir=os.environ['MANTRA_TEMP'], inputData=inputData, printVerbose=printVerbose)       

    if plotResults:
        (t_sim, r_sim, y_sim, w_sim, u_sim) = tools.read_data_csv(dirName=os.environ['MANTRA_TEMP'], fileName=taskName+'_sim.csv')
        (t_exp, r_exp, y_exp, w_exp, u_exp) = tools.read_data_csv(dirName=os.environ['MANTRA_TEMP'], fileName=taskName+'_exp.csv')
        y_sim_interp = numpy.interp(t_exp, t_sim, y_sim) 
        u_sim_interp = numpy.interp(t_exp, t_sim, u_sim) 
        tools.plot_variable_trajectories(t_exp, ((r_exp, y_exp, y_sim_interp, 'Reference State', 'Experimental Measured State', 'Simulated Measured State'), (w_exp, u_exp, u_sim_interp, 'Disturbance Input', 'Experimental Control Input', 'Simulated Control Input')), "Experimental vs. Simulated Controller")

    print "Controller parameters chosen:"
    print params2tune
    print "Optimal parameter values:"
    print controllerParams_optimal
    
    # Stop OMC Server
    fmi.stop_openmodelica_server()
