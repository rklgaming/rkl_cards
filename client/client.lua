ESX = nil
local isopening = false
local pokemoncard = ''

Citizen.CreateThread(function()
  while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0) 
  end
end)

local inMenu = false

RegisterNetEvent("rkl_cards:use")
AddEventHandler("rkl_cards:use", function(item, wait, cb)
  local player = PlayerPedId()
  local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
  pokemoncard = metadata.pokemoncard

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cards', {
    title = "What Do You Want To DO?",
    elements = {
      {label = 'View Card',     value = 'view'},
      {label = 'Evolve Card(Soon)',     value = 'evolve'},
      {label = 'Put in Binder(Soon)',   value = 'binder'}
    }
  }, function(data, menu)
    if data.current.value == 'view' then
      if inMenu then return end
      SetNuiFocus(true, true)
      SendNUIMessage({
        type = 'openViewCard',
        resourceName = GetCurrentResourceName(),
        pokemoncard = pokemoncard
       
      })
      inMenu = true
    
    elseif data.current.value == 'evolve' then
    
    elseif data.current.value == 'binder' then
      
     
    end
  
  end, function(data, menu)
    menu.close()
  
  end)
  

end)

RegisterNUICallback('closeViewCard', function()
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeCard'})
  inMenu = false
end)



RegisterNetEvent('rkl_cards:booster')
AddEventHandler('rkl_cards:booster',   function(item, wait, cb)
  local player = PlayerPedId()
  local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
  pokemoncard = metadata.pokemoncard

 
  if not isopening then
      isopening = true
      RequestAnimDict("mp_arresting")
      while (not HasAnimDictLoaded("mp_arresting")) do
      Citizen.Wait(0)
      end
          TaskPlayAnim(GetPlayerPed(-1), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(GetPlayerPed(-1))
          propcards = CreateObject(GetHashKey('prop_cs_r_business_card'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
          AttachEntityToEntity(propcards, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.1, 0.1, 0.0, 0.0, 10.0, 90.0, false, false, false, false, 2, true)
      if  Config.progressbar then
          exports['progressBars']:startUI(Config.OpenCard, Config.OpeningCard)
          Citizen.Wait(Config.OpenCard)
          DeleteEntity(propcards)
          ClearPedTasks(GetPlayerPed(-1))
          FreezeEntityPosition(GetPlayerPed(-1),false)
          TriggerServerEvent('rkl_cards:OpenCard', pokemoncard)
          isopening = false
      end
 

     
    if Config.UseProgressbar then
      TriggerEvent("mythic_progbar:client:progress", {
      name = "opening_card",
      duration = Config.OpenCard,
      label = Config.OpeningCard,
      useWhileDead = false,
      canCancel = true,
      controlDisables = {
          disableMovement = true,
          disableCarMovement = false,
          disableMouse = false,
          disableCombat = true,
          },

      }, function(status)
          if not status then
            DeleteEntity(propcards)
            ClearPedTasks(GetPlayerPed(-1))
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerServerEvent('rkl_cards:OpenCard', pokemoncard)
            isopening = false
            
          end
      end)
    end	 
else
  if Config.mythic and Config.tnotify == false then
     exports['mythic_notify']:DoShortHudText('error', Config.OpeningCardError)
     elseif Config.mythic == false and Config.tnotify  then
      exports['t-notify']:SendTextAlert('error', Config.OpeningCardError, true)
    else
      ESX.ShowNotification(Config.OpeningCardError)
    end

end

end)


RegisterNetEvent('rkl_cards:boosterrare')
AddEventHandler('rkl_cards:boosterrare',   function(item, wait, cb)

    local player = PlayerPedId()
    local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
    pokemoncard = metadata.pokemoncard
    pokemoncardimage = metadata.image
  if not isopening then
      isopening = true
      RequestAnimDict("mp_arresting")
      while (not HasAnimDictLoaded("mp_arresting")) do
      Citizen.Wait(0)
      end
          TaskPlayAnim(GetPlayerPed(-1), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(GetPlayerPed(-1))
          propcards = CreateObject(GetHashKey('prop_cs_r_business_card'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
          AttachEntityToEntity(propcards, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.1, 0.1, 0.0, 0.0, 10.0, 90.0, false, false, false, false, 2, true)
      if  Config.progressbar then
          exports['progressBars']:startUI(Config.OpenCardRare, Config.OpeningRare)
          Citizen.Wait(Config.OpenCardRare)
          DeleteEntity(propcards)
          ClearPedTasks(GetPlayerPed(-1))
          FreezeEntityPosition(GetPlayerPed(-1),false)
          TriggerServerEvent('rkl_cards:OpenRareCard', pokemoncard)
          isopening = false
      end
 

     
    if Config.UseProgressbar then
      TriggerEvent("mythic_progbar:client:progress", {
      name = "opening_card",
      duration = Config.OpenCard,
      label = Config.OpeningCard,
      useWhileDead = false,
      canCancel = true,
      controlDisables = {
          disableMovement = true,
          disableCarMovement = false,
          disableMouse = false,
          disableCombat = true,
          },

      }, function(status)
          if not status then
            DeleteEntity(propcards)
            ClearPedTasks(GetPlayerPed(-1))
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerServerEvent('rkl_cards:OpenRareCard', pokemoncard)
            isopening = false
            
          end
      end)
    end	 
else
  if Config.mythic and Config.tnotify == false then
     exports['mythic_notify']:DoShortHudText('error', Config.OpeningRareError)
     elseif Config.mythic == false and Config.tnotify  then
      exports['t-notify']:SendTextAlert('error', Config.OpeningRareError, true)
    else
      ESX.ShowNotification(Config.OpeningRareError)
    end

end

end)



RegisterNetEvent('rkl_cards:badge')
AddEventHandler('rkl_cards:badge',   function(item, wait, cb)

    local player = PlayerPedId()
    local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
    pokemoncard = metadata.pokemoncard
    pokemoncardimage = metadata.image
  if not isopening then
      isopening = true
      RequestAnimDict("mp_arresting")
      while (not HasAnimDictLoaded("mp_arresting")) do
      Citizen.Wait(0)
      end
          TaskPlayAnim(GetPlayerPed(-1), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(GetPlayerPed(-1))
          propcards = CreateObject(GetHashKey('prop_cs_r_business_card'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
          AttachEntityToEntity(propcards, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.1, 0.1, 0.0, 0.0, 10.0, 90.0, false, false, false, false, 2, true)
      if  Config.progressbar then
          exports['progressBars']:startUI(Config.OpenCardBadge, Config.OpenCardBadge)
          Citizen.Wait(Config.OpenCardBadge)
          DeleteEntity(propcards)
          ClearPedTasks(GetPlayerPed(-1))
          FreezeEntityPosition(GetPlayerPed(-1),false)
          TriggerServerEvent('rkl_cards:OpenpokeBadge', pokemoncard)
          isopening = false
      end
 

     
    if Config.UseProgressbar then
      TriggerEvent("mythic_progbar:client:progress", {
      name = "opening_card",
      duration = Config.OpenCardBadge,
      label = Config.OpeningBadge,
      useWhileDead = false,
      canCancel = true,
      controlDisables = {
          disableMovement = true,
          disableCarMovement = false,
          disableMouse = false,
          disableCombat = true,
          },

      }, function(status)
          if not status then
            DeleteEntity(propcards)
            ClearPedTasks(GetPlayerPed(-1))
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerServerEvent('rkl_cards:OpenpokeBadge', pokemoncard)
            isopening = false
            
          end
      end)
    end	 
else
  if Config.mythic and Config.tnotify == false then
     exports['mythic_notify']:DoShortHudText('error', Config.OpeningBadgeError)
     elseif Config.mythic == false and Config.tnotify  then
      exports['t-notify']:SendTextAlert('error', Config.OpeningBadgeError, true)
    else
      ESX.ShowNotification(Config.OpeningBadgeError)
    end

end

end)