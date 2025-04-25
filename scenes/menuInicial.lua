local composer = require("composer")
local scene = composer.newScene()

local globals = require("globals")

local CW = display.contentWidth
local CH = display.contentHeight
local ACW = display.actualContentWidth
local ACH = display.actualContentHeight


local easingOptions = {
    "linear",         -- Movimiento constante, sin aceleración.
    "outBounce",      -- Rebote al final, muy visual.
    "inBounce",       -- Rebote al inicio.
    "inOutBounce",    -- Rebote al inicio y al final.
    "inExpo",         -- Comienza lentísimo y acelera repentinamente.
    "outExpo",        -- Arranca rápido y termina lentamente.
    "inOutBack",      -- Hace una reversa leve antes de avanzar.
    "outElastic",     -- Hace efecto muelle al final, como un resorte.
    "inElastic",      -- Muelle al principio.
}


local effectOptions = {
    "fade", "slideLeft", "slideRight", "zoomInOut", "crossFade", "flip"
}

local easingIndex = 1
local effectIndex = 1

function scene:create(event)
    local sceneGroup = self.view

    -- Fondo
    local fondo = display.newImageRect(sceneGroup, "assets/back1.jpg", ACW, ACH)
    fondo.anchorX = 0
    fondo.anchorY = 0
    fondo.x = 0
    fondo.y = 0

    local title1 = display.newText({
        text = "Animación entre cuadros (easing)",
        x = CW / 2,
        y = 60,
        fontSize = 20
    })
    sceneGroup:insert(title1)

    local easingText = display.newText({
        text = easingOptions[easingIndex],
        x = CW / 2,
        y = 90,
        fontSize = 24
    })
    sceneGroup:insert(easingText)

    local title2 = display.newText({
        text = "Transición entre páginas (efecto)",
        x = CW / 2,
        y = 150,
        fontSize = 20
    })
    sceneGroup:insert(title2)

    local effectText = display.newText({
        text = effectOptions[effectIndex],
        x = CW / 2,
        y = 180,
        fontSize = 24
    })
    sceneGroup:insert(effectText)

    -- Botones de navegación
    local easingLeft = display.newText("←", CW * 0.2, 90, native.systemFontBold, 28)
    local easingRight = display.newText("→", CW * 0.8, 90, native.systemFontBold, 28)
    local effectLeft = display.newText("←", CW * 0.2, 180, native.systemFontBold, 28)
    local effectRight = display.newText("→", CW * 0.8, 180, native.systemFontBold, 28)

    sceneGroup:insert(easingLeft)
    sceneGroup:insert(easingRight)
    sceneGroup:insert(effectLeft)
    sceneGroup:insert(effectRight)

    local function updateTexts()
        easingText.text = easingOptions[easingIndex]
        effectText.text = effectOptions[effectIndex]
    end

    easingLeft:addEventListener("tap", function()
        easingIndex = easingIndex > 1 and easingIndex - 1 or #easingOptions
        updateTexts()
    end)

    easingRight:addEventListener("tap", function()
        easingIndex = easingIndex < #easingOptions and easingIndex + 1 or 1
        updateTexts()
    end)

    effectLeft:addEventListener("tap", function()
        effectIndex = effectIndex > 1 and effectIndex - 1 or #effectOptions
        updateTexts()
    end)

    effectRight:addEventListener("tap", function()
        effectIndex = effectIndex < #effectOptions and effectIndex + 1 or 1
        updateTexts()
    end)

    -- Botón comenzar
    local startBtn = display.newText("Comenzar", CW / 2, CH - 60, native.systemFontBold, 28)
    startBtn:setFillColor(0, 1, 0)
    sceneGroup:insert(startBtn)

    startBtn:addEventListener("tap", function()
        globals.animacionSeleccionada = easingOptions[easingIndex]
        globals.efectoSeleccionado = effectOptions[effectIndex]
        composer.gotoScene("scenes.portada", {
            effect = globals.efectoSeleccionado,
            time = 700
        })
    end)
end

scene:addEventListener("create", scene)
return scene
