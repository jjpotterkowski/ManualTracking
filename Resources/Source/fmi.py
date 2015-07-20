import os, sys
import tools


def compile_fmu_openmodelica(modelicaClass, modelicaFile, saveDir, printVerbose=False):
    if not printVerbose: OLDSTDOUT = tools.disable_console_output()
    print "Compiling " + modelicaClass + " in"
    print saveDir
    print ""
    OMPython.execute("loadModel(Modelica)")
    OMPython.execute("loadFile(\"" + modelicaFile + "\")")
    OMPython.execute("translateModelFMU(" + modelicaClass + ")")
    fmuName = os.path.join(os.environ['MANTRA_TEMP'], modelicaClass.replace('.', '_')+'.fmu')
    if not printVerbose: tools.enable_console_output(OLDSTDOUT) 

    return fmuName


def load_fmu_pyfmi(fmuFile, logFile, printVerbose=False):
    if not printVerbose: OLDSTDOUT = tools.disable_console_output()
    from pyfmi import load_fmu   
    print "Loading " + fmuFile
    print ""
    FMUMODEL = load_fmu(fmuFile, log_file_name=logFile)
    if not printVerbose: tools.enable_console_output(OLDSTDOUT) 

    return FMUMODEL


def simulate_fmu(FMUMODEL, fmuOpts, startTime, finalTime, controlInput=False, printVerbose=False):
    if not printVerbose: OLDSTDOUT = tools.disable_console_output()
    if controlInput: 
        fmuResults = FMUMODEL.simulate(input=controlInput, options=fmuOpts, start_time=startTime, final_time=finalTime)             
    else: 
        fmuResults = FMUMODEL.simulate(options=fmuOpts, start_time=startTime, final_time=finalTime)             
    if not printVerbose: tools.enable_console_output(OLDSTDOUT) 

    return (FMUMODEL, fmuResults)


def minimize_cost_scipy(costFun, x0, optMethod, printVerbose=False):
    if not printVerbose: OLDSTDOUT = tools.disable_console_output()
    from scipy.optimize import minimize
    import numpy as np
    dfoResults = minimize(costFun, x0, method=optMethod, options={'xtol': 1e-5, 'disp': True})
    optParams = [float(k) for k in dfoResults['x']]
    if not printVerbose: tools.enable_console_output(OLDSTDOUT) 

    return optParams


def set_fmu_options(initializeFMU, resultFile, fmuMaxh, solverName):
    if solverName == 'Dopri5':
        fmuOpts = {'initialize': initializeFMU, 
            'result_file_name': resultFile, 
            'solver': 'Dopri5',
            'Dopri5_options': {'maxh': fmuMaxh}} 
    elif solverName == 'CVode':
        fmuOpts = {'initialize': initializeFMU, 
            'result_file_name': resultFile, 
            'CVode_options': {'maxh': fmuMaxh}} 
    elif solverName == 'ExplicitEuler':
        fmuOpts = {'initialize': initializeFMU, 
            'result_file_name': resultFile, 
            'solver': 'ExplicitEuler',
            'ExplicitEuler_options': {'h': fmuMaxh}} 
    else:
        print "Solver name not recognized.\n"

    return fmuOpts 


def start_openmodelica_server():
    global OMPython
    import OMPython


def stop_openmodelica_server():
    OMPython.execute("quit()")
