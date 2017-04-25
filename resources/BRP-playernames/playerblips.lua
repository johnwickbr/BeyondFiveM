Citizen.CreateThread(function()

	while true do

		Wait( 1 )

		-- show blips
		for id = 0, 64 do

			if NetworkIsPlayerActive( id ) and GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then

				ped = GetPlayerPed( id )
				blip = GetBlipFromEntity( ped )

				-- HEAD DISPLAY STUFF --

				-- Create head display (this is safe to be spammed)
				headId = Citizen.InvokeNative( 0xBFEFE3321A3F5015, ped, GetPlayerName( id ), false, false, "", false )

				-- Speaking display
				if NetworkIsPlayerTalking( id ) then

					Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, true ) -- Add speaking sprite

				else

					Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, false ) -- Remove speaking sprite

				end
				

			end

		end

	end

end)
