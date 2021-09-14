ESX = nil
local cardpack = ''
local cardpackRare = ''
local cardpackBadge = ''
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

---pokemon

RegisterServerEvent('rkl_cards:OpenCard')
AddEventHandler('rkl_cards:OpenCard', function(pokemoncard)
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cardToGive = math.random(1,#Config.cards)
  
    if Config.mythic  and Config.tnotify == false  then
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You got '..Config.cards[cardToGive]..' Card!'})
    elseif Config.mythic == false and Config.tnotify  then
        TriggerClientEvent('tnotify:client:SendTextAlert', source, {
            style  =  'success',
            duration  =  Config.tnotifyDuration,
            message = 'You got '..Config.cards[cardToGive]..' Card!',
            sound  =  true
        })
    else
        TriggerClientEvent("esx:showNotification",source,"You got " ..Config.cards[cardToGive].. " Card!")
    end
  
     xPlayer.addInventoryItem('pokemon_card', 1, {pokemoncard = Config.cards[cardToGive],  description = Config.cards[cardToGive] , image = Config.cards[cardToGive] })
     xPlayer.removeInventoryItem('pokemon_booster', 1, {pokemoncard = pokemoncard,  description = pokemoncard})
end)



RegisterServerEvent('rkl_cards:OpenRareCard')
AddEventHandler('rkl_cards:OpenRareCard', function(pokemoncard)
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cardToGive = math.random(1,#Config.cardsRare)
  
    if Config.mythic  and Config.tnotify == false  then
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You got '..Config.cardsRare[cardToGive]..' Card!'})
    elseif Config.mythic == false and Config.tnotify  then
        TriggerClientEvent('tnotify:client:SendTextAlert', source, {
            style  =  'success',
            duration  =  Config.tnotifyDuration,
            message = 'You got '..Config.cardsRare[cardToGive]..' Card!',
            sound  =  true
        })
    else
        TriggerClientEvent("esx:showNotification",source,"You got " ..Config.cardsRare[cardToGive].. " Card!")
    end
  

     xPlayer.addInventoryItem('pokemon_card', 1, {pokemoncard = Config.cardsRare[cardToGive],  description = Config.cardsRare[cardToGive] , image = Config.cardsRare[cardToGive] })
     xPlayer.removeInventoryItem('pokemon_boosterrare', 1, {pokemoncard = pokemoncard,  description = pokemoncard})
end)




RegisterServerEvent('rkl_cards:OpenpokeBadge')
AddEventHandler('rkl_cards:OpenpokeBadge', function(pokemoncard)
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cardToGive = math.random(1,#Config.Badge)
  
    if Config.mythic  and Config.tnotify == false  then
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You got '..Config.Badge[cardToGive]..' Card!'})
    elseif Config.mythic == false and Config.tnotify  then
        TriggerClientEvent('tnotify:client:SendTextAlert', source, {
            style  =  'success',
            duration  =  Config.tnotifyDuration,
            message = 'You got '..Config.Badge[cardToGive]..' Card!',
            sound  =  true
        })
    else
        TriggerClientEvent("esx:showNotification",source,"You got " ..Config.Badge[cardToGive].. " Card!")
    end
  

     xPlayer.addInventoryItem('pokemon_badge', 1, {pokemoncard = Config.Badge[cardToGive],  description = Config.Badge[cardToGive] , image = Config.Badge[cardToGive] })
     xPlayer.removeInventoryItem('pokemon_badgeopen', 1, {pokemoncard = pokemoncard,  description = pokemoncard})
end)




