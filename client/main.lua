Citizen.CreateThread(function()
  SetNuiFocus((false), (false))
end)

RegisterNetEvent("esx_radio:useRadio")
AddEventHandler("esx_radio:useRadio", function()
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    ESX.TriggerServerCallback("esx_radio:getMusic", function(musicList) 
      SetNuiFocus((true), (true))
      SendNuiMessage(json.encode({
        type = "show",
        music = musicList
      }))
    end)
  end
end)

RegisterNUICallback("newMusic", function(data)
  if data.name and data.url then
    TriggerServerEvent("esx_radio:addMusic", { name = data.name, url = data.url })
  end
end)

local xSound, lastPlayed, playerVeh = exports.xsound, nil, nil

RegisterCommand("stopmusic", function()
  xSound:Destroy(lastPlayed)
  lastPlayed = nil
  playerVeh = nil
end, false)

Citizen.CreateThread(function()
  while true do
    Wait(15)
    local playerPed = PlayerPedId()

    if lastPlayed ~= nil then
      if playerVeh ~= nil then
        xSound:Position(lastPlayed, GetEntityCoords(playerVeh))
      else
        xSound:Destroy(playerVeh)
      end
    end
  end
end)

RegisterNUICallback("playMusic", function(data)
  lastPlayed = data.name
  playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)

  xSound:PlayUrlPos(data.name, data.url, data.volume, GetEntityCoords(playerVeh), false)
  xSound:destroyOnFinish(data.name, true)

  SetNuiFocus((false), (false))
end)

RegisterNUICallback("close", function(data)
  SetNuiFocus((false), (false))
end)