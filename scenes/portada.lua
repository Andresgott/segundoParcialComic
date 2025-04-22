--portada.lua
local composer = require("composer")
local scene = composer.newScene()

local CW = display.contentWidth
local CH = display.contentHeight
local ACW = display.actualContentWidth
local ACH = display.actualContentHeight

-- Función para hacer titilar
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

    -- Evento touch para pasar de escena
    bg:addEventListener("touch", goToPage1)
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
