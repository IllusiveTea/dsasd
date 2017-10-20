local engineoff = false
local toggle = false
Citizen.CreateThread(function()
    local checkbox = false

    WarMenu.CreateMenu('interaction', 'Vehicle Options')
    WarMenu.SetSubTitle("interaction", "Options")
    WarMenu.CreateSubMenu('doors', 'interaction', 'Door Controls')


    while true do
    	if checkbox then
    		SetVehicleDoorsLockedForAllPlayers(savedveh, true)
    	else
    		SetVehicleDoorsLockedForAllPlayers(savedveh, false)
    	end
        if WarMenu.IsMenuOpened('interaction') then
        	if WarMenu.Button('Toggle Engine') then
        		toggle = not toggle
                if toggle then
                    engineoff = true
                else
                    engineoff = false
                end
            elseif WarMenu.MenuButton('Door Menu', 'doors') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('doors') then
        	if WarMenu.CheckBox('Lock Doors', checkbox, function(checked)
                    checkbox = checked
                end) then
            elseif WarMenu.Button('All Doors') then
            	for i=0, 8 do
            		toggledoor(i, vehicle)
            	end
            elseif WarMenu.Button('Front Left') then
            	toggledoor(0, vehicle) 
            elseif WarMenu.Button('Front Right') then
            	toggledoor(1, vehicle) 
            elseif WarMenu.Button('Back Left') then
            	toggledoor(2, vehicle) 
            elseif WarMenu.Button('Back Right') then
            	toggledoor(3, vehicle) 
            elseif WarMenu.Button('Hood') then
            	toggledoor(4, vehicle)
            elseif WarMenu.Button('Trunk') then
            	toggledoor(5, vehicle)     
            end

            WarMenu.Display()
        elseif IsControlJustReleased(0, 244) then --M by default
            WarMenu.OpenMenu('interaction')
        end
        Citizen.Wait(0)
    end
end)

function toggledoor(index, vehicle)
	if GetVehicleDoorAngleRatio(vehicle, index) > 0 then
        SetVehicleDoorShut(vehicle, index, false)
    else
       SetVehicleDoorOpen(vehicle, index, false, false)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if engineoff then
            SetVehicleEngineOn(GetVehiclePedIsUsing(PlayerPedId()), false, true)
        else
            SetVehicleEngineOn(GetVehiclePedIsUsing(PlayerPedId()), true, true)
        end
    end
end)