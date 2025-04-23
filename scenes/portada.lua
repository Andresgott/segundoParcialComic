local composer = require("composer")
local spiderman = require("spiderman")  -- o "spiderman" si está fuera de scenes
local animations = require("animations")
local scene = composer.newScene()

local CW = display.contentWidth
local CH = display.contentHeight
local ACW = display.actualContentWidth
local ACH = display.actualContentHeight

local function titilar(obj)
    transition.to(obj, {
        time = 1000,
        alpha = 0.3,
        onComplete = function()
            transition.to(obj, {
                time = 1000,
                alpha = 1.5,
                onComplete = function()
                    titilar(obj)
                end
            })
        end
    })
end

local function goToPage1(e)
    if e.phase == "ended" then
        composer.gotoScene("scenes.page1", { effect = "slideLeft", time = 2000 })
    end
    return true
end

function scene:create(event)
    local sceneGroup = self.view

    -- Fondo
    local bg = display.newImageRect(sceneGroup, "assets/bg.png", CW, CH)
    bg.x = CW / 2
    bg.y = CH / 2

    -- Imágenes superpuestas
    local face = display.newImageRect(sceneGroup, "assets/spiderFace.png", 100, 160)
    face.x = CW * 0.06
    face.y = CH * 0.11
    titilar(face)

    local caption1 = display.newImageRect(sceneGroup, "assets/dialog1.png", 315, 105)
    caption1.x = CW * 0.31
    caption1.y = CH * 0.29
    titilar(caption1)

    local caption2 = display.newImageRect(sceneGroup, "assets/dialog2.png", 350, 120)
    caption2.x = CW * 0.28
    caption2.y = CH * 0.90
    titilar(caption2)

    local spidey = spiderman.new(ACW * 0.5, ACH * 0.5, "swing")
    spidey.xScale = 2.5
    spidey.yScale = 2.5

    local spidey1 = spiderman.new(ACW * 0.3, ACH *0.3, "run")
    spidey1.xScale = 2.5
    spidey1.yScale = 2.5

    local spidey2 = spiderman.new(ACW * 0.1, ACH *0.1, "flip2")
    spidey2.xScale = 2.5
    spidey2.yScale = 2.5

    local spidey3 = spiderman.new(ACW * 0.7, ACH *0.7, "jump")
    spidey3.xScale = 2.5
    spidey3.yScale = 2.5

    local spidey4 = spiderman.new(ACW * 0.3, ACH *0.9, "crowling")
    spidey4.xScale = 2.5
    spidey4.yScale = 2.5

    local spidey5 = spiderman.new(ACW * 0.9, ACH *0.1, "attack")
    spidey5.xScale = 2.5
    spidey5.yScale = 2.5

    sceneGroup:insert(spidey)
    sceneGroup:insert(spidey1)
    sceneGroup:insert(spidey2)
    sceneGroup:insert(spidey3)
    sceneGroup:insert(spidey4)
    sceneGroup:insert(spidey5)

    animations.columpiar(spidey)
    animations.traslado(spidey1,150,850)
    animations.traslado(spidey4,50,850)
    animations.traslado(spidey2,150,150)

    -- Navegación al tocar fondo
    bg:addEventListener("touch", goToPage1)
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
