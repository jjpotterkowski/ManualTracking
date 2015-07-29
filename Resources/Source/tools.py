import numpy, os, sys
import fmi, mantra


def get_task_info(mofileText, taskName):    
    trackingText = get_class_subtext(mofileText, ['package'], 'TrackingTasks') # isolate the TrackingTasks package
    taskName = taskName.split('.')[-1] # split taskName into package names and model name
    taskText = get_class_subtext(trackingText, ['class', 'model', 'block'], taskName) # note that model name must be unique within TrackingTasks package

    # Go through each line of tracking task model
    for textLine in taskText:
        if 'ManualTracking.' in textLine: # declaring instance of one of the models
            textLine = strip_annotation_text(textLine) # remove whole annotation section
            textLine = textLine.strip(' ') # strip leading and trailing whitespace
            textLine = textLine.replace(';', '') # remove semicolon at end of line (happens if there is no annotation section)
            if 'ManualControllers' in textLine: 
                (controllerModel, controllerName, controllerParams, controllerComments) = get_instance_details(textLine)
            if 'ControlledElements' in textLine: 
                (elementModel, elementName, elementParams, elementComments) = get_instance_details(textLine)
            if 'ReferenceSignals' in textLine: 
                (referenceModel, referenceName, referenceParams, referenceComments) = get_instance_details(textLine)
            if 'DisturbanceInputs' in textLine: 
                (disturbanceModel, disturbanceName, disturbanceParams, disturbanceComments) = get_instance_details(textLine)
            if 'TaskSettings' in textLine: 
                (settingsModel, settingsName, settingsParams, settingsComments) = get_instance_details(textLine) 

    # get_instance_details() got only parameters modified in the specific TrackingTask class ... we need to find all parameters
    controllerPackage = get_class_subtext(mofileText, ['package'], 'ManualControllers') # isolate ManualControllers package
    controllerText = get_class_subtext(controllerPackage, ['class', 'model', 'block'], controllerModel.split('.')[-1]) # isolate controller model
    (controllerDefaults, controllerStr) = get_class_parameters(controllerText) # get all controller parameters
    controllerParams = overwrite_dict_values(controllerDefaults, controllerParams) # overwrite controller default values with modified values in instance declaration

    # Retrieve all settings in the TaskSettings model, even those not modified in the TrackingTask class
    settingsText = get_class_subtext(trackingText, ['class', 'model', 'block'], settingsModel.split('.')[-1]) # isolate settings model
    (settingsDefaults, settingsStr) = get_class_parameters(settingsText)
    settingsParams = overwrite_dict_values(settingsDefaults, settingsParams)

    # Unpack TaskSettings parameters from dictionary
    finalTime = settingsParams['taskDuration']
    previewTime = settingsParams['previewTime']
    backgroundVisible = settingsParams['backgroundVisible']

    # Return everything in tuples
    return ((controllerModel, controllerName, controllerParams, controllerStr, controllerComments), 
            (elementModel, elementName, elementParams, elementComments),
            (referenceModel, referenceName, referenceParams, referenceComments),
            (disturbanceModel, disturbanceName, disturbanceParams, disturbanceComments),
            (finalTime, previewTime, backgroundVisible))


def get_class_subtext(fullText, classTypes, className):
    appendFlag = False
    classText = False
    
    # Find lines of [fullText] that are within class [className], and have type in [classTypes]
    for lineText in fullText:
        for oneType in classTypes: # can input list of class types, e.g. ['class', 'model', 'block']
            if oneType + ' ' + className in lineText:
                if (len(oneType + ' ' + className) == len(lineText.strip())) or (lineText.strip()[len(oneType + ' ' + className)] == ' '):
                    appendFlag = True
                    classText = [] # declaration was found, so initialize string to be returned
        if appendFlag:
            classText.append(lineText)
        if 'end ' + className + ';' in lineText:
            appendFlag = False

    return classText


def get_instance_details(declarationText):
    (instanceModel, instanceDeclaration) = declarationText.split(' ', 1) # split into "Package.ModelName" and "instancename(otherStuff)"
    paramDict = {}

    if '(' in instanceDeclaration: 
        instanceName = instanceDeclaration.split('(')[0] # name of instance is before parameter modifications bounded by ( )
        instanceDetails = instanceDeclaration[instanceDeclaration.find("(")+1:instanceDeclaration.find(")")] # get stuff between parentheses
        instanceDetails = instanceDetails.replace('}', '') # don't need ending curly brace as marker ... just complicates things
        instanceDetails = instanceDetails.replace(' ', '') # get rid of white spaces         
        commaList = instanceDetails.split(',') # split apart parameters (also splits up arrays)
        paramDict = {} # make dictionary of parameters and their value

        for itemNum in range(len(commaList)): 
            if '=' in commaList[itemNum]:
                (currentKey, currentVal) = commaList[itemNum].split('=')
                arrayKey = currentKey
                arrayMember = 1    
                if '{' in currentVal: # must convert Modelica arrays bounded by {} into Python lists bounded by []
                    arrayKey = currentKey + '[' + str(arrayMember) + ']'
                    currentVal = currentVal.strip('{')
                    arrayMember = arrayMember + 1
                paramDict[arrayKey] = eval(currentVal)
            else:
                arrayKey = currentKey  + '[' + str(arrayMember) + ']' # add another member to the array
                arrayVal = commaList[itemNum]
                arrayMember = arrayMember + 1
                paramDict[arrayKey] = eval(arrayVal)
    else: instanceName = instanceDeclaration

    if '"' in instanceDeclaration: 
        instanceComments = instanceDeclaration.split('"')[1]
    else: instanceComments = ''

    return (instanceModel, instanceName, paramDict, instanceComments)


def get_class_parameters(classText):
    paramValues = {}
    paramComments = {}

    for lineNum in classText:
        if 'parameter ' in lineNum.strip():
            modLine = lineNum.strip() # strip leading and trailing white space
            modLine = modLine.replace(';', '') # remove semicolons
            modLine = modLine.split(' ', 2)[2] # keep only text after 'parameter DATATYPE '
            
            if '"' in modLine:
                (modLine, commentString, junk) = modLine.split('"')       
            else:
                commentString = ''
            modLine = modLine.replace(' ', '') # eliminate white spaces

            if '(' in modLine:
                (paramName, theRest) = modLine.split('(')
                (insideParen, varVal) = theRest.split(')')
                (junk, paramAssigned) = varVal.split('=')
            else:
                (paramName, paramAssigned) = modLine.split('=') 

            paramComments[paramName] = commentString
            paramVal = '' # must build parameter value from individual characters because it could be Boolean
            
            if any(oneChar.isdigit() for oneChar in paramAssigned): # Real
                isNum = True
                for oneChar in paramAssigned:
                    if isNum and oneChar in ['-', '.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'e', 'E']:
                        paramVal = paramVal + oneChar
                    else: 
                        isNum = False
                paramValues[paramName] = float(paramVal)
            else: # Boolean 
                if paramAssigned == 'false':
                    paramValues[paramName] = 'False'
                elif paramAssigned == 'true':
                    paramValues[paramName] = 'True'
                else:
                    print "Parameter was unrecognized.\n"

    return (paramValues, paramComments)


def strip_annotation_text(textRaw):
    if 'annotation(' in textRaw: 
        textOut = textRaw.split('annotation(')[0] # remove annotation text
    else: 
        textOut = textRaw
    
    return textOut


def tune_manual_controller(taskInfo, controllerInfo, saveDir, optMethod='Nelder-Mead', inputData=False, printVerbose=False):   
    (controllerName, taskModel, taskFile) = taskInfo
    (controllerParams, params2tune) = controllerInfo

    # Make deep copy of initial controller parameter dictionary
    import copy
    controllerInit = copy.deepcopy(controllerParams)

    # Make FMUMODEL once, instead of letting run_tracking_simulation() do it every time
    logFile = os.path.join(saveDir, taskModel.replace('.','_') + '_log.txt')
    fmuName = fmi.compile_fmu_openmodelica(taskModel, taskFile, saveDir=saveDir, printVerbose=printVerbose)
    FMUMODEL = fmi.load_fmu_pyfmi(fmuName, logFile, printVerbose=printVerbose)

    # Note that variables in body of tune_manual_controller() below can be accessed in compute_cost_value()
    if inputData: 
        (t_exp, r_exp, y_exp, w_exp, u_exp) = inputData
        matchOutput = True
    else: 
        inputData = False
        matchOutput = False

    # Define initial values for tuned parameters
    x0 = []
    for oneKey in params2tune:
        x0.append(controllerInit[oneKey])
    x0 = numpy.array(x0) # convert to numpy array format for jmodelica

    # Calculate objective function value for current parameter values
    def compute_cost_value(x):
        modifiedParams = {}
        for paramNum in range(len(params2tune)):
            modifiedParams[params2tune[paramNum]] = x[paramNum]

        if printVerbose:
            print "Modified parameters:"
            print modifiedParams
            print ""

        # Run tracking simulation
        mantra.run_tracking_simulation(FMUMODEL=FMUMODEL, modifiedParams=modifiedParams, inputData=inputData, plotResults=False, saveResults=False, runOnce=False)
        (t_sim, r_sim, y_sim, w_sim, u_sim) = read_data_csv(dirName=saveDir, fileName=taskModel.split('.')[-1]+'_sim.csv')      

        # Compute cost value
        if matchOutput: # based on difference between experimental and simulated control signal u(t), given inputs to controller r(t), y(t), and w(t)
            t_intervals = [t_exp[k+1]-t_exp[k] for k in range(len(t_exp)-1)]
            u_simulated = numpy.interp(t_exp, t_sim, u_sim) # interpolate recorded command u at simulated time points
            costVal = numpy.sqrt(numpy.mean(t_intervals*(u_simulated[0:-1] - u_exp[0:-1])**2)) # compare recorded command to simulated command
        else: # based on tracking error
            t_intervals = [t_sim[k+1]-t_sim[k] for k in range(len(t_sim)-1)]
            costVal = numpy.sqrt(numpy.mean(t_intervals*(numpy.array(r_sim[0:-1]) - numpy.array(y_sim[0:-1]))**2)) # compare reference signal to controlled element state

        if printVerbose:
            print '\nCurrent x: '
            print x
            print 'Cost value:'
            print costVal
            print ""

        return costVal

    if not printVerbose: OLDSTDOUT = disable_console_output()
    optParams = fmi.minimize_cost_scipy(compute_cost_value, x0, optMethod=optMethod, printVerbose=printVerbose)
    if not printVerbose: enable_console_output(OLDSTDOUT) 
    
    return optParams


def plot_variable_trajectories(t_hist, traj_sets, titleString):
    try: 
        import matplotlib.pyplot as plt  
    except: 
        print "Could not import matplotlib.pyplot. Matplotlib is required for plotting.\n"
        return

    plt.title(titleString)
    numPlots = len(traj_sets)
    for plotNum in range(numPlots):
        plt.subplot(numPlots, 1, plotNum+1)
        numTraj = len(traj_sets[plotNum])/2 # first half are trajectories, second half are legend names
        for trajNum in range(numTraj):
            plt.plot(t_hist, traj_sets[plotNum][trajNum])            
        plt.legend((traj_sets[plotNum][numTraj:]), loc='upper right', shadow=True)
    plt.show()


def generate_fmu_signal(modelicaModel, modelicaFile, t_hist, paramDict, fmuMaxh, saveDir, odeSolver, printVerbose=False):  
    assert t_hist[0] == 0, "Time values must start at t=0."

    fmuName = os.path.join(os.environ['MANTRA_TEMP'], modelicaModel.replace('.', '_')+'.fmu')
    logFile = os.path.join(saveDir, modelicaModel.replace('.', '_') + '_log.txt')
    resultFile = os.path.join(saveDir, modelicaModel.replace('.', '_') + '_results.txt')
    if not os.path.isfile(fmuName):
        fmuName = fmi.compile_fmu_openmodelica(modelicaModel, modelicaFile, saveDir, printVerbose=printVerbose)
    FMUMODEL = fmi.load_fmu_pyfmi(fmuName, logFile, printVerbose=printVerbose)
    
    # Overwrite default parameter values
    for oneKey in paramDict.keys():
        FMUMODEL.set(oneKey, paramDict[oneKey])

    fmuOpts = fmi.set_fmu_options(False, resultFile, fmuMaxh, solverName=odeSolver)
    FMUMODEL.initialize()
    (FMUMODEL, fmuResults) = fmi.simulate_fmu(FMUMODEL, fmuOpts, 0, t_hist[-1], printVerbose=printVerbose)
    t_sig = fmuResults['time']
    y_sig = fmuResults['y']
    signalOut = numpy.interp(t_hist, t_sig, y_sig)
    
    return signalOut 


def overwrite_dict_values(baseDict, overwriteDict, overwriteKeys=False, overwriteVals=False):
    if overwriteKeys and overwriteVals:
        for keyNum in range(len(overwriteKeys)):
            if overwriteKeys[keyNum] in baseDict.keys():
                baseDict[overwriteKeys[keyNum]] = overwriteVals[keyNum]

    for oneKey in baseDict.keys():
        if oneKey in overwriteDict.keys():
            baseDict[oneKey] = overwriteDict[oneKey]

    return baseDict


def print_controller_parameters(paramDict, paramStr, listAllParams=False):
    print "Controller parameters (except time delays):" 
    keyNum = 1    
    for oneKey in paramDict.keys():
        if listAllParams:
            print '  ' + str(keyNum) + '. ' + oneKey + ' -- ' + paramStr[oneKey]
        elif oneKey[0:3] != 'tau' and oneKey[0:5] != 'omega' and oneKey[0:4] != 'zeta':
            print '  ' + str(keyNum) + '. ' + oneKey + ' -- ' + paramStr[oneKey]
        keyNum = keyNum + 1
    print ""


def select_tuned_parameters(paramDict):
    paramNums_raw = raw_input("Please enter a comma-separated number\nlist specifying parameters to tune: ")
    print ""

    paramNums = str(paramNums_raw).replace(' ', '').split(',') # remove white space and split into individual numbers
    paramNums = [int(p) for p in paramNums] # parameter numbers in list form
    params2tune = []
    keyNum = 1

    for oneKey in paramDict.keys():
        if keyNum in paramNums:
            assert oneKey[0:3] != 'tau', "Number not found on list of parameters"
            params2tune.append(oneKey)
        keyNum = keyNum + 1

    return params2tune


def write_data_csv(dirName, fileName, dataCols):
    import csv
 
    (t_data, r_data, y_data, w_data, u_data) = dataCols
    numFrames = len(t_data)
    dataFileAbs = os.path.join(dirName, fileName)
    with open(dataFileAbs, 'wb') as csvFile:
        CSVWRITER = csv.writer(csvFile)
        CSVWRITER.writerow(['t'] + ['r(t)'] + ['y(t)'] + ['w(t)'] + ['u(t)'])
        for f in range(numFrames):
            CSVWRITER.writerow([str(t_data[f])] + [str(r_data[f])] + [str(y_data[f])] + [str(w_data[f])] + [str(u_data[f])])


def read_data_csv(dirName, fileName):
    import csv

    fileNameAbs = os.path.join(dirName, fileName)
    lineNum = 0
    t_data = []
    r_data = []
    y_data = []
    w_data = []
    u_data = []
    with open(fileNameAbs) as csvfile:
        CSVREADER = csv.reader(csvfile)
        for row in CSVREADER:
            if lineNum == 0:
                pass
            else:
                t_data = t_data + [eval(row[0])]
                r_data = r_data + [eval(row[1])]
                y_data = y_data + [eval(row[2])]
                w_data = w_data + [eval(row[3])]
                u_data = u_data + [eval(row[4])]
            lineNum = lineNum + 1
    
    return (t_data, r_data, y_data, w_data, u_data)


def disable_console_output():
    OLDSTDOUT = sys.stdout
    sys.stdout = NullWriter()

    return OLDSTDOUT


def enable_console_output(OLDSTDOUT):
    sys.stdout = OLDSTDOUT


class NullWriter(object):
    def write(self, arg):
        pass
