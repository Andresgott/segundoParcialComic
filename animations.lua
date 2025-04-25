local M = {}

function M.columpiar(obj)
    if not obj or not obj.x then return end

    local radio = 300
    local altura = obj.y
    local velocidadX = 2
    local angulo = 0
    local direccion = 1

    local function moverPaso()
        if not obj or not obj.x then return end 
        if obj.x > display.contentWidth + 100 then return end

        angulo = angulo + 2 * direccion
        obj.x = obj.x + velocidadX
        obj.y = altura + radio * math.cos(math.rad(angulo))

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
