local composer = require("composer")
local scene = composer.newScene()

local CW = display.contentWidth
local CH = display.contentHeight
local ACW = display.actualContentWidth
local ACH = display.actualContentHeight

local fondo
local indice = 1

-- Posiciones de zoom para cada viñeta de la imagen grande (page2.png)
local posiciones = {
    {xScale = 1, yScale = 1, x = CW / 2, y = CH / 2},                       -- Vista completa
    {xScale = 2.3, yScale = 3.4, x = 760, y = 1540},                        -- Cuadro 1
    {xScale = 2.3, yScale = 3.4, x = 0, y = 1540},                          -- Cuadro 2
    {xScale = 2.3, yScale = 3.4, x = 760, y = 510},                         -- Cuadro 3
    {xScale = 2.3, yScale = 3.4, x = 0, y = 510},                           -- Cuadro 4
    {xScale = 2.3, yScale = 3.4, x = 760, y = -525},                        -- Cuadro 5
    {xScale = 2.3, yScale = 3.4, x = 0, y = -525},                          -- Cuadro 6
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
                transition = easing.outQuad
            })
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
                transition = easing.outQuad
            })
        elseif indice == 1 then
            -- Cambiar a página anterior si ya está en la vista completa
            composer.gotoScene("scenes.page3", { effect = "slideRight", time = 1000 })
        end
    end
end


function scene:create(event)
    local sceneGroup = self.view

    fondo = display.newImageRect(sceneGroup, "assets/page4.png", ACW, ACH)
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
