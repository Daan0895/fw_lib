function FW.createDiscordMessage(player, username, embedMessage, messageColor, webhook)
    local color
    if messageColor == "white" then color = "16777215" end
    if messageColor == "gray" then color = "10070709" end
    if messageColor == "invisible" then color = "2895667" end
    if messageColor == "black" then color = "2303786" end
    if messageColor == "blue" then color = "5793266" end
    if messageColor == "green" then color = "5763719" end
    if messageColor == "yellow" then color = "16705372" end
    if messageColor == "pink" then color = "15418782" end
    if messageColor == "red" then color = "15548997" end

    local pName = GetPlayerName(player)
    local payloadFormat = "{ \"username\" : \"%s\", \"avatar_url\" : \"%s\", \"embeds\": [{ \"title\": \"%s\", \"type\": \"rich\", \"description\": \"%s\", \"color\": %d, \"footer\": {\"text\": \"" .. Config.discordLogs.username .. "\"} }]}"
    local embed = {
        title = username,
        type = "rich",
        description = embedMessage,
        color = color
    }
    PerformHttpRequest(webhook, function(err, text, headers)
    end, 'POST',
    string.format(payloadFormat, Config.discordLogs.username, Config.discordLogs.profilePicture, username, "**[Name]:** " .. pName .. "\\n **[Message]:** " .. embedMessage, color),
    {
        ['Content-Type'] = 'application/json'
    })
end

function FW.createGlobalBlip(x, y, z, name, sprite, colour, display, scale, route)
    for k,v in pairs(GetPlayers()) do
        TriggerClientEvent("fw:createblip", v, x, y, z, name, sprite, colour, display, scale, route)
    end
end
