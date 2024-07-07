-- "addons\\plutonic\\lua\\weapons\\plutonic_spas.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base_shotgun"

SWEP.PrintName = "SPAS-12"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"

SWEP.WorldModel = Model("models/horizons_weapons/w_shotgun.mdl")
SWEP.ViewModel = Model("models/horizons_weapons/v_shotgun.mdl")
SWEP.ViewModelFOV = 68


SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadShellSound = Sound("Weapon_Shotgun.Reload")
SWEP.EmptySound = Sound("Weapon_Shotun.Empty")

SWEP.Attachments = {}
SWEP.Primary.Sound = Sound("Weapon_Shotgun.Single")
SWEP.Primary.Recoil = 5 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 13
SWEP.Primary.NumShots = 6
SWEP.Primary.Cone = 0.069
SWEP.Primary.Delay = Plutonic.FireRate.RPM(80)
SWEP.Primary.RecoilUp = 1
SWEP.Primary.RecoilDown = 1
SWEP.Primary.RecoilSide = 1

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6

SWEP.Primary.Shell = "ShotgunShellEject"
SWEP.Primary.ShellScale = 1
SWEP.Primary.ShellAttachment = 2

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.BarrelLength = 12.5
SWEP.Primary.StartFalloff = 200
SWEP.Primary.EndFalloff = 750
SWEP.Spread = {}
SWEP.Spread.Min = 0.0
SWEP.Spread.Max = 1
SWEP.Spread.IronsightsMod = 0.7 -- multiply
SWEP.Spread.CrouchMod = 0.7 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.01 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.15 -- movement speed effect on spread (additonal)
SWEP.IronsightsPos = Vector(-3.8, -9.44, 2)
SWEP.IronsightsAng = Angle(-1.5, -0, -2.8)
SWEP.IronsightsFOV = 1
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsAllowAnim = {
    [ACT_SHOTGUN_PUMP] = true
}
SWEP.CustomEvents = {
	[ACT_VM_LOWERED_TO_IDLE] = ACT_VM_IDLE_TO_LOWERED,
	[ACT_VM_IDLE_TO_LOWERED] = ACT_VM_LOWERED_TO_IDLE
}
SWEP.BlowbackPos         = Vector(0, -1, -0) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0, 0, 0)

SWEP.CenteredPos = Vector(-2.4,1.22,  -4.58)
SWEP.CenteredAng = Angle(2.92, 1.509, -23.216)

function SWEP:CustomShootEffects()
end

SWEP.LoweredAng = Angle(12, 30, 0)
SWEP.LoweredPos = Vector(6, -4, -5)

SWEP.LowerAngles = Angle(12, -9, -8)
SWEP.LowerPos = Vector(-2, -5, -2)

SWEP.ReloadAttach = 2

SWEP.HasLoweredActivity = false
SWEP.HasPlayedIntro = false
function SWEP:Deploy()
	
	self.DrawTime = CurTime() + 2
	self.BaseClass.Deploy(self)

	if !self.HasPlayedIntro then
		local vmodel = self.Owner:GetViewModel()
		vmodel:SetSequence( vmodel:LookupSequence("firstdraw") )
		self.HasPlayedIntro = true
	end
end

function SWEP:CustomThink()
end

SWEP.VLowered = false
SWEP.VTime = CurTime()
SWEP.DrawTime = 0
SWEP.HasLoweredActivity = false
SWEP.CannotChamber = true


SWEP.Reverb = {}
SWEP.Reverb.Primary = {}

SWEP.Reverb.Primary.IndoorEnabled = true
SWEP.Reverb.Primary.Indoor = Sound("weapons/arccw/mag7/mag7_distant_02.wav")
SWEP.Reverb.Primary.IndoorRange = 12000

SWEP.Reverb.Primary.OutdoorEnabled = true
SWEP.Reverb.Primary.Outdoor = Sound("weapons/arccw/mag7/mag7_distant_02.wav")
SWEP.Reverb.Primary.OutdoorRange = 50000

SWEP.MuzzleEffect = "muzzleflash_shotgun"

function SWEP:QueueIdle()
end
SWEP.ReloadProceduralCameraFrac = 1
function SWEP:GetReloadAnimation(pos, ang)
	local vm = self.Owner:GetViewModel()

	local bone = "pump"

	local tag_view = vm:GetBonePosition(vm:LookupBone(bone))

	local view = (tag_view-pos):GetNormalized():Angle() 

	return view
end