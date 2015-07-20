print "\n===================================================="
print " ManualTracking library -- TuneControllerSimulation"
print "====================================================\n"

# Load mantra.py from Source folder
import os, sys
ResourcesDir = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0, os.path.join(ResourcesDir, 'Source'))
import mantra

# Import function options and run program
import Options
mantra.tune_controller_simulation(
        plotResults = Options.TuneControllerSimulation['plotResults'],
        saveResults = Options.TuneControllerSimulation['saveResults'])
