-- Automatic responsive functions
JFVS.iW = ScrW()
JFVS.iH = ScrH()

function RX(x)
    return x / 1920 * JFVS.iW
end

function RY(y)
    return y / 1080 * JFVS.iH
end

-- Create automatic responsive font
function Font(iSize, sFont, iWeight)

    sFont = sFont or "Medium"
    iSize = iSize or 25
    iWeight = iWeight or 500
    
    local sName = ("JFVS:Font:"..sFont..":"..tostring(iSize))
	if not JFVS:GetFont(sFont) then return end

    if not JFVS.Fonts[sName] then
        surface.CreateFont(sName, {
            font = "Montserrat "..sFont,
            extended = false,
            size = RX(iSize),
            weight = iWeight
        })

        JFVS.Fonts[sName] = true
    end

    return sName

end

-- Interface of the voting menu
function JFVS:OpenVoteMenu()

    if IsValid(JFVS.vVoteMenu) then JFVS.vVoteMenu:Remove() end

    local vFrame = vgui.Create("DFrame")
    vFrame:SetSize(RX(500), RY(200))
    vFrame:Center()
    vFrame:SetTitle("")
    vFrame:ShowCloseButton(false)
    vFrame:MakePopup()
    vFrame:SetDraggable(false)
    function vFrame:Paint(w, h)

        BSHADOWS.BeginShadow()
            draw.RoundedBoxEx(8, RX(1920 / 2 - 250), RY(1080 / 2 - 100), w, RY(50), JFVS:GetColor("black_bg2"), true, true, false, false)
            draw.RoundedBoxEx(8, RX(1920 / 2 - 250), RY(1080 / 2 - 50), w, h - RY(50), JFVS:GetColor("black_bg1"), false, false, true, true)
	    BSHADOWS.EndShadow(3, 2, 2)

        draw.SimpleText(JFVS:GetLanguage("voting_menu"):format(JFVS.Config.ServerName), Font(22, "Medium"), RX(13), RY(13), color_white)
        draw.DrawText(JFVS.Config.WinningText, Font(22, "Medium"), w / 2, RY(70), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end

    JFVS.vVoteMenu = vFrame

    local vVote = vgui.Create("DButton", vFrame)
    vVote:SetSize(vFrame:GetWide() - RX(20), RY(50))
    vVote:SetPos(RX(10), vFrame:GetTall() - RY(60))
    vVote:SetText("")
    vVote.iStage = 0
    vVote.bUsed = false
    function vVote:Paint(w, h)

        draw.RoundedBox(4, 0, 0, w, h, JFVS:GetColor("green_bg1"))
        draw.SimpleText(JFVS:GetLanguage((self.iStage == 0 and "vote" or "confirmvote")), Font(22, "Medium"), w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end
    function vVote:DoClick()

        if vVote.bUsed then return end

        if self.iStage == 0 then
            
            vVote.bUsed = true
            notification.AddLegacy(JFVS:GetLanguage("advise1"), NOTIFY_GENERIC, JFVS.Config.WaitingTime)

            timer.Simple(JFVS.Config.WaitingTime, function()

                gui.OpenURL(("%s?pseudo=%s"):format(JFVS.Config.ServerLink, LocalPlayer():Nick()))

                self.iStage = 1
                self.bUsed = false

            end)


        else

            net.Start("JFVS:ConfirmVote")
            net.SendToServer()

            vFrame:Remove()

        end

    end

    local vClose = vgui.Create("DButton", vFrame)
    vClose:SetSize(RY(50), RY(50))
    vClose:SetPos(vFrame:GetWide() - RY(50), 0)
    vClose:SetText("")
    function vClose:Paint(w, h)
        draw.SimpleText("✕", Font(30, "Medium"), w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function vClose:DoClick()
        vFrame:Remove()
    end

end