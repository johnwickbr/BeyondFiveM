local tags = uSettings.chatTags

-- Settings for EssentialMode
TriggerEvent("es:setDefaultSettings", {
	pvpEnabled = uSettings.pvpEnabled,
	debugInformation = false,
	startingCash = uSettings.startingMoney + 0.0,
	enableRankDecorators = true
})

function startswith(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

-- Default commands
TriggerEvent('es:addCommand', 'help', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "", {255, 0, 0},"^4" .. "Payment Commands: ^7  /givecash")
	TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "^4" .. "Chat Commands: ^7  /do, /me, /ooc")
	TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "^4" .. "Info Commands: ^7  /discord")
end)

-- Default commands
TriggerEvent('es:addCommand', 'discord', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "", {153, 153, 255}, "Join our ^6 Discord ^7 at BeyondRoleplay.com.")
end)

-----Emote commands
TriggerEvent('es:addCommand', 'emote', function(source, args, user)
end)
TriggerEvent('es:addCommand', 'emotes', function(source, args, user)
end)

-- Default commands
TriggerEvent('es:addAdminCommand', 'delveh', 3, function(source, args, user)
	TriggerClientEvent("es_roleplay:deleteVehicle", source)
end, function(source, args, user)

end)

-- ME
TriggerEvent('es:addCommand', 'me', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		table.remove(args, 1)
		local message = table.concat(args, " ")

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(range < 30.0)then
						TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^6 " .. GetPlayerName(source) .. " " .. message .. ".")
					end
				end)
			end
		end
	end)
	end)
end)

-- ME
TriggerEvent('es:addCommand', 'passport', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					TriggerEvent("es_roleplay:getPlayerJob", user.identifier, function(job)
						local dJob = "None"
						if(job)then
							dJob = job.job .. " 0r(2*" .. job.id .. "0r)"
						end

						if(range < 10.0)then
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^4" .. GetPlayerName(source) .. "^7's ID")
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "Name: ^4" .. GetPlayerName(source) .. "")
						end

					end)
				end)
			end
		end
	end)
	end)
end)

-- DO
TriggerEvent('es:addCommand', 'do', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		table.remove(args, 1)
		local message = table.concat(args, " ")

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(range < 30.0)then
						TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^6 " .. message .. " - " .. GetPlayerName(source))
					end
				end)
			end
		end
	end)
	end)
end)

-- Test ooc

TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		table.remove(args, 1)
		local message = table.concat(args, " ")

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(range < 30.0)then
						TriggerClientEvent('chatMessage', id, "", {0, 0, 200},"((^4" .. GetPlayerName(source) .. "^7: " .. message .. "))")
					end
				end)
			end
		end
	end)
	end)
end)

-- Global Chat
TriggerEvent('es:addCommand', 'global', function(source, args, user)
	table.remove(args, 1)
	local message = table.concat(args, " ")

	local tag = ""
	for k,v in ipairs(tags)do
		if(user.permission_level >= v.rank)then
			tag = v.tag
		end
	end

	TriggerClientEvent('chatMessage', -1, "", {255, 255, 0},"Global: ^4" .. GetPlayerName(source) .. "^7: " .. message .. "")
end)

AddEventHandler('chatMessage', function(source, n, message)
	if(not startswith(message, "/"))then
		CancelEvent()
		TriggerEvent('es:getPlayerFromId', source, function(user)
			local pos = user.coords

			TriggerEvent('es:getPlayers', function(players)
			for id,_ in pairs(players) do
				if(GetPlayerName(id))then
					TriggerEvent('es:getPlayerFromId', id, function(target)
						if(target)then
							local pPos = target.coords

							if(user.coords and target.coords)then
								local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

								local tag = ""
								for k,v in ipairs(tags)do
									if(user.permission_level >= v.rank)then
										tag = v.tag
									end
								end

								if(range < 30.0)then
									TriggerClientEvent('chatMessage', id, "", {0, 0, 200}," ^4" .. GetPlayerName(source) .. "^7: " .. message .. ".")
								end
							end
						end
					end)

				end
			end
			end)
		end)
	end
end)

AddEventHandler('es:invalidCommandHandler', function(source, args, user)
	TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "^1Unknown command^7, type /help for a list.")
	CancelEvent()
end)
