print "\n================================================="
print " ManualTracking library -- RunTrackingExperiment "
print "=================================================\n"

# Load mantra.py from Source folder
import os, sys
ResourcesDir = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0, os.path.join(ResourcesDir, 'Source'))
import mantra

# Import function options and run program
import Options
mantra.run_tracking_experiment(
        useSaved = Options.RunTrackingExperiment['useSaved'],
        plotResults = Options.RunTrackingExperiment['plotResults'],
        saveResults = Options.RunTrackingExperiment['saveResults'])
