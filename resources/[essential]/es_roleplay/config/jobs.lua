jobs = {
	["police"] = {
		["displayName"] = "Sandy Shore Police Officer",
		["skin"] = "s_m_y_sheriff_01",
		["onJoin"] = function(source, user)
			TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "You are now on ^4duty^7 as a police officer^7. Your vehicle is ready for pickup at any garage.")
		end,
		["onLeave"] = function(source, user)
			-- Do code here for when someone leaves this job
		end,
		["onSpawn"] = function(source, user)
			-- Do code here for when someone spawns with this job.
		end,
		["weapons"] = {
			"WEAPON_STUNGUN",
			"WEAPON_PISTOL",
		},
		["salary"] = 1050
	},
	["ems"] = {
		["displayName"] = "Medic",
		["skin"] = "s_m_m_paramedic_01",
		["onJoin"] = function(source, user)
			TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "You are now on ^4duty^7 as a medic. Use /heal ^4(ID)^7 to heal people.")
		end,
		["weapons"] = {},
		["salary"] = 1050
	},
	["fireman"] = {
		["displayName"] = "Fireman",
		["skin"] = "s_m_y_fireman_01",
		["onJoin"] = function(source, user)
			TriggerClientEvent('chatMessage', source, "", {255, 0, 0}, "You are now on ^4duty^7 as a Fireman. Your vehicle is ready for pickup at any garage.")
		end,
		["weapons"] = {},
		["salary"] = 1050
	},
	["trucker"] = {
		["displayName"] = "Trucker",
		["weapons"] = {},
		["salary"] = 900
	},
}

-- Groups
groups = {}
groups.police = {["police"] = true, --[[Add more if wanted]]}
groups.ems = {["ems"] = true, --[[Add more if wanted]]}
groups.fire = {["fireman"] = true, --[[Add more if wanted]]}

-- Police data
police = {}
police.arrest_points = {
	{['x'] = 1846.3038330078, ['y'] = 2585.8862304688, ['z'] = 45.67200088501}
}
