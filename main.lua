-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local composer = require("composer")

-- Opcional: configura el fondo de pantalla predeterminado
display.setDefault("background", 0, 0, 0) -- negro, puedes cambiarlo si quieres

-- Ajustes de resolución seguros (opcional)
local CW = display.contentWidth
local CH = display.contentHeight

print("App iniciada en resolución:", CW, CH)

-- Iniciar en la escena de portada
composer.gotoScene("scenes.portada")
