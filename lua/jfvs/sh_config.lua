-- The ServerName that will be displayed in the vote menu
JFVS.Config.ServerName = "JFVS"

-- The link of our server on "top-serveurs.net"
JFVS.Config.ServerLink = "https://top-serveurs.net/garrys-mod/vote/malkidow"

-- Wait time before the link will be opened
JFVS.Config.WaitingTime = 3

-- Enable or not the vote command
JFVS.Config.EnableVoteCommand = true

-- The command that will be used for voting
JFVS.Config.VoteCommand = "/vote"

-- Enable or not the notification for the voting menu
JFVS.Config.EnableNotification = true

-- The text that will be displayed in the notification
JFVS.Config.NotificationText = "Vous pouvez voter pour le serveur en tapant /vote"

-- The time before the notification will be displayed again
JFVS.Config.NotificationTime = 120

-- Enable the gift after a vote.
JFVS.Config.EnableWinning = true

-- The text that will be displayed when the player open the vote menu
JFVS.Config.WinningText = "En votant pour le serveur\nvous pouvez gagner la somme de 20k !"

-- The text that will be displayed when the player has voted
JFVS.Config.VotedText = "Merci d'avoir voté pour le serveur !"

-- When the player has voted, this function will be called for gifing something to the player
JFVS.Config.GiftAfterVoting = function(pPlayer)

    -- For example, if you want to give money to the player
    if DarkRP then
        pPlayer:addMoney(20000)
    end

    -- For example, if you want to give a weapon to the player
    pPlayer:Give("weapon_pistol")

    -- For example, if you want to give some armor to the player
    pPlayer:SetArmor(100)

end