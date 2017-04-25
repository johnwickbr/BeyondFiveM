local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
	-- Postes de polices

	{title="Sandy Shores Police Department", colour=29, id=60, x=1854.21, y=3685.51, z=34.2671},
	-- Casernes de pompiers

	-- Centre médicaux

	-- Garages de réparations

	-- ATM

	-- Banques

	-- Aéroport

    -- Magasins

    -- Magasins de vêtements

    -- Magasins d'armes

    -- Station-essence

  }

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
