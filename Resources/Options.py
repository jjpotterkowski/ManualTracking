#=====================================================================================
# GLOBAL OPTIONS -- these apply to all Python function inside the Resources/ directory
#=====================================================================================
taskModel = 'ManualTracking.TrackingTasks.SampleTaskPursuitPreview' # name of class inside TrackingTask package
jmodelicaPath = 'C:\\JModelica.org-1.13' # JModelica install path
saveFormat = "timeStamp + '-' + taskName + '-' + functionName" # format for data file names saved to Resources/Data/
printVerbose = True # print all log and results messages
odeSolver = 'ExplicitEuler' # 'Dopri5' or 'ExplicitEuler'

#============================================================
# LOCAL OPTIONS -- these apply to individual Python functions
#============================================================
# RunTrackingSimulation()
RTS_plotResults = True
RTS_printResults = True
RTS_saveResults = True

# RunTrackingExperiment()
RTE_useSaved = False
RTE_plotResults = True
RTE_printResults = True
RTE_saveResults = False

# TuneControllerSimulation()
TCS_plotResults = True
TCS_printResults = True
TCS_saveResults = False

# TuneControllerExperiment()
TCE_useSaved = True
TCE_plotResults = True
TCE_printResults = True
TCE_saveResults = True
