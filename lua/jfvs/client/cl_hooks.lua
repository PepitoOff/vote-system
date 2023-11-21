-- Called when the player change the size of the screen
hook.Add("OnScreenSizeChanged", "JFVS:OnScreenSizeChanged", function()

    JFVS.iW = ScrW()
    JFVS.iH = ScrH()
    JFVS.Fonts = {}

end)