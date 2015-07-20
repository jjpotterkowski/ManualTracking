#=======================================================================================
# Global Options -- general options for Python function inside the Resources/ directory
#=======================================================================================
taskModel = 'ManualTracking.TrackingTasks.SampleTaskPursuitPreview' # name of class inside TrackingTask package
saveFormat = "timeStamp + '-' + taskName + '-' + functionName" # format for data file names saved to Resources/Data/
printVerbose = True # print all log and results messages
odeSolver = 'ExplicitEuler' # 'Dopri5' or 'ExplicitEuler'
optMethod = 'Nelder-Mead' # 'Nelder-Mead' or 'Powell', used in controller tuning functions
frameRateSimulation = 50 # frame rate for tracking simulations, in frames per second
frameRateExperiment = 24 # frame rate for experimental tracking task, in frames per second

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
    'plotResults': True,
    'saveResults': False}
