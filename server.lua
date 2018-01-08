local Characters = {}

RegisterServerEvent('character:disconnect')
AddEventHandler('character:disconnect', function()
	DropPlayer(source, "Disconnected at character selection.")
end)

RegisterServerEvent('character:switch')
AddEventHandler('character:switch', function()
	local s = source
	TriggerClientEvent('character:logout', s)
end)


RegisterServerEvent('character:getList')
AddEventHandler('character:getList', function()
	local s = source
	TriggerEvent('serenity-core:getCharactersFromIdentifier', GetPlayerIdentifiers(source)[1], function(characters)
		TriggerClientEvent('character:getList', s, characters)
	end)
end)



RegisterServerEvent('character:new')
AddEventHandler('character:new', function(user)
	local s = source
	TriggerEvent('serenity-core:createCharacter', { ['identifier'] = GetPlayerIdentifiers(source)[1], ['first_name'] = user.first_name, ['last_name'] = user.last_name, ['gender'] = user.gender }, function(created)
		TriggerClientEvent('character:new', s, true)
		TriggerEvent('serenity-core:exposeDBFunctions', function(db)
			db.getDocumentByRows('clothing', 'first_name', user.first_name, 'last_name', user.last_name, function(dbuser)
				if user.gender == 'male' then 

					dbuser.skin = 'mp_m_freemode_01'
					skin = dbuser.skin
					db.updateDocument('clothing',dbuser._id, {skin = dbuser.skin  }) -- try that k 1 secomd i need t o get pixzzza friom piza guy
				elseif user.gender == 'female' then 
					dbuser.skin = 'mp_f_freemode_01' 
					skin = dbuser.skin
					db.updateDocument('clothing',dbuser._id, {skin = dbuser.skin  })
				end
			end)
		end)
	end)
end)

RegisterServerEvent('character:select')
AddEventHandler('character:select', function(user)
	local s = source
	if user then
		TriggerClientEvent('character:select', source, user)

		
			RconLog({ msgType = 'characterLoggedIn', netID = source, name = GetPlayerName(source), guid = GetPlayerIdentifiers(source)[1], ip = GetPlayerEP(source), rp = user.first_name .. " " .. user.last_name })
				

			TriggerEvent("serenity-core:addCharacterById", s, user, function(data)
				TriggerClientEvent("serenity-core:activateMoney", s, data.cash)

			end)
		
			TriggerEvent('atSpawnWeapons',s)
			TriggerEvent('checkGang', s)
			TriggerEvent('checkClothing', s)
			TriggerEvent('checkcop', s)
			TriggerEvent('checkems', s)
			TriggerEvent('setfalse', s)
		
	end
end)

RegisterServerEvent('character:logout')
AddEventHandler('character:logout', function()
	local s = source
	TriggerEvent('serenity-core:removeCharacterById', s, function(updated) end)
end)

RegisterServerEvent('property')
AddEventHandler('property', function(user)
	TriggerEvent('serenity-core:createCharacterProperties', {['identifier'] = GetPlayerIdentifiers(source)[1], ['first_name'] = user.first_name, ['last_name'] = user.last_name}, function(created)
  	end)
end)

RegisterServerEvent('clothingdb')
AddEventHandler('clothingdb', function(user)
	TriggerEvent('serenity-core:createCharacterClothing', {['identifier'] = GetPlayerIdentifiers(source)[1], ['first_name'] = user.first_name, ['last_name'] = user.last_name}, function(created)
  	end)
end)

RegisterServerEvent('pets')
AddEventHandler('pets', function(user)
	TriggerEvent('serenity-core:createCharacterPets', {['identifier'] = GetPlayerIdentifiers(source)[1], ['first_name'] = user.first_name, ['last_name'] = user.last_name}, function(created)
  	end)
end)

RegisterServerEvent('stats')
AddEventHandler('stats', function(user)
	TriggerEvent('serenity-core:createCharacterStats', {['identifier'] = GetPlayerIdentifiers(source)[1], ['first_name'] = user.first_name, ['last_name'] = user.last_name}, function(created)
  	end)
end)

RegisterServerEvent('babe')
AddEventHandler('babe', function(account)
	local s = source
	TriggerEvent('serenity-core:updateCharacter', account, function(updated)end)
end)
