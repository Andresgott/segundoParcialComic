local M = {}

local sheetOptions = {
    frames = {
        { x=0, y=0, width=40, height=48}, --1 --fila1
        { x=0, y=50, width=55, height=45}, --2 --fila2
        { x=56, y=50, width=55, height=45}, --3 --fila2
        { x=120, y=50, width=55, height=45}, --4  --fila2
        { x=169, y=50, width=60, height=45}, --5 --fila2
        { x=240, y=50, width=55, height=45}, --6 --fila2
        { x=0, y=100, width=42, height=36 }, --7 --fila3
        { x=45, y=100, width=42, height=36 }, --8 --fila3
        { x=86, y=100, width=42, height=36 }, --9 --fila3
        { x=124, y=100, width=42, height=36 }, --10 --fila3
        { x=162, y=100, width=42, height=36 }, --11 --fila3
        { x=0, y=150, width=40, height=32 }, --12 --fila4
        { x=60, y=150, width=42, height=32 }, --13 --fila4
        { x=0, y=184, width=45, height=48}, --14 --fila5
        { x=56, y=196, width=54, height=36}, --15 --fila5
        { x=118, y=196, width=46, height=36}, --16  --fila5
        { x=169, y=196, width=54, height=36}, --17 --fila5
        { x=0, y=240, width=39, height=56 }, --18 --fila6
        { x=45, y=240, width=42, height=56 }, --19 --fila6
        { x=86, y=240, width=42, height=56 }, --20 --fila6
        { x=124, y=240, width=42, height=56 }, --21 --fila6
        { x=0, y=300, width=60, height=48}, --22 --fila7
        { x=70, y=300, width=60, height=48}, --23 --fila7
        { x=140, y=300, width=60, height=48}, --24 --fila7
        { x=225, y=300, width=60, height=48}, --25 --fila7
        { x=280, y=300, width=60, height=48}, --26 --fila7
        { x=350, y=300, width=60, height=48}, --27 --fila7
        { x=0, y=350, width=62, height=48}, --28 --fila8
        { x=57, y=350, width=62, height=48}, --29 --fila8
        { x=118, y=350, width=57, height=48}, --30 --fila8
        { x=170, y=350, width=70, height=48}, --31 --fila8
        { x=0, y=405, width=58, height=42}, --32 --fila9
        { x=57, y=405, width=58, height=42}, --33 --fila9
        { x=120, y=405, width=58, height=42}, --34 --fila9
    }
}

local spideySheet = graphics.newImageSheet("assets/spiderman1.png", sheetOptions)

local sequenceData = {
    {
        name = "kick",
        frames = { 1, 12, 13, 7, 1 },
        time = 3000,
        loopCount = 0
    },

    {
        name="run",
        frames = {3,5,2,3,5,4},
        time = 1000,
        loopCount=0
    },
    {
        name="flip",
        frames = {1,12,8,9,10,11,12,1},
        time = 2000,
        loopCount=0
    },
    {
        name="jump",
        frames = {1,12,7,6},
        time = 3000,
        loopCount=0
    },
    {
        name="crowling",
        frames = {16,15,16,17},
        time = 3000,
        loopCount=0
    },
    {
        name="attack",
        frames = {21,18,19,20},
        time = 3000,
        loopCount=0
    },
    {
        name="flip2",
        frames = {1,12,8,9,26,27,1},
        time = 2000,
        loopCount=0
    },
    {
        name="damage",
        frames = {1,28,29,30,31},
        time = 2000,
        loopCount=0
    },
    {
        name = "swing",
        frames = {32,33,32,34},
        time = 3000,
        loopCount = 0
    }
    

}

function M.new(x, y, animation)
    local spidey = display.newSprite(spideySheet, sequenceData)
    spidey.x = x or display.contentCenterX
    spidey.y = y or display.contentCenterY
    spidey:setSequence(animation or "kick")
    spidey:play()
    return spidey
end

return M
