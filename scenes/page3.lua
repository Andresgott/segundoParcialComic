local composer = require("composer")
local scene = composer.newScene()
local spiderman = require("spiderman")
local animations = require("animations")
local globals = require("globals")

local CW = display.contentWidth
local CH = display.contentHeight
local ACW = display.actualContentWidth
local ACH = display.actualContentHeight

local fondo
local indice = 1

local alarmSound = audio.loadSound("assets/alarm.wav") 


-- Posiciones de zoom para cada viñeta de la imagen grande (page2.png)
local posiciones = {
    {xScale = 1, yScale = 1, x = CW / 2, y = CH / 2},                       -- Vista completa
    {xScale = 1.16, yScale = 4.4, x = 380, y = 2000},                        -- Cuadro 1
    {xScale = 3.6, yScale = 2.4, x = 1175, y = 545},                          -- Cuadro 2
    {xScale = 3.6, yScale = 2.4, x = 390, y = 545},                         -- Cuadro 3
    {xScale = 3.6, yScale = 2.4, x = -405, y = 545},                           -- Cuadro 4
    {xScale = 1.74, yScale = 4.2, x = 580, y = -870},                        -- Cuadro 5
    {xScale = 3.4, yScale = 4.2, x = -360, y = -870},                          -- Cuadro 6
}


local function moverAdelante(e)
    if e.phase == "ended" then
        if indice < #posiciones then
            indice = indice + 1
            local p = posiciones[indice]

            transition.to(fondo, {
                time = 900,
                xScale = p.xScale,
                yScale = p.yScale,
                x = p.x,
                y = p.y,
                transition = easing[globals.animacionSeleccionada]
            })

            if scene.spidey then
                scene.spidey:removeSelf()
                scene.spidey = nil
            end

            if indice == 6 then
                scene.spidey = spiderman.new(100, CH - 100, "run")
                scene.spidey.xScale, scene.spidey.yScale = 4, 4
                animations.traslado(scene.spidey, 120,850) -- velocidad
                scene.view:insert(scene.spidey)

            elseif indice == 3 then
                scene.spidey = spiderman.new(100, CH - 200, "crowling")
                scene.spidey.xScale, scene.spidey.yScale = 4, 4
                animations.traslado(scene.spidey, 50,850) -- velocidad
                scene.view:insert(scene.spidey)

            elseif indice == 5 then
                scene.spidey = spiderman.new(100, 220, "flip")
                scene.spidey.xScale, scene.spidey.yScale = 4, 4
                scene.view:insert(scene.spidey)
            
            elseif indice==7 then
                scene.alarmChannel = audio.play(alarmSound)
            end

        elseif indice == #posiciones then
            audio.stop(alarmSound)
            timer.performWithDelay(1000, function()
                composer.gotoScene("scenes.page4", { effect = globals.efectoSeleccionado, time = 1000 })
            end)
        end
    end
end

function scene:hide(event)
    if event.phase == "will" then
        if scene.alarmChannel then
            audio.stop(scene.alarmChannel)
        end
    end
end

local function moverAtras(e)
    if e.phase == "ended" then
        if indice > 1 then
            indice = indice - 1
            local p = posiciones[indice]
            transition.to(fondo, {
                time = 900,
                xScale = p.xScale,
                yScale = p.yScale,
                x = p.x,
                y = p.y,
                transition = easing[globals.animacionSeleccionada]
            })
        elseif indice == 1 then
            composer.gotoScene("scenes.page2", { effect = globals.efectoSeleccionado, time = 1000 })
        end
    end
end


function scene:create(event)
    local sceneGroup = self.view

    fondo = display.newImageRect(sceneGroup, "assets/page3.png", ACW, ACH)
    fondo.x = posiciones[1].x
    fondo.y = posiciones[1].y
    fondo.xScale = posiciones[1].xScale
    fondo.yScale = posiciones[1].yScale

    -- Flechas
    local flechaIzq = display.newImageRect(sceneGroup, "assets/Flecha_izquierda.png", 100, 130)
    flechaIzq.x = 70
    flechaIzq.y = CH - 70
    flechaIzq:addEventListener("touch", moverAtras)

    local flechaDer = display.newImageRect(sceneGroup, "assets/Flecha_derecha.png", 100, 130)
    flechaDer.x = CW - 70
    flechaDer.y = CH - 70
    flechaDer:addEventListener("touch", moverAdelante)
end

scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)
return scene
