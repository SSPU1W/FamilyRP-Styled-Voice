-- Kodak's FamilyRP Styled Voice. Released with permission.  Disord: Kodaddy#5552

local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 15
local displayIDHeight = 1.5 --Height of ID above players head(starts at center body mass)
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do
        for i=0,99 do
            N_0x31698aa80e0223f8(i)
        end
        for id = 0, 31 do
            if  ((NetworkIsPlayerActive( id )) and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) then
                ped = GetPlayerPed( id )
                blip = GetBlipFromEntity( ped ) 
 
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				local takeaway = 0.95

                if(ignorePlayerNameDistance) then
					if NetworkIsPlayerTalking(id) then
						red = 255
						green = 0
						blue = 0
						DrawMarker(25,x2,y2,z2 - takeaway , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 10.3, 0, 519, 0, 105, 0, 0, 2, 0, 0, 0, 0)
					else
						red = 255
						green = 255
						blue = 255
						DrawMarker(25,x2,y2,z2 - takeaway, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 10.3, 0, 519, 0, 0, 95, 0, 2, 0, 0, 0, 0)
						DrawMarker(25, x2,y2,z2 - takeaway, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 55, 160, 205, 150, 0, 0, 2, 0, 0, 0, 0)
					end
                end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) then
						if NetworkIsPlayerTalking(id) then
							red = 255
							green = 0
							blue = 0
							DrawMarker(25,x2,y2,z2 - takeaway, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 10.3, 0, 519, 0, 105, 0, 0, 2, 0, 0, 0, 0)
						else
							red = 255
							green = 255
							blue = 255
							DrawMarker(25, x2,y2,z2 - takeaway, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 55, 160, 205, 150, 0, 0, 2, 0, 0, 0, 0)
						end
                    end
                end  
            end
        end
        Citizen.Wait(0)
    end
end)
