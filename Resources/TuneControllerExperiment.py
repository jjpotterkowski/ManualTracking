print "\n===================================================="
print " ManualTracking library -- TuneControllerExperiment"
print "====================================================\n"

# Load mantra.py from Source folder
import os, sys
ResourcesDir = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0, os.path.join(ResourcesDir, 'Source'))
import mantra

# Import function options and run program
import Options
mantra.tune_controller_experiment(
        useSaved = Options.TuneControllerExperiment['useSaved'], 
        plotResults = Options.TuneControllerExperiment['plotResults'],
        saveResults = Options.TuneControllerExperiment['saveResults'])
