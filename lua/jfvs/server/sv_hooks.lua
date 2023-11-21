-- When the player is spawn, start a timer to send a notify to the player all x time
hook.Add("PlayerInitialSpawn", "JFVS:PlayerInitialSpawn", function(pPlayer)

    if not IsValid(pPlayer) then return end
    pPlayer:SetNWBool("JFVS:VoteConfirm", false)

    timer.Create(("JFVS:VoteNotification:%s"):format(pPlayer:SteamID64()), JFVS.Config.NotificationTime, 0, function()
    
        if not JFVS.Config.EnableNotification or not IsValid(pPlayer) then
            timer.Remove(("JFVS:VoteNotification:%s"):format(pPlayer:SteamID64()))
            return 
        end

        DarkRP.notify(pPlayer, 0, 5, JFVS.Config.NotificationText)

    end)

end)

-- When the player disconnect, remove the timer
hook.Add("PlayerDisconnected", "JFVS:PlayerDisconnected", function(pPlayer)

    if not IsValid(pPlayer) then return end
    if not timer.Exists(("JFVS:VoteNotification:%s"):format(pPlayer:SteamID64())) then return end

    timer.Remove(("JFVS:VoteNotification:%s"):format(pPlayer:SteamID64()))

end)

-- When a player want to open the voting menu
hook.Add("PlayerSay", "JFVS:PlayerSay", function(pPlayer, sText)

    if not JFVS.Config.EnableVoteCommand then return end
    if not IsValid(pPlayer) or not sText then return end

    sText = sText:Trim():lower()

    if sText == JFVS.Config.VoteCommand then
        
        local sHTTPLink = ('https://api.top-serveurs.net/v1/votes/check?server_token=%s&playername=%s'):format(JFVS.Config.TokenAPI, pPlayer:Nick())
        http.Fetch(sHTTPLink, function(sBody)

            local tData = util.JSONToTable(sBody)

            if not istable(tData) then
                net.Start("JFVS:OpenVoteMenu")
                net.Send(pPlayer)
            end
            
            if tData.success then
                
                local iDurationVote = JFVS:FormatTime((isnumber(tData.duration) and tData.duration * 60 or 0))
                
                local sTime = (JFVS:GetLanguage("waittime"):format(iDurationVote))
                DarkRP.notify(pPlayer, 0, 5, sTime)

            else

                pPlayer:SetNWBool("JFVS:VoteConfirm", false)

                net.Start("JFVS:OpenVoteMenu")
                net.Send(pPlayer)

            end
    
        end)

    end
        
end)