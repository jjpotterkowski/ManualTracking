print "\n=================================================="
print "ManualTracking library -- TuneControllerExperiment"
print "=================================================="

# Load mantra.py from Source folder
import os, sys
ResourcesDir = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0, os.path.join(ResourcesDir, 'Source'))
import mantra

# Import function options
import Options
useSaved = Options.TCE_useSaved
plotResults = Options.TCE_plotResults
printResults = Options.TCE_printResults
saveResults = Options.TCE_saveResults

# Run program
mantra.tune_controller_experiment(
        useSaved=useSaved, 
        plotResults=plotResults,
        printResults=printResults,
        saveResults=saveResults)
