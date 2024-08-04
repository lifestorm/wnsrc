--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

PLUGIN.name = "Menu Voces"
PLUGIN.author = "UltraDev"
PLUGIN.description = "View menu voices press [H]."

PLUGIN.bind = KEY_H

if (CLIENT) then
	function PLUGIN:PlayerButtonDown(client, button)
		local curTime = CurTime()

		if (button == self.bind and (!client.nextBind or client.nextBind <= curTime)) then
			-- Verificar si el menú está actualmente abierto
			if client.menuOpen then
				-- Cerrar menú
				client.menu:Remove()
				client.menuOpen = false
			else

            local classes = {}

            for k, v in pairs(Schema.voices.classes) do
                if (v.condition(client)) then
                    classes[#classes + 1] = k
                end
            end

            if (#classes < 1) then
                return
            end

            table.sort(classes, function(a, b)
                return a < b
            end)

            -- Crear menú
            local menu = vgui.Create("DMenu")

           for _, class in ipairs(classes) do
            for command, info in SortedPairs(Schema.voices.stored[class]) do
               -- print(command:upper())

                 -- Agregar opción al menú
                   -- local option = menu:AddOption(command:upper(), function()
                     -- Ejecutar comando en el chat
                    --  RunConsoleCommand("say", command)
                    -- end)
                local subMenu, option = menu:AddSubMenu(command:upper())

                local yesOption = subMenu:AddOption("Normal", function() RunConsoleCommand("say", command) end)
                
                local noOption = subMenu:AddOption("Radio", function() RunConsoleCommand("say","/radio " .. command) end)
                
		 	end
        end
            -- Mostrar menú
            menu:Open()
            -- Actualizar variable de estado del menú
			client.menuOpen = true
			client.menu = menu
    end

			client.nextBind = curTime + 0.1
		end
	end
end