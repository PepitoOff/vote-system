util.AddNetworkString("JFVS:ConfirmVote")
util.AddNetworkString("JFVS:OpenVoteMenu")

-- Check if the player has voted
net.Receive("JFVS:ConfirmVote", function(_, pPlayer)

    http.Fetch(('https://api.top-serveurs.net/v1/votes/check?server_token=%s&playername=%s'):format(JFVS.Config.TokenAPI, pPlayer:Nick()), function(sBody)
    
        local tData = util.JSONToTable(sBody)

        if not tData.success then
            DarkRP.notify(pPlayer, 1, 5, "Vous n'avez pas voter, vérifier que vous avez bien mis votre NomRP en pseudo")
            return 
        end

        if pPlayer:GetNWBool("JFVS:VoteConfirm") then
            DarkRP.notify(pPlayer, 1, 5, "Vous avez déjà récupéré votre récompense")
            return
        end
         
        pPlayer:SetNWBool("JFVS:VoteConfirm", true)
        DarkRP.notify(pPlayer, 0, 5, JFVS.Config.VotedText)

        if JFVS.Config.EnableWinning and isfunction(JFVS.Config.GiftAfterVoting) then
            JFVS.Config.GiftAfterVoting(pPlayer)
        end

    end)

end)