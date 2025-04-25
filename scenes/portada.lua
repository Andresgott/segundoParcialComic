local composer = require("composer")
local spiderman = require("spiderman") 
local animations = require("animations")
local globals = require("globals")
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
        composer.gotoScene("scenes.page1", {
            effect = globals.efectoSeleccionado,
            time = 300,
            onComplete = function()
                -- Transición personalizada usando easing
                transition.to(scene.view, {
                    time = 1000,
                    x = -display.contentWidth,
                    transition = easing[globals.animacionSeleccionada]
                })
            end
        })
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

    local spidey = spiderman.new(ACW * 0.2, ACH * 0.5, "swing")
    spidey.xScale = 2.5
    spidey.yScale = 2.5



    sceneGroup:insert(spidey)

    animations.columpiar(spidey)

    -- Navegación al tocar fondo
    bg:addEventListener("touch", goToPage1)

    -- Flecha de regreso a portada
    local flechaPortada = display.newImageRect(sceneGroup, "assets/Flecha_izquierda.png", 100, 130)
    flechaPortada.x = 70
    flechaPortada.y = CH - 70
    flechaPortada.alpha = 0

    transition.to(flechaPortada, {
        delay = 1800,
        time = 800,
        alpha = 1
    })

    flechaPortada:addEventListener("touch", function(e)
        if e.phase == "ended" then
            composer.gotoScene("scenes.menuInicial", {
                effect = globals.efectoSeleccionado,
                time = 1000
            })
        end
        return true
    end)
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
