print "\n================================================="
print " ManualTracking library -- RunTrackingSimulation "
print "=================================================\n"

# Load mantra.py from Source folder
import os, sys
ResourcesDir = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0, os.path.join(ResourcesDir, 'Source'))
import mantra

# Import function options and run program
import Options
mantra.run_tracking_simulation(
        plotResults = Options.RunTrackingSimulation['plotResults'],
        saveResults = Options.RunTrackingSimulation['saveResults'],
        runOnce = True)
