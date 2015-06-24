print "\n==============================================="
print "ManualTracking library -- RunTrackingExperiment"
print "==============================================="

# Load mantra.py from Source folder
import os, sys
ResourcesDir = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0, os.path.join(ResourcesDir, 'Source'))
import mantra

# Import function options
import Options
useSaved = Options.RTE_useSaved
plotResults = Options.RTE_plotResults
printResults = Options.RTE_printResults
saveResults = Options.RTE_saveResults

# Run program
mantra.run_tracking_experiment(
        useSaved=useSaved, 
        plotResults=plotResults,
        printResults=printResults,
        saveResults=saveResults)
