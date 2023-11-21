JFVS = JFVS or {}
JFVS.Constants = JFVS.Constants or {}
JFVS.Config = JFVS.Config or {}
JFVS.Fonts = JFVS.Fonts or {}

-- Make loading functions
local function Inclu(f) return include("jfvs/"..f) end
local function AddCS(f) return AddCSLuaFile("jfvs/"..f) end
local function IncAdd(f) return Inclu(f), AddCS(f) end

local function AddMat(f) return resource.AddSingleFile("materials/jfvs/"..f) end
local function AddRes(f) return resource.AddSingleFile("resource/fonts/"..f) end

-- Load shared files
IncAdd("sh_constants.lua")
IncAdd("shared/sh_functions.lua")

-- Load addon files
IncAdd("sh_config.lua")

if SERVER then

	-- Load config content
	Inclu("sv_config.lua")

	-- Load server content
	Inclu("server/sv_hooks.lua")
	Inclu("server/sv_network.lua")

    -- Load client content
	AddCS("client/cl_functions.lua")
	AddCS("client/cl_hooks.lua")
	AddCS("client/cl_network.lua")

	-- Load client library
	AddCS("library/cl_bshadow.lua")

	-- Load fonts --
	AddRes("Montserrat-Bold.ttf")
	AddRes("Montserrat-Light.ttf")
	AddRes("Montserrat-Medium.ttf")

else

	-- Load client content
	Inclu("client/cl_functions.lua")
	Inclu("client/cl_hooks.lua")
	Inclu("client/cl_network.lua")

	-- Load client library
	Inclu("library/cl_bshadow.lua")

end
