import os, sys
import tools


def load_jmodelica(jmodelicaPath):
    os.environ['JMODELICA_BASE'] = jmodelicaPath
    try: 
        os.chdir(os.environ['JMODELICA_BASE'])
    except: 
        print "\nThe JModelica install directory (specified at the top of mantra.py) does not exist."
    else:
        print "\nSetting JModelica paths."
        os.environ['JMODELICA_HOME'] = os.environ['JMODELICA_BASE'] + '\\install'
        os.environ['JMODELICA_PY'] = os.environ['JMODELICA_HOME'] + '\\python'
        os.environ['IPOPT_HOME'] = os.environ['JMODELICA_BASE'] + '\\Ipopt-MUMPS'
        os.environ['MINGW_HOME']= os.environ['JMODELICA_BASE'] + '\\MinGW'
        os.environ['CPPAD_HOME']= os.environ['JMODELICA_HOME'] + '\\ThirdParty\\CppAD'
        os.environ['JAVA_HOME'] = os.environ['JMODELICA_BASE'] + '\\Java\\jre7'
        os.environ['SEPARATE_PROCESS_JVM'] = os.environ['JMODELICA_BASE'] + '\\Java\\jre7'
        os.environ['JPYPE_JVM'] = os.environ['JMODELICA_BASE'] + '\\Java\\jre7-i586\\bin\\client\\jvm.dll'
        os.environ['SUNDIALS_HOME'] = os.environ['JMODELICA_HOME'] + '\\ThirdParty\\Sundials'
        sys.path.insert(0, os.environ['JMODELICA_BASE'])
        sys.path.insert(0, os.environ['JMODELICA_PY'])
        sys.path.insert(0, os.environ['MINGW_HOME'] + '\\bin')
        sys.path.insert(0, os.environ['JAVA_HOME'] + '\\bin')
        sys.path.insert(0, os.environ['JMODELICA_BASE'] + '\\Java\\jre7-i586\\bin\\client')
        sys.path.insert(0, os.environ['JMODELICA_HOME'] + '\\ThirdParty\\CasADi\\lib')
        try: 
            os.environ['PYTHONPATH'] = os.environ['JMODELICA_PY'] + ';' + os.environ['PYTHONPATH']
        except: 
            os.environ['PYTHONPATH'] = os.environ['JMODELICA_PY'] + ';' # PYTHONPATH might not already exist
        print "\nImporting FMI-related modules."
        try:
            global compile_fmu 
            global load_fmu
            global dfo
            from pymodelica import compile_fmu
            from pyfmi import load_fmu
            from pyjmi.optimization import dfo 
        except:       
            print "\nSomething went wrong when importing FMU-related modules."


def compile_fmu_openmodelica(modelicaClass, modelicaFile, saveDir, printVerbose=False):
    if not printVerbose: OLDSTDOUT = tools.disable_console_output()
    OMPython.execute("loadModel(Modelica)")
    OMPython.execute("loadFile(\"" + modelicaFile + "\")")
    OMPython.execute("translateModelFMU(" + modelicaClass + ")")
    fmuName = os.path.join(os.environ['MANTRA_TEMP'], modelicaClass.replace('.', '_')+'.fmu')
    if not printVerbose: tools.enable_console_output(OLDSTDOUT) 

    return fmuName


def compile_fmu_jmodelica(modelicaClass, modelicaFile, saveDir, printVerbose=False):
    if not printVerbose: OLDSTDOUT = tools.disable_console_output()
    fmuName = compile_fmu(modelicaClass, modelicaFile, compile_to=saveDir)
    if not printVerbose: tools.enable_console_output(OLDSTDOUT) 

    return fmuName


def load_fmu_jmodelica(fmuFile, logFile, printVerbose=False):
    if not printVerbose: OLDSTDOUT = tools.disable_console_output()
    FMUMODEL = load_fmu(fmuFile, log_file_name=logFile)
    if not printVerbose: tools.enable_console_output(OLDSTDOUT) 

    return FMUMODEL


def simulate_fmu_jmodelica(FMUMODEL, fmuOpts, startTime, finalTime, controlInput=False, printVerbose=False):
    if not printVerbose: OLDSTDOUT = tools.disable_console_output()
    if controlInput: 
        fmuResults = FMUMODEL.simulate(input=controlInput, options=fmuOpts, start_time=startTime, final_time=finalTime)             
    else: 
        fmuResults = FMUMODEL.simulate(options=fmuOpts, start_time=startTime, final_time=finalTime)             
    if not printVerbose: tools.enable_console_output(OLDSTDOUT) 

#    a = FMUMODEL.get('precision2ndordernm1.tau')
#    print "tau INSIDE simulate_fmu_jmodelica"
#    print a

    return (FMUMODEL, fmuResults)


def minimize_cost_dfo(costFun, x0, lb, ub, printVerbose=False):
    if not printVerbose: OLDSTDOUT = tools.disable_console_output()
    dfoResults = dfo.fmin(costFun, xstart=x0, lb=lb, ub=ub, x_tol=1e-3, f_tol=1e-2, debug=False)
    optParams = [float(k) for k in dfoResults[0]]
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
        print "Solver name not recognized."

    return fmuOpts 


def start_openmodelica_server():
    global OMPython
    print ""
    import OMPython


def stop_openmodelica_server():
    OMPython.execute("quit()")    


#def close_result_file():
#    OMPython.execute("closeSimulationResultFile()")

#    if printMessage: print printMessage[0]
#    if not printVerbose: OLDSTDOUT = tools.disable_console_output()
#    if controlInput: fmuResults = FMUMODEL.simulate(input=controlInput, options=fmuOpts, start_time=startTime, final_time=finalTime)             
#    else: fmuResults = FMUMODEL.simulate(options=fmuOpts, start_time=startTime, final_time=finalTime)             
#    if not printVerbose: tools.enable_console_output(OLDSTDOUT) 
#    if printMessage: print printMessage[1]    
