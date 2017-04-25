local prisoners = {}

prison = {
	['prison'] = {['x'] = 1647.7075195313, ['y'] = 2532.2573242188, ['z'] = 45.564910888672},
	['arrest'] = police.arrest_points,
	['aprison'] = {['x'] = 1820.6540527344, ['y'] = 3654.5666503906, ['z'] = 98.671997070313},
	['exit'] = {['x'] = 1847.22, ['y'] = 2586.20, ['z'] = 45.67}
}

-- Unjail
TriggerEvent('es:addAdminCommand', 'unjail', 3, function(source, args, user)
	if(#args < 2)then
		TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "/unjail ^4[ID]")
	else
		if(prisoners[args[2]])then
			TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[2]), prison.exit.x, prison.exit.y, prison.exit.z)
			TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[2]), false)
			TriggerClientEvent('chatMessage', -1, "", {255, 140, 0}, "Player ^4" .. GetPlayerName(args[2]) .. "^0 has been released by an^1admin^7.")
			prisoners[args[2]] = nil
		else
			TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "Player not in prison.")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "Insufficienct permissions.")
end)

-- AJail
TriggerEvent('es:addAdminCommand', 'ajail', 3, function(source, args, user)
	if(#args < 3)then
		TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "/ajail ^4[ID] [minutes]")
	else

			if(GetPlayerName(args[2]))then
					-- User permission check
					TriggerEvent("es:getPlayerFromId", tonumber(args[2]), function(target)
						if(tonumber(target.permission_level) >= tonumber(user.permission_level))then
							TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "You're not allowed to target this person!")
							return
						end
					prisoners[args[2]] = true
					local time = tonumber(args[3]) * 1000 * 60
					TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[2]), prison.aprison.x, prison.aprison.y, prison.aprison.z)
					TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[2]), true)
					TriggerClientEvent('es_roleplay:cuff', -1, false, tonumber(args[2]))
					TriggerClientEvent('chatMessage', -1, "", {255, 140, 0}, "Player ^2" .. GetPlayerName(args[2]) .. "^0 has been ^4force^0 jailed for ^2" .. tonumber(args[3]) .. " ^0minute(s). By ^2" .. GetPlayerName(source))
				end)
			else
				TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "Incorrect player ID")
			end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "Insufficienct permissions.")
end)

RegisterServerEvent("es_roleplay:playerDead")
AddEventHandler('es_roleplay:playerDead', function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		if(target)then
			if(target.identifier)then
				if(cuffed)then
					cuffed[target.identifier] = nil
				end
			end
		end
	end)
end)

local cuffed = {}

TriggerEvent('es:addCommand', 'jail', function(source, args, user)
	if(player_jobs[user.identifier] or (tonumber(user.permission_level) > 2))then
		local job = player_jobs[user.identifier]
		if(job)then
			job = player_jobs[user.identifier].job
		end

		if(groups.police[job] or tonumber(user.permission_level) > 2)then
			if(#args < 2)then
				TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "/jail ^4(ID) (minutes)")
			else
				if(GetPlayerName(tonumber(args[2])))then
					TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)
						for k,v in pairs(prison.arrest)do
						if(get3DDistance(target.coords.x, target.coords.y, target.coords.z, v.x, v.y, v.z) < 10.0)then

							if(cuffed[target.identifier])then
									cuffed[target.identifier] = nil

									if(#args < 3)then
										TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "/jail ^4(ID) (minutes)")
										return
									end

									prisoners[args[2]] = true

									local time = tonumber(args[3]) * 1000 * 60
									TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[2]), prison.prison.x, prison.prison.y, prison.prison.z)
									TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[2]), false)
									TriggerClientEvent('es_roleplay:cuff', -1, false, tonumber(args[2]))
									TriggerClientEvent('chatMessage', -1, "", {255, 140, 0}, "^4" .. GetPlayerName(args[2]) .. "^7 has been put in jail for ^3" .. tonumber(args[3]) .." ^7minute(s).")

									SetTimeout(time, function()
										if(prisoners[args[2]])then
											TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[2]), prison.exit.x, prison.exit.y, prison.exit.z)
											TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[2]), false)
											TriggerClientEvent('chatMessage', -1, "", {0, 0, 0}, "^4" .. GetPlayerName(args[1]) .. "^7 has been ^2released^7 from jail.")
										end
									end)
							else
								TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "Suspect requires to be ^1cuffed^7.")
							end

							return
						else

						end
					end
					TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "Target not ^4close^7 enough to prison.")
					end)
				else
					TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "Incorrect player ID")
				end
			end
		else
			TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "You need to be police.")
		end
	else
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You need to be police.")
	end
end)

TriggerEvent('es:addCommand', 'cuff', function(source, args, user)
	if(player_jobs[user.identifier] or (tonumber(user.permission_level) > 2))then
		local job = player_jobs[user.identifier]
		if(job)then
			job = player_jobs[user.identifier].job
		end

		if(groups.police[job] or tonumber(user.permission_level) > 2)then
			if(#args < 2)then
				TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "/cuff ^4(ID)")
			else
				if(GetPlayerName(tonumber(args[2])))then
					TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)
						if(get3DDistance(target.coords.x, target.coords.y, target.coords.z, user.coords.x, user.coords.y, user.coords.z) > 10.0)then
							TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "Please get closer to the ^4suspect.")
							return
						end

						if(cuffed[target.identifier])then
							cuffed[target.identifier] = not cuffed[target.identifier]
						else
							cuffed[target.identifier] = true
						end

						local state = ""
						if(cuffed[target.identifier])then
							state = "cuffed"
						else
							state = "uncuffed"
						end

						TriggerClientEvent('es_roleplay:cuff', -1, cuffed[target.identifier], tonumber(args[2]))
						TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "^4" .. GetPlayerName(tonumber(args[2])) .. "^7 has been " .. state .. "^7.")
						TriggerClientEvent('chatMessage', tonumber(args[2]), "", {255, 0, 0}, "You have been " .. state .. "^7 by ^4" .. GetPlayerName(source) .. ".")

						TriggerEvent("es_roleplay:playerCuffed", tonumber(args[2]), cuffed[target.identifier])
					end)
				else
					TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "Player is not online")
				end
			end
		else
			TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "You need to be a police officer.")
		end
	else
		TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "You need to be a police officer.")
	end
end)

-- Unseat
TriggerEvent('es:addCommand', 'unseat', function(source, args, user)
	if(player_jobs[user.identifier] or (tonumber(user.permission_level) > 2))then
		local job = player_jobs[user.identifier]
		if(job)then
			job = player_jobs[user.identifier].job
		end

		if(groups.police[job] or tonumber(user.permission_level) > 2)then
			if(#args < 2)then
				TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "/unseat ^4(ID)")
			else
				if(GetPlayerName(tonumber(args[2])))then
					TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)
						if(get3DDistance(target.coords.x, target.coords.y, target.coords.z, user.coords.x, user.coords.y, user.coords.z) > 10.0)then
							TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "Please get closer to suspect.")
							return
						end

						if(not cuffed[target.identifier])then
							TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "You cannot unseat a non-cuffed target.")
							return
						end

						TriggerClientEvent('es_roleplay:unseat', tonumber(args[2]), tonumber(args[2]))
						TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "^4" .. GetPlayerName(tonumber(args[2])) .. "^0 has been unseated.")
						TriggerClientEvent('chatMessage', tonumber(args[2]), "JOB", {255, 0, 0}, "You have been unseated by ^4" .. GetPlayerName(source) .. "^0.")
					end)
				else
					TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Incorrect player ID")
				end
			end
		else
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You need to be police.")
		end
	else
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You need to be police.")
	end
end)

-- Rcon commands
AddEventHandler('rconCommand', function(commandName, args)
    if commandName == 'unjail' then
			if #args ~= 1 then
					RconPrint("Usage: unjail [user-id]\n")
					CancelEvent()
					return
			end

			if(GetPlayerName(tonumber(args[1])) == nil)then
				RconPrint("Player not ingame\n")
				CancelEvent()
				return
			end

			if(prisoners[args[1]])then
				TriggerClientEvent('es_roleplay:teleportPlayer', tonumber(args[1]), prison.exit.x, prison.exit.y, prison.exit.z)
				TriggerClientEvent('es_roleplay:freezePlayer', tonumber(args[1]), false)
				TriggerClientEvent('chatMessage', -1, "", {0, 0, 0}, "^4" .. GetPlayerName(args[1]) .. "^7 has been ^2released^7 from jail.")
				prisoners[args[1]] = nil
				RconPrint("Player unjailed\n")
			else
				RconPrint("Player is not in prison.\n")
			end

			CancelEvent()
		end
	end)
