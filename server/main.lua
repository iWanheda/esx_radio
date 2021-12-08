print("^3[esx_radio] ^7- ^4Initialized^7")

ESX.RegisterUsableItem("radio", function(source)
  TriggerClientEvent("esx_radio:useRadio", source)
end)

ESX.RegisterServerCallback("esx_radio:getMusic", function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll("SELECT name, url FROM user_radio WHERE owner = @owner", {
    owner = xPlayer.getIdentifier()
  }, function(res)
    if res then
      cb(res)
    end
  end)
end)

-- Mudar (ESX.RegisterEvent ou o crl)
AddEventHandler("esx_radio:addMusic")
RegisterNetEvent("esx_radio:addMusic", function(data)
  if data.name and data.url then
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("INSERT INTO user_radio(name, url, owner) VALUES(@name, @url, @owner)", {
      name = data.name,
      url = data.url,
      owner = xPlayer.getIdentifier()
    })
  end
end)