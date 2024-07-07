-- "addons\\plutonic\\lua\\weapons\\plutonic_combinesniper.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "Combine Sniper"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.HoldType = "ar2"
SWEP.BarrelLength = 21
SWEP.ItemClass = "wep_sniperrifle"

SWEP.WorldModel = Model("models/landis/weapons/osr/w_combinesniper.mdl")
SWEP.ViewModel = Model("models/landis/weapons/osr/c_combinesniper.mdl")
SWEP.ViewModelFOV = 64
SWEP.ViewModelOffset = Vector(-1.88, 0, -1.081)
SWEP.ViewModelOffsetAng = Angle(1.1, -1, -0.5)
SWEP.CenteredPos = Vector(0,0,0)
SWEP.CenteredAng = Angle(0, 0, 0)

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("combinesniper/reload1.wav")
SWEP.EmptySound = Sound("Weapon_AR2.Empty")

SWEP.Primary.Sound = Sound("combinesniper/echo1.wav")
SWEP.Primary.Recoil = 8.43 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 55
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.002 -- base spread value
SWEP.Primary.Delay = Plutonic.FireRate.RPM(45)
SWEP.Primary.Tracer = "AR2Tracer"
SWEP.CannotChamber = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = 3

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.5
SWEP.Spread.IronsightsMod = 0.65 -- multiply
SWEP.Spread.CrouchMod = 0.65 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.4 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.12 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.16 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-9.08, -5.026, 1) - Vector(-1.88, 0, -1.081)
SWEP.IronsightsAng = Angle(-1.101, -1, 0.703)- Angle(1.1, -1, -0.5)

SWEP.IronsightsFOV = .8
SWEP.IronsightsSensitivity = 0.2
SWEP.IronsightsCrosshair = false

SWEP.MuzzleEffect = "muzzleflash_shotgun"

SWEP.DoEmptyReloadAnim = false
SWEP.BlowbackPos = Vector(0, 0, 0)
SWEP.BlowbackAngle = Angle()

function SWEP:Reload()
	if not self:CanReload() then return end

	self.Owner:DoReloadEvent()

	if not self.DoEmptyReloadAnim or self:Clip1() != 0 then
		self:PlayAnim(ACT_VM_RELOAD2)
	else
		self:PlayAnim(ACT_VM_RELOAD_EMPTY)
	end
	self:QueueIdle()

	if self.ReloadSound then 
		self:EmitSound(self.ReloadSound) 
	elseif self.OnReload then
		self.OnReload(self)
	end

	self:SetReloading( true )
	self:SetReloadTime( CurTime() + 2 )

	hook.Run("LongswordWeaponReload", self.Owner, self)
end

SWEP.LoweredPos = Vector(5.119, -1.921, -0.24)
SWEP.LoweredAng = Angle(-5.7, 29.7, -1.9)

/*
SWEP.IronSightsPos = Vector(5.119, -0.921, -0.24)
SWEP.IronSightsAng = Vector(-5.7, 29.7, -1.9)
*/

function SWEP:CustomShootEffects()
	if IsValid(self) then
		if self:GetIronsights() then
			self:PlayAnim(ACT_VM_PRIMARYATTACK)
			self:QueueIdle()
		end
	end
end



local copyIronPos = Vector(SWEP.IronsightsPos.x, SWEP.IronsightsPos.y, SWEP.IronsightsPos.z)
local copyIronFOV = SWEP.IronsightsFOV + 0
local copyIronSens = SWEP.IronsightsSensitivity + 0
local copyIronMod = SWEP.Spread.IronsightsMod + 0
local copySpreadVel = SWEP.Spread.VelocityMod + 0

SWEP.Attachments = {
	osr_scope = {
		Cosmetic = {
			Model = "nill",
			Bone = "Base",
			Pos = Vector(-0.38, 2, 7.791),
			Ang = Angle(90, -12.858, -90),
			Scale = 0.26,
			Skin = 0
		},
		ModSetup = function(e)
			e.IronsightsPos = Vector(-4.624, -17.286, 0.201)
			e.IronsightsFOV = .8
			e.FOVScoped = 0.16
			e.Spread.IronsightsMod = 0.4
			e.IronsightsSensitivity = 0.05
			e.Spread.VelocityMod = 1.1
			e.Recoil = .5

			e.Primary.Burst = false
		end,
		ModCleanup = function(e)
			e.IronsightsPos = copyIronPos
			e.IronsightsFOV = copyIronFOV
			e.IronsightsSensitivity = copyIronSens
			e.Spread.VelocityMod = copySpreadVel
			e.FOVScoped = nil
			e.Spread.IronsightsMod = nil

			e.Primary.Burst = false
		end,
		NeedsHDR = true,
		Behaviour = "sniper_sight",
		ScopePaint = function(wep)
			if not CMB_OVERLAY then
		        CMB_OVERLAY = Material("effects/combine_binocoverlay")
		        CMB_OVERLAY:SetFloat("$salpha", "0.2")
		        CMB_OVERLAY:Recompute()
			end

			surface.SetDrawColor(Color(255, 255, 255, 255))
	        surface.SetMaterial(CMB_OVERLAY)
	        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
	        
	        local lp = LocalPlayer()
	       	local trace = {}
			trace.start = lp:EyePos()
			trace.endpos = trace.start + lp:GetAimVector() * 7000
			trace.filter = lp

			local traceData = util.TraceLine(trace)
			local dist = "UNKWN"

			if not traceData.Hit and traceData.HitPos then
				return
			end

			dist = traceData.HitPos:Distance(lp:GetPos()) / 39.3701
			dist = math.floor(dist)

	    	local ang = lp:EyeAngles()
    		local bearing = impulse.AngleToBearing(ang)

			local w = (ScrW() * .5) + 200
			local h = (ScrH() * .5) - 150
			local c = Color(230, 0, 0)
			draw.SimpleText("RANGE: "..dist.."m", "DebugFixed", w, h, c)
			draw.SimpleText("BEARING: "..bearing.."º", "DebugFixed", w, h + 14, c)

			if wep:GetBursting() then
				draw.SimpleText("** FIRING **", "DebugFixed", w, h + 28, c)
			end
		end,
		ScopeTexture = Material("ph_scope/ph_scope_lens6")
	}
}

function SWEP:CustomThink()
	self:GiveAttachment("osr_scope")
end