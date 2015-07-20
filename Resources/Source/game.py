# Background hatch marks and preview "snake"
topHatches = True # show hatche marks along top of the display
middleHatches = False # show hatch marks along middle of the display 
bottomHatches = True # show hatch marks along bottom of the display
previewCircles = 15 # number of separate circles to use for preview
linearGradient = False # black-white transition is linear or geometric
flattenedPreview = False # show preview only along horizontal axis 

# Tracking display dimensions
winWidth = 1200 # [pixels] width of tracking display
winHeight = int((3.0/8.0)*winWidth) # [pixels] height of tracking display
lineWidth = 2 # [pt] width of lines in tracking display
unitLength = int(winHeight/12.0) # [pixels/LengthUnits{r(t) and y(t)}]
pxPerHatch = 100 # [pixels] distance between hatch marks

# Input and display gains
inputGain = 4 # scales user input to form command to controlled element
displayGain = int(winWidth/6.0) # [pixels] scales signals to display
autoScale = True # if true, use parameters below to calculate gains
pixelDist = winWidth/2.0 # [pixels]
ymoveTime = 0.75 # [sec] time taken by controlled element to travel pixelDist
rmoveTime = 1.5 # [sec] time taken by reference signal to travel pixelDist

# Colors
blackColor = (0, 0, 0)
redColor = (255, 0, 0)
greenColor = (0, 255, 0)
blueColor = (0, 0, 255)
greyColor = (128, 128, 128)
whiteColor = (255, 255, 255)
bgColor = blackColor
fgColor = whiteColor
textColor = greyColor

# Derived settings
halfWinWidth = int(winWidth/2.0)
halfWinHeight = int(winHeight/2.0)
halfUnitLength = int(unitLength/2.0)
buffWidth = 4*lineWidth
halfBuffWidth = int(buffWidth/2.0)
numHatches = 2*(halfWinWidth/pxPerHatch + 1)
hatchLength = int(unitLength*(2.0/3.0))
halfHatchLength = int(hatchLength/2.0)

# Import modules
import csv, numpy, os, pygame, random, sys, time
import fmi, tools

# Directories
tempDir = os.environ['MANTRA_TEMP']
dataDir = os.environ['MANTRA_DATA']


def run_tracking_experiment(elementModel, modelicaFile):
    global fmuOpts
    global FPSCLOCK
    global DISPLAYSURF
    global JOYOBJECT
    global FMUMODEL
    global u_hist
    global y_hist

    # Calculate variables for preview circles
    calculate_preview_parameters()

    # Compile and initialize controlled element dynamic model
    logFile = os.path.join(tempDir, elementModel.replace('.', '_') + '_log.txt')
    resultsFile = os.path.join(tempDir, elementModel.replace('.', '_') + '_results.txt')
    fmuOpts = fmi.set_fmu_options(False, resultsFile, stepTime, solverName='CVode')
    fmuName = fmi.compile_fmu_openmodelica(elementModel, modelicaFile, saveDir=tempDir)
    FMUMODEL = fmi.load_fmu_pyfmi(fmuName, logFile)
    FMUMODEL.initialize()

    # Calculate input and display gains
    calculate_gains(elementModel=elementModel, saveDir=tempDir)

    # Look for joystick input device
    pygame.init()
    JOYOBJECT = get_input_device()

    # Allow user to initiate experiment
    raw_input("Press 'Enter' to bring up the display, then press any key except 'q' to start the experiment.\n")

    # Start up pygame window
    FPSCLOCK = pygame.time.Clock()
    DISPLAYSURF = pygame.display.set_mode((winWidth, winHeight))
    pygame.display.set_caption('Python manual tracking (pymantra) task')

    # Run each frame of tracking experiment
    clear_tracking_display()
    import time
    a = time.time()
    OLDSTDOUT = tools.disable_console_output()
    for frame_current in frame_hist[0:-1]:
        run_one_frame(frame_current)
    tools.enable_console_output(OLDSTDOUT)
    print time.time() - a
    exit_tracking_program()

    return (u_hist, y_hist)


def calculate_preview_parameters():
    global previewInterval
    global previewInstants
    global previewColors
    
    previewInterval = float(previewTime)/previewCircles
    previewInstants = []
    for k in range(previewCircles):
        previewInstants.append((k+1)*previewInterval)
    previewColors = []
    for k in range(previewCircles):
        if linearGradient: 
            colorFrac = int(255*(previewCircles-k)/(previewCircles+1))
        else: 
            colorFrac = 255/(k+2)
        previewColors.append((colorFrac, colorFrac, colorFrac))


def calculate_gains(elementModel, saveDir):
    global FMUMODEL
    global inputGain
    global displayGain

    if not autoScale:
        inputGain = inputGain 
        displayGain = displayGain 
    else:
        rmoveSteps = int(rmoveTime/stepTime)
        maxMove = 0
        for frameNum in range(len(r_hist) - rmoveSteps):
            currentMove = abs(r_hist[frameNum + rmoveSteps] - r_hist[frameNum])
            maxMove = max([maxMove, currentMove])
        displayGain = pixelDist/maxMove # maximum distance reference signal can move in rmoveTime [sec] is pixelDist
        resultsFile = os.path.join(saveDir, elementModel.replace('.', '_') + '_step_results.txt')
        fmuOpts = fmi.set_fmu_options(False, resultsFile, stepTime, solverName='CVode')
        fmuInput = numpy.transpose(numpy.vstack(([0,ymoveTime], [1,1]))) # step input
        (FMUMODEL, fmuResults) = fmi.simulate_fmu(FMUMODEL, fmuOpts, 0, ymoveTime, controlInput=(['u'], fmuInput))
        ymoveDist = fmuResults['y'][-1] # distance moved by controlled element when step input is applied for ymoveTime
        unitDist = pixelDist/displayGain 
        inputGain = unitDist/ymoveDist # controlled element can move unitDist [scaled pixels] in time ymoveTime [sec]

        # Reset and reinitialize the controlled element FMU (otherwise the controlled element starts with a nonzero initial condition)
        FMUMODEL.reset()
        FMUMODEL.initialize()
        

def get_input_device():
    pygame.joystick.init()
    print "Checking for input devices.\n"
    try:
        JOYOBJECT = pygame.joystick.Joystick(0)
        JOYOBJECT.init()        
        print "Joystick detected. Use joystick or keyboard.\n"
        print "Notes:"
        print "Extra SDL_ messages printed to the console are harmless, but they can be avoided by installing the newest version of pygame). Using the joystick should yield better result than the keyboard for tune_manual_controller().\n"
    except:
        JOYOBJECT = False
        print "No joystick detected. Use keyboard.\n"
        print "Notes:"
        print "The tune_manual_controller() method may give poor results because the discontinuous keyboard input cannot be well-represented by continuous controller models that are provided in the ManualTracking library.\n"

    return JOYOBJECT


def run_one_frame(frame_current):
    draw_tracking_objects(frame_current)
    if frame_current == 0: wait_for_keypress()
    get_user_input(frame_current)
    FPSCLOCK.tick_busy_loop(frameRate)
    erase_tracking_objects()
    update_cursor_position(frame_current)


def update_cursor_position(frameIn):
    global FMUMODEL
    global u_hist
    global y_hist

    currentFrame = frameIn
    nextFrame = currentFrame + 1

    # Get input signal
    t_input = t_hist[currentFrame:nextFrame]
    u_input = u_hist[currentFrame:nextFrame][0] + w_hist[currentFrame:nextFrame][0]
    fmuInput = numpy.transpose(numpy.vstack((t_input, u_input)))

    # Simulate the model response to input
    (FMUMODEL, fmuResults) = fmi.simulate_fmu(FMUMODEL, fmuOpts, t_hist[currentFrame], t_hist[nextFrame], controlInput=(['u'], fmuInput))

    # Extract simulation results
    y_hist[nextFrame] = fmuResults['y'][-1]


def draw_tracking_objects(frameIn):
    global TARGETRECT
    global CURSORRECT
    global ALLRECTS
    global displayGain

    targetCenter = (halfWinWidth + int(displayGain*(r_hist[frameIn] - y_hist[frameIn])), halfWinHeight)
    cursorCenter = (halfWinWidth, halfWinHeight)
    if frameIn == 0:
        TARGETRECTPREV = get_object_rect(targetCenter, 4*unitLength+buffWidth, 4*unitLength+buffWidth)
        CURSORRECTPREV = get_object_rect(cursorCenter, 6*unitLength+buffWidth, 6*unitLength+buffWidth)
    else:
        TARGETRECTPREV = TARGETRECT
        CURSORRECTPREV = CURSORRECT
    TARGETRECT = get_object_rect(targetCenter, 4*unitLength+buffWidth, 4*unitLength+buffWidth)
    CURSORRECT = get_object_rect(cursorCenter, 6*unitLength+buffWidth, 6*unitLength+buffWidth)

    # Draw hatch marks
    HATCHRECT = get_object_rect((halfWinWidth, halfWinHeight), buffWidth, buffWidth) # small, arbitrary rect to initialize HATCHRECT
    if topHatches: HATCHRECT.union_ip(get_object_rect((halfWinWidth, halfHatchLength), winWidth, hatchLength+buffWidth))
    if middleHatches: HATCHRECT.union_ip(get_object_rect((halfWinWidth, halfWinHeight), winWidth, hatchLength+buffWidth))
    if bottomHatches: HATCHRECT.union_ip(get_object_rect((halfWinWidth, winHeight-halfHatchLength), winWidth, hatchLength+buffWidth))        
    if backgroundVisible:
        pxOrigin = halfWinWidth + int(numpy.mod(-displayGain*y_hist[frameIn], pxPerHatch))
        if topHatches: pygame.draw.line(DISPLAYSURF, fgColor, (pxOrigin, 0), (pxOrigin, hatchLength), lineWidth)
        if middleHatches: pygame.draw.line(DISPLAYSURF, fgColor, (pxOrigin, halfWinHeight-halfHatchLength), (pxOrigin, halfWinHeight+halfHatchLength), lineWidth)
        if bottomHatches: pygame.draw.line(DISPLAYSURF, fgColor, (pxOrigin, winHeight-hatchLength), (pxOrigin, winHeight), lineWidth)
        for hatchNum in range(numHatches):
            pxHatchLeft = pxOrigin + (hatchNum+1)*pxPerHatch
            pxHatchRight = pxOrigin - (hatchNum+1)*pxPerHatch
            if topHatches:
                pygame.draw.line(DISPLAYSURF, fgColor, (pxHatchLeft, 0), (pxHatchLeft, hatchLength), lineWidth)
                pygame.draw.line(DISPLAYSURF, fgColor, (pxHatchRight, 0), (pxHatchRight, hatchLength), lineWidth)
            if middleHatches:
                pygame.draw.line(DISPLAYSURF, fgColor, (pxHatchLeft, halfWinHeight-halfHatchLength), (pxHatchLeft, halfWinHeight+halfHatchLength), lineWidth)
                pygame.draw.line(DISPLAYSURF, fgColor, (pxHatchRight, halfWinHeight-halfHatchLength), (pxHatchRight, halfWinHeight+halfHatchLength), lineWidth)
            if bottomHatches:
                pygame.draw.line(DISPLAYSURF, fgColor, (pxHatchLeft, winHeight-hatchLength), (pxHatchLeft, winHeight), lineWidth)
                pygame.draw.line(DISPLAYSURF, fgColor, (pxHatchRight, winHeight-hatchLength), (pxHatchRight, winHeight), lineWidth)

    # Draw preview circles
    PREVIEWRECT = get_object_rect(targetCenter, 4*unitLength+buffWidth, 4*unitLength+buffWidth)
    if previewTime > 0:
        t_previewTargets = [t_hist[frameIn]+k for k in previewInstants]
        r_previewTargets = numpy.interp(t_previewTargets, t_hist, r_hist)
        for circleNum in range(previewCircles)[::-1]: # go in reverse order 
            if flattenedPreview: 
                centery = halfWinHeight
            else: 
                centery = int(halfWinHeight - (halfWinHeight+2*unitLength)*(circleNum+1.0)/(previewCircles+1.0))
            previewCenter = (halfWinWidth + int(displayGain*(r_previewTargets[circleNum] - y_hist[frameIn])), centery)
            fillRect = pygame.Rect(0, 0, abs(displayGain*(r_previewTargets[circleNum]-r_hist[frameIn])), 4*unitLength)
            fillRect.left = int(displayGain*(min([r_previewTargets[circleNum], r_hist[frameIn]]) - y_hist[frameIn])) + halfWinWidth
            fillRect.centery = centery
            pygame.draw.circle(DISPLAYSURF, previewColors[circleNum], previewCenter, 2*unitLength, 0)
            PREVIEWRECT.union_ip(get_object_rect(previewCenter, 4*unitLength+4*buffWidth, 4*unitLength+buffWidth))
        
    # Draw arrow if target is off screen ... these get erased by TARGETRECT because it stays at edge of screen
    if targetCenter[0] < -2*unitLength-buffWidth:
        pointList = offset_tuple_list([(-2*unitLength,0), (0,2*unitLength), (0,unitLength), (2*unitLength,unitLength), (2*unitLength,-unitLength), (0,-unitLength), (0,-2*unitLength)], (2*unitLength+0.5*buffWidth,halfWinHeight))
        pygame.draw.polygon(DISPLAYSURF, textColor, pointList)
    if targetCenter[0] > winWidth+2*unitLength+buffWidth:
        pointList = offset_tuple_list([(2*unitLength,0), (0,2*unitLength), (0,unitLength), (-2*unitLength,unitLength), (-2*unitLength,-unitLength), (0,-unitLength), (0,-2*unitLength)], (winWidth-2*unitLength-0.5*buffWidth,halfWinHeight))
        pygame.draw.polygon(DISPLAYSURF, textColor, pointList)

    # Draw target
    pygame.draw.circle(DISPLAYSURF, bgColor, targetCenter, 2*unitLength, 0)
    pygame.draw.circle(DISPLAYSURF, fgColor, targetCenter, 3*lineWidth, 0)
    pygame.draw.circle(DISPLAYSURF, fgColor, targetCenter, 2*unitLength, lineWidth)

    # Draw cursor
    pygame.draw.circle(DISPLAYSURF, fgColor, cursorCenter, unitLength, lineWidth)
    pygame.draw.line(DISPLAYSURF, fgColor, offset_tuple(cursorCenter, (0, -halfUnitLength)), offset_tuple(cursorCenter, (0, -3*unitLength)), lineWidth)
    pygame.draw.line(DISPLAYSURF, fgColor, offset_tuple(cursorCenter, (halfUnitLength, 0)), offset_tuple(cursorCenter, (3*unitLength, 0)), lineWidth)
    pygame.draw.line(DISPLAYSURF, fgColor, offset_tuple(cursorCenter, (0, halfUnitLength)), offset_tuple(cursorCenter, (0, 3*unitLength)), lineWidth)
    pygame.draw.line(DISPLAYSURF, fgColor, offset_tuple(cursorCenter, (-halfUnitLength, 0)), offset_tuple(cursorCenter, (-3*unitLength, 0)), lineWidth)

    # Update parts of display that have changed
    ALLRECTS = TARGETRECT.unionall([CURSORRECT, TARGETRECTPREV, CURSORRECTPREV, HATCHRECT, PREVIEWRECT])
    pygame.display.update(ALLRECTS)


def erase_tracking_objects():
    global ALLRECTS
    DISPLAYSURF.fill(bgColor, ALLRECTS)


def clear_tracking_display():
    DISPLAYSURF.fill(bgColor)


def get_keyboard_input():
    keydownList = []
    keyupList = []
    for event in pygame.event.get():
        if event.type == pygame.QUIT: 
            exit_tracking_program()
        elif event.type == pygame.KEYDOWN:
            if event.key in (pygame.K_ESCAPE, pygame.K_q): 
                exit_tracking_program()
            else: 
                keydownList.append(event.key)
        elif event.type == pygame.KEYUP: keyupList.append(event.key)

    return (keydownList, keyupList)


def get_joystick_input():
    global JOYOBJECT

    pygame.event.pump()
    lateralAxis = JOYOBJECT.get_axis(0) # only using the lateral axis for pymantra

    return lateralAxis


def get_user_input(frameIn):
    global inputGain
    global u_current 
    global u_hist
    global JOYOBJECT

    (keydownList, keyupList) = get_keyboard_input()
    if pygame.K_LEFT in keyupList: u_current = 0.
    if pygame.K_RIGHT in keyupList: u_current = 0.
    if pygame.K_LEFT in keydownList: u_current = -1.
    if pygame.K_RIGHT in keydownList: u_current = 1.
    if JOYOBJECT: u_current = get_joystick_input()
    u_hist[frameIn] = inputGain*u_current


def offset_tuple(tup, offset):
    return tuple(map(lambda x, y: x + y, tup, offset))


def offset_tuple_list(tupList, offset):
    offsetList = []
    for oneTup in tupList:
        offsetTup = offset_tuple(oneTup, offset)
        offsetList.append(offsetTup)
    return offsetList


def get_object_rect(centerIn, widthIn, heightIn):
    centerLimited = (int(numpy.clip(centerIn[0], widthIn/2.0, winWidth-widthIn/2.0)), int(centerIn[1]))
    OBJECTRECT = pygame.Rect(offset_tuple(centerLimited, (int(-widthIn/2.0), int(-heightIn/2.0))), offset_tuple(centerLimited, (int(widthIn), int(heightIn))))

    return OBJECTRECT


def wait_for_keypress():
    waiting = True
    while waiting:
        event = pygame.event.wait()
        if event.type == pygame.KEYDOWN:
            waiting = False
        FPSCLOCK.tick_busy_loop(10)
    

def exit_tracking_program():
    pygame.quit()
