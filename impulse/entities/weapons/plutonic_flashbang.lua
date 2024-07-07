-- "addons\\plutonic\\lua\\weapons\\plutonic_flashbang.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

hook.Add("Initialize", "impulseLSAmmoGas", function()
	game.AddAmmoType({
		name = "flashbang"
	})
end)

SWEP.Base = "plutonic_base_projectile"

SWEP.PrintName = "Flashbang"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Attachments = {}
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "grenade"

SWEP.WorldModel = Model("models/weapons/w_eq_flashbang.mdl")
SWEP.ViewModel = Model("models/weapons/cstrike/c_eq_flashbang.mdl")
SWEP.ViewModelFOV = 64
SWEP.IsAlwaysRaised = true
SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.Primary.Sound = ""
SWEP.Primary.Recoil = 0 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Delay = 0.8
SWEP.Primary.HitDelay = 0.1

SWEP.Primary.Ammo = "flashbang"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1

SWEP.Projectile = {}
SWEP.Projectile.Model = Model("models/weapons/w_eq_flashbang_thrown.mdl")
SWEP.Projectile.FireSound = Sound("Weapon_Flashbang.Explode")
SWEP.Projectile.HitSound = Sound("weapons/flashbang/grenade_hit1.wav")
SWEP.Projectile.Touch = false
SWEP.Projectile.ForceMod = 2.2
SWEP.Projectile.Timer = 1.8
SWEP.Projectile.RemoveWait = 30

SWEP.SwayRightMultiplier = 4
SWEP.SwayUpMultiplier = 4

local maxRange = 600
local midRange = 390
local minRange = 170

-- test ranges
local minRangeSqr = (minRange * minRange)
local midRangeSqr = (midRange * midRange)
local maxRangeSqr = (maxRange * maxRange) 

local player_GetAll = player.GetAll
function SWEP:ProjectileFire()
	self:EmitSound(Sound("Weapon_Flashbang.Explode"))
	local pos = self:GetPos()

	local rf = RecipientFilter()
	rf:AddPVS(pos)
	rf:RemoveRecipientsByTeam(TEAM_CP) -- CPs and OTA don't get flashed
	rf:RemoveRecipientsByTeam(TEAM_OTA)

	for k, v in ipairs(rf:GetPlayers()) do

		-- This will make it so those wearing a Combat
		-- Combatt gas mask will not be affected by Flashbangs.
		-- Unrealistic, but better for gameplay.
		if v.FlashSafe then
			rf:RemovePlayer( v )
			continue
		end
		
		local tr = util.TraceLine({
			start = pos,
			endpos = v:EyePos(),
			filter = {self, v}
		})

		if tr.HitWorld then
			rf:RemovePlayer(v)
			continue
		end

		-- This funky math will convert two directional vectors into a nice degree
		-- use this degree to test vision. I basically glued this together from
		-- SCP: Breach's code. (sophie)
		local v1 = v:GetAngles():Forward():GetNormalized()
		local v2 = (v:GetPos() - self:GetPos()):GetNormalized()
		local angle = math.deg( math.acos( v2:Dot( v1 ) ) )

		-- Change "80" to whatever the fuck you want. Keep in mind this is like,
		-- horizontal only and can be fucky at times. Experiment before pushing
		-- to live! (sophie)
		if ( angle < 90 ) then
			rf:RemovePlayer(v)
			continue
		end
	end
	
	for k, v in ipairs(rf:GetPlayers()) do
		v:SetRunSpeed(v:GetWalkSpeed())

		timer.Simple(7, function()
			v:SetRunSpeed(impulse.Config.JogSpeed)
		end)
	end
	net.Start("impulseLSGetFlashed")
	net.WriteEntity(self)	
	net.Send(rf)

	net.Start("impulseLSDoFlash")
	net.WriteEntity(self)
	net.Broadcast()
end

if SERVER then
	util.AddNetworkString("impulseLSGetFlashed")
	util.AddNetworkString("impulseLSDoFlash")
else
	net.Receive("impulseLSDoFlash", function()

		local ent = net.ReadEntity()

		if not IsValid(ent) then
			return
		end

		local pos = ent:GetPos()

		local dLight = DynamicLight( ent:EntIndex() )

		if dLight then
			dLight.pos = pos
			dLight.r = 255
			dLight.g = 255
			dLight.b = 255
			dLight.brightness = 6
			dLight.Size = 600
			dLight.DieTime = CurTime() + 0.1																		
		end			

	end)
	net.Receive("impulseLSGetFlashed", function()
		local ent = net.ReadEntity()

		

		if not IsValid(ent) then
			return
		end

		local pos = ent:GetPos()

		debugoverlay.Sphere(pos, minRange, 10, Color(255, 0, 0))
		debugoverlay.Sphere(pos, midRange, 10, Color(255, 100, 0))
		debugoverlay.Sphere(pos, maxRange, 10, Color(255, 255, 0))
		-- need to work out if you are looking in opposite direction or not, if you are then take dist and divide the effect by dist
		-- need to move this to the client mostly imo, and also make the screenfade be part of HUDPaint or maybe colorcorrection?
		-- movement speed affect, using melee slow down method
		-- gas mask reduced affect, cp/ota reduced affect

		--k:ScreenFade(SCREENFADE.IN, color_white, 7, 1)
		

		--[[timer.Simple(7, function()
			LocalPlayer():SetDSP(0) -- think this causes sound bugs lol, actually this might not be needed
		end)]]

		-- test ranges
		local lp = LocalPlayer()
		local plyPos = lp:GetPos()
		
		local vis = true -- old system fallback too lazy
		
		--print(math.abs((math.AngleDifference(lp:EyeAngles().y,ang.y) - lp:EyeAngles().y)) )]]

		if plyPos:DistToSqr( pos ) < minRangeSqr then
			if vis then
				lp:ScreenFade(SCREENFADE.IN, color_white, 6, 1)
			end
			impulse_beingGassed = CurTime() + 10
			LocalPlayer():SetDSP(35) -- ringing ears
			surface.PlaySound("Weapon_Flashbang.Explode")
			return
		end

		if plyPos:DistToSqr( pos ) < midRangeSqr then
			if vis then
				lp:ScreenFade(SCREENFADE.IN, color_white,  4, 1)
			end
			impulse_beingGassed = CurTime() + 7
			LocalPlayer():SetDSP(35) -- ringing ears
			surface.PlaySound("Weapon_Flashbang.Explode")
			return
		end

		if plyPos:DistToSqr( pos ) < maxRangeSqr then
			if vis then
				lp:ScreenFade(SCREENFADE.IN, color_white,  2, 1)
			end
			impulse_beingGassed = CurTime() + 5
			LocalPlayer():SetDSP(35) -- ringing ears
			surface.PlaySound("Weapon_Flashbang.Explode")
			return
		end
		
	end)
end

sound.Add({
	name = "Weapon_Flashbang.Explode",
	sound = {"impulse/flashbang1.ogg", "impulse/flashbang2.ogg"},
	channel = CHAN_AUTO,
	level = SNDLVL_GUNFIRE,
	volume = 1,
	pitch = {85, 115}
})
