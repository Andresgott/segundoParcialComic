local M = {}

function M.columpiar(obj)
    local radio = 300        -- amplitud del arco
    local altura = obj.y      -- altura base
    local velocidadX = 2      -- cuánto avanza en X por cada paso
    local angulo = 0
    local direccion = 1

    local function moverPaso()
        if obj.x > display.contentWidth + 100 then return end

        angulo = angulo + 2 * direccion

        -- Avanza gradualmente hacia la derecha
        obj.x = obj.x + velocidadX

        -- Oscila en Y como un columpio
        obj.y = altura + radio * math.cos(math.rad(angulo))

        -- Cambiar dirección del ángulo (oscilación)
        if angulo >= 45 then
            direccion = -1
        elseif angulo <= -45 then
            direccion = 1
        end

        timer.performWithDelay(20, moverPaso)
    end

    moverPaso()
end




function M.traslado(obj, velocidad, destinoX, callback)
    destinoX = destinoX or display.ActualContentWidth + 50 
    velocidad = velocidad or 100                      

    local distancia = destinoX - obj.x
    local tiempo = (math.abs(distancia) / velocidad) * 1000  

    transition.to(obj, {
        x = destinoX,
        time = tiempo,
        transition = easing.linear,
    })
end


return M
