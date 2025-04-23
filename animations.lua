local M = {}

function M.columpiar(obj)
    local paso = 40         
    local delay = 600        
    local yMin = 100
    local yMax = 150
    local rotacion = 5    
    local haciaDerecha = true

    local function mover()
        if obj.x >= 850 then return end

        local nuevaRot = haciaDerecha and rotacion or -rotacion
        haciaDerecha = not haciaDerecha

        local nuevaY = haciaDerecha and yMin or yMax

        transition.to(obj, {
            time = delay,
            x = obj.x + paso,
            y = nuevaY,
            rotation = nuevaRot,
            transition = easing.inOutSine,
            onComplete = mover
        })
    end

    obj.x = 0
    obj.y = (yMin + yMax) / 2
    mover()
end


function M.traslado(obj, velocidad, destinoX, callback)
    destinoX = destinoX or display.ActualContentWidth + 50  -- sale del margen por derecha
    velocidad = velocidad or 100                      -- por defecto 100px/s

    local distancia = destinoX - obj.x
    local tiempo = (math.abs(distancia) / velocidad) * 1000  

    transition.to(obj, {
        x = destinoX,
        time = tiempo,
        transition = easing.linear,
    })
end


return M
