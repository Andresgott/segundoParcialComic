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

-- Posiciones de zoom para cada viñeta de la imagen grande (page2.png)
local posiciones = {
    {xScale = 1, yScale = 1, x = CW / 2, y = CH / 2},                       -- Vista completa
    {xScale = 2.3, yScale = 3.2, x = 760, y = 1550},                        -- Cuadro 1
    {xScale = 2.3, yScale = 3.2, x = 0, y = 1550},                          -- Cuadro 2
    {xScale = 2.3, yScale = 3.2, x = 760, y = 510},                         -- Cuadro 3
    {xScale = 2.3, yScale = 3.2, x = 0, y = 510},                           -- Cuadro 4
    {xScale = 2.3, yScale = 3.2, x = 760, y = -530},                        -- Cuadro 5
    {xScale = 2.3, yScale = 3.2, x = 0, y = -530},                          -- Cuadro 6
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

            -- Borrar spidermans anteriores si es necesario
            if scene.spidey then
                scene.spidey:removeSelf()
                scene.spidey = nil
            end

            -- Crear Spider-Man según el índice
            if indice == 6 then
                scene.spidey = spiderman.new(100, CH - 100, "attack")
                scene.spidey.xScale, scene.spidey.yScale = 4, 4
                scene.view:insert(scene.spidey)

            elseif indice == 3 then
                scene.spidey = spiderman.new(100, CH - 200, "kick")
                scene.spidey.xScale, scene.spidey.yScale = 4, 4
                scene.view:insert(scene.spidey)

            elseif indice == 5 then
                scene.spidey = spiderman.new(0, 120, "swing")
                scene.spidey.xScale, scene.spidey.yScale = 4, 4
                animations.columpiar(scene.spidey)
                scene.view:insert(scene.spidey)
            end

        elseif indice == #posiciones then
            timer.performWithDelay(1000, function()
                composer.gotoScene("scenes.page3", { effect = globals.efectoSeleccionado, time = 1000 })
            end)
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
            -- Cambiar a página anterior si ya está en la vista completa
            composer.gotoScene("scenes.page1", { effect = globals.efectoSeleccionado, time = 1000 })
        end
    end
end

function scene:create(event)
    local sceneGroup = self.view

    fondo = display.newImageRect(sceneGroup, "assets/page2.png", ACW, ACH)
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
return scene
