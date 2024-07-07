-- "addons\\plutonic\\lua\\weapons\\plutonic_mosinnagant.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- models/weapons/v_mosin.mdl
AddCSLuaFile()
hook.Add("Initialize","Landis762Ammo",function()
	game.AddAmmoType({
		name = "Rifle",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE_AND_WHIZ,
		force = 5000,
		minsplash = 10,
		maxsplash = 100
	})
end)

SWEP.Base = "plutonic_base_shotgun"

SWEP.PrintName = "Mosin-Nagant"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/w_grub_mosin.mdl")
SWEP.ViewModel = Model("models/weapons/c_ins2_mosin_nagant.mdl")
SWEP.ViewModelOffset = Vector()
SWEP.ViewModelOffsetAng = Angle()
SWEP.ViewModelFOV = 70
SWEP.UseHands = true
SWEP.CenteredPos = Vector(0,0,0)
SWEP.CenteredAng = Angle(0, 0, 0)

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")
SWEP.EmptySound = Sound("weapons/mosin_nagant/mosin_empty.wav")

SWEP.Primary.Sound = Sound("Weapon_Mosin.Single")
SWEP.Primary.Sound_World = Sound("Weapon_Mosin.NPC_Single")
SWEP.Primary.Recoil = 15 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 56
SWEP.Primary.PenetrationScale = 1.1
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.029
SWEP.Primary.Delay = Plutonic.FireRate.RPM(25)
SWEP.Primary.Piercing = true
SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 5
SWEP.Primary.HeadshotScale = 2.22

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1


SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.1
SWEP.Spread.IronsightsMod = 0.04 -- multiply
SWEP.Spread.CrouchMod = 0.94 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.07 -- movement speed effect on spread (additonal)
SWEP.IronsightsSpeed = 3.5
SWEP.IronsightsRocking = 24
SWEP.IronsightsPos = Vector(-3.090000, -2.000000, 1.590000)
SWEP.IronsightsAng = Angle(0.035000, 0.020000, 0.000000)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 1
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1
SWEP.BlowbackPos = Vector(0, -8.3, -1)
SWEP.BlowbackAngle = Angle(3, -0, 0)
SWEP.NoCrosshair = true
SWEP.DoEmptyReloadAnim = true
SWEP.initRT = false

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.BarrelLength = 16

function SWEP:ExtraViewModelDrawn()
end

function SWEP:DrawHUD()
	if SERVER then return end

	if not self.initRT then
		self.ScopeTex = Material("ph_scope/ph_scope_lens3")
		self.RT = GetRenderTarget( "longswordscope_", ScrW(), ScrH(), true )
		self.RT_MAT = CreateMaterial("longsword_scope_material", "UnlitGeneric", {
			["$model"] = 1,
			["$basetexture"] = self.RT:GetName()
		})
		self.RT_MAT:SetTexture("$basetexture", self.RT)
		self.RT_MAT:SetFloat("$phong", 1)
		self.RT_MAT:SetFloat("$phongexponent", 16)
		--self.RT_MAT:SetFloat("$pp_colour_brightness", 10)
		self.RT_MAT:SetFloat( "$pp_colour_addr", 0 )
		self.RT_MAT:SetFloat( "$pp_colour_addg", 0 )
		self.RT_MAT:SetFloat( "$pp_colour_addb", 0 )
		self.RT_MAT:SetFloat( "$pp_colour_mulr", 0 )
		self.RT_MAT:SetFloat( "$pp_colour_mulg", 0 )
		self.RT_MAT:SetFloat( "$pp_colour_mulb", 0 )
		self.RT_MAT:SetShader("UnlitGeneric")
		self.RT_MAT:SetTexture("$bumpmap", "models/debug/debugwhite")
		self.RT_MAT:Recompute()
		
		
		self.initRT = true
		
	end
	if not IsValid(self.AttachedCosmetic) then
		return
	end

	local a = self.AttachedCosmetic

	render.PushRenderTarget(self.RT)
	render.OverrideAlphaWriteEnable(true, true )
	cam.Start2D()
		render.Clear( 255, 255, 255, 0, true)
		render.RenderView({
			origin = a:GetPos(),
			angles = a:GetAngles(),
			fov = 12.5,
			x = 0,
			y = 0,
			w = ScrW(),
			h = ScrH(),
			drawviewmodel = false,
			drawhud = false,
			aspectratio = 1
		})
		
	cam.End2D()
	draw.NoTexture()
	

	render.PopRenderTarget()


	if IsValid(self.AttachedCosmetic) then
		local a = self.AttachedCosmetic
		a:SetSubMaterial(1, "!longsword_scope_material")
		a:SetSubMaterial(2, "")
	end
end

local copyIronFOV = SWEP.IronsightsFOV + 0
local copyIronSens = SWEP.IronsightsSensitivity + 0
local copyCone = SWEP.Primary.Cone + 0
local copyIronMod = SWEP.Spread.IronsightsMod + 0
local copyVelMod = SWEP.Spread.VelocityMod + 0
local copyDamage = SWEP.Primary.Damage + 0
local copyRPM = SWEP.Primary.Delay + 0
local copyPen = SWEP.Primary.PenetrationScale + 0
SWEP.Attachments = {
	hunting_scope = {
		Cosmetic = {
			Model = "models/weapons/tfa_ins2/upgrades/a_optic_mosin.mdl",
			Bone = "A_Optic",
			Pos = Vector(0, -0.5, 0),
			Ang = Angle(90, 0, 90),
			Scale = 1,
			Skin = 0--[[],
			World = {
				Pos = Vector(11, 1.5, -6),
				Ang = Angle(0, 180, 90),
				Scale = 0
			}]]
		},
		ModSetup = function(e)
			e.IronsightsFOV = 0.4
			e.IronsightsSensitivity = 0.3
			e.IronsightsPos = Vector(-3.055, 2.000000, 1.238)
		end,
		ModCleanup = function(e)
			e.IronsightsFOV = copyIronFOV
			e.IronsightsSensitivity = copyIronSens
			e.IronsightsPos = Vector(-3.090000, -4.000000, 1.590000)
		end,
		Behaviour = "dumy",
		NeedsHDR = true,
		ScopeTexture = Material("ph_scope/ph_scope_lens3")
	}
}

--178
function SWEP:CustomShootEffects()
    timer.Simple(0,function()
        timer.Simple(0.5,function()
			if IsValid(self) then
            	self:PlayAnim(178)
            	self:QueueIdle()
			end
        end)
    end)
end

SWEP.LoweredPos = Vector(4,-2,-8) --Vector(0, -16, -13)
SWEP.LoweredAng = Angle(10, 35, -12)

sound.Add({
	name = "Weapon_Mosin.Single",
	sound = "weapons/mosin_nagant/mosin_fire.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})

sound.Add({
	name = "Weapon_Mosin.NPC_Single",
	sound = ")weapons/mosin_nagant/mosin_fire.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})


sound.Add({
	name = "TFA_INS2.Mosin.Boltback",
	sound = "weapons/mosin_nagant/mosin_boltback.wav",
	channel = CHAN_AUTO,
	level = 70,
	pitch = {95,105}
})

sound.Add({
	name = "TFA_INS2.Mosin.BoltRelease",
	sound = "weapons/mosin_nagant/mosin_boltrelease.wav",
	channel = CHAN_AUTO,
	level = 70,
	pitch = {95,105}
})

sound.Add({
	name = "TFA_INS2.Mosin.BoltLatch",
	sound = "weapons/mosin_nagant/mosin_boltlatch.wav",
	channel = CHAN_AUTO,
	level = 70,
	pitch = {95,105}
})

sound.Add({
	name = "TFA_INS2.Mosin.Boltforward",
	sound = "weapons/mosin_nagant/mosin_boltforward.wav",
	channel = CHAN_AUTO,
	level = 70,
	pitch = {95,105}
})

sound.Add({
	name = "TFA_INS2.Mosin.Draw",
	sound = "weapons/mosin_nagant/mosin_draw.wav",
	channel = CHAN_AUTO,
	level = 70,
	pitch = {95,105}
})


sound.Add({
	name = "TFA_INS2.Mosin.Roundin",
	sound = {"weapons/mosin_nagant/mosin_bulletin_1.wav","weapons/mosin_nagant/mosin_bulletin_2.wav","weapons/mosin_nagant/mosin_bulletin_3.wav"},
	channel = CHAN_AUTO,
	level = 70,
	pitch = {95,105}
})
-- weapons/mosin_nagant/mosin_bulletin_1.wav


sound.Add({
	name = "Weapon_Mini14.Empty",
	sound = "weapons/mni14/mini14_empty.wav",
	channel = CHAN_AUTO,
	pitch = {95,105}
})

SWEP.ReloadProceduralCameraFrac = .2

function SWEP:GetReloadAnimation(pos, ang)
	local vm = self.Owner:GetViewModel()
	local bone = vm:LookupBone("Magazine")
	if not bone then return angle_zero end
	local tag_view = vm:GetBonePosition(bone)

	local view = (tag_view-pos):GetNormalized():Angle() 

	return view
end