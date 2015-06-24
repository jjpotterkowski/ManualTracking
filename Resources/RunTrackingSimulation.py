print "\n==============================================="
print "ManualTracking library -- RunTrackingSimulation"
print "==============================================="

# Load mantra.py from Source folder
import os, sys
ResourcesDir = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0, os.path.join(ResourcesDir, 'Source'))
import mantra

# Import function options
import Options
plotResults = Options.RTS_plotResults
printResults = Options.RTS_printResults
saveResults = Options.RTS_saveResults
runOnce = True

# Run program
mantra.run_tracking_simulation(
        plotResults=plotResults,
        printResults=printResults,
        saveResults=saveResults,
        runOnce=runOnce)
