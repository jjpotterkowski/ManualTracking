#=======================================================================================
# Global Options -- general options for Python function inside the Resources/ directory
#=======================================================================================
taskModel = 'ManualTracking.TrackingTasks.ExampleCompensatory' # name of tracking task class to use in Python functions
saveFormat = "timeStamp + '-' + taskName + '-' + functionName" # format for data file names saved to Resources/Data/
printVerbose = True # print all log and results messages
odeSolver = 'ExplicitEuler' # 'ExplicitEuler' or 'Dopri5'
optMethod = 'Nelder-Mead' # 'Nelder-Mead' or 'Powell', used in controller tuning functions
tuneAnyParam = False # Allows user to select any controller parameter for tuning (time delays, neuromuscular natural frequency and damping are normally excluded)
frameRateSimulation = 50 # frame rate for tracking simulations, in frames per second
frameRateExperiment = 25 # frame rate for experimental tracking task, in frames per second ... between 24 and 30 is recommended

#============================================================
# Local Options -- arguments for individual Python functions
#============================================================
RunTrackingSimulation = {
    'plotResults': True, # plot trajectories of r(t), w(t), u(t), and y(t)
    'saveResults': False} # save a copy of the data file into Resources/Data directory

RunTrackingExperiment = {
    'useSaved': False, # load .csv data file from Resources/Temp ... only really useful to plot most recent experiment
    'plotResults': True, 
    'saveResults': False}

TuneControllerSimulation = {
    'plotResults': True,
    'saveResults': False}

TuneControllerExperiment = {
    'useSaved': True,
    'plotResults': True,
    'saveResults': False}
