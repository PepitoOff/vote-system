-- Get a const from the constants
function JFVS:GetConst(sTable, sName)
    return JFVS.Constants[sTable or "cColors"][sName or "black_bg1"]
end

-- Get a color from the constants
function JFVS:GetColor(sName)
    return JFVS.Constants["cColors"][sName or "black_bg1"]
end

-- Get a material from the constants
function JFVS:GetMaterial(sName)
    return JFVS.Constants["mIcons"][sName or "logo"]
end

-- Get a language from the constants
function JFVS:GetLanguage(sName)
    return JFVS.Constants["sLanguages"][sName or "voting_menu"]
end

-- Get a font from the constants
function JFVS:GetFont(sName)
    return JFVS.Constants["sFonts"][sName or "Bold"]
end

-- Return the current hours or days with secondes
function JFVS:FormatTime(iTime)

    if not isnumber(iTime) then
        return false
    end

    local sTime = string.FormattedTime(iTime)
    return sTime.h .. "h " .. sTime.m .. "m"
    
end