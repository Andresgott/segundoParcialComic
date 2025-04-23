local composer = require("composer")
local spiderman = require("spiderman")
local animations = require("animations")
local globals = require("globals")
local scene = composer.newScene()

local CW = display.contentWidth
local CH = display.contentHeight
local ACW = display.actualContentWidth
local ACH = display.actualContentHeight

local function moverAdelante(e)
    if e.phase == "ended" then
        composer.gotoScene("scenes.page2", {
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
end

function scene:create(event)
    local sceneGroup = self.view

    -- Fondo
    local fondo = display.newImageRect(sceneGroup, "assets/page1.png", ACW, ACH)
    fondo.anchorX = 0
    fondo.anchorY = 0
    fondo.x = 0
    fondo.y = 0

    -- Imagen principal (cuadro grande)
    local cuadro = display.newImageRect(sceneGroup, "assets/mainPage1.png", 660, 624)
    cuadro.x = CW / 2 
    cuadro.y = CH / 2 + 145
    cuadro.alpha = 0

    transition.to(cuadro, {
        delay = 500,
        time = 1800,
        alpha = 1,
        iterations = 20,
        transition = easing.continuousLoop,
        onRepeat = function()
            transition.to(cuadro, { time = 1000, alpha = 0.5 })
            transition.to(cuadro, { delay = 1000, time = 1000, alpha = 1 })
        end
    })

    -- Sello giratorio
    local sello = display.newImageRect(sceneGroup, "assets/sellopage1.png", 150, 150)
    sello.x = 140
    sello.y = 120
    sello.alpha = 0

    transition.to(sello, {
        delay = 1000,
        time = 800,
        alpha = 1,
        onComplete = function()
            transition.to(sello, { rotation = 360, time = 4000, iterations = 0 })
        end
    })

    -- Botón "Now Begin"
    local boton = display.newImageRect(sceneGroup, "assets/begin.png", 210, 80)
    boton.x = CW - 195
    boton.y = CH - 100
    boton.alpha = 0

    transition.to(boton, {
        delay = 1500,
        time = 800,
        alpha = 1,
        onComplete = function()
            transition.to(boton, {
                time = 1000,
                iterations = 0,
                transition = easing.continuousLoop,
                onRepeat = function()
                    transition.to(boton, { time = 500, xScale = 1.1, yScale = 1.1 })
                    transition.to(boton, { delay = 500, time = 500, xScale = 1.0, yScale = 1.0 })
                end
            })
        end
    })

    local spidey5 = spiderman.new(ACW * 0.3, ACH *0.95, "crowling")
    spidey5.xScale=2.7
    spidey5.yScale=2.7

    boton:addEventListener("touch", moverAdelante)
    animations.traslado(spidey5,50,850)
end

scene:addEventListener("create", scene)
return scene
