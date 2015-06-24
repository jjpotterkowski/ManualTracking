print "\n=================================================="
print "ManualTracking library -- TuneControllerSimulation"
print "=================================================="

# Load mantra.py from Source folder
import os, sys
ResourcesDir = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0, os.path.join(ResourcesDir, 'Source'))
import mantra

# Import function options
import Options
plotResults = Options.TCS_plotResults
printResults = Options.TCS_printResults
saveResults = Options.TCS_saveResults

# Run program
mantra.tune_controller_simulation(
        plotResults=plotResults,
        printResults=printResults,
        saveResults=saveResults)
