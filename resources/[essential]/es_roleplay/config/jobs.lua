jobs = {
	["police"] = {
		["displayName"] = "Sandy Shore Police Officer",
		["skin"] = "s_m_y_cop_03",
		["onJoin"] = function(source, user)
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Get your police vehicle at the ^4garage^0 for ^2£2 000")
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
			"WEAPON_CARBINERIFLE"
		},
		["salary"] = 1050
	},
	["ems"] = {
		["displayName"] = "Medic",
		["customJoinMessage"] = "Welcome, you can save people now! To heal them stand next to them and type: ^2^*/heal ID",
		["weapons"] = {},
		["salary"] = 1050
	},
	["fireman"] = {
		["displayName"] = "Fireman",
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
