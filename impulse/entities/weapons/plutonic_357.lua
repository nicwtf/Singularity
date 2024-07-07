-- "addons\\plutonic\\lua\\weapons\\plutonic_357.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"


SWEP.PrintName = ".357 Magnum"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ItemClass = "wep_357"

SWEP.HoldType = "revolver"
SWEP.Attachments = {}

SWEP.ItemClass = "wep_357"

SWEP.WorldModel = Model("models/weps/w_357.mdl")
SWEP.ViewModel = Model("models/weapons/ez2/c_357.mdl")
SWEP.ViewModelFOV = 74
SWEP.ViewModelOffset = Vector(0, -3, 0)
SWEP.ViewModelOffsetAng = Angle(0, 0, 0)

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.BarrelLength = 7

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_357.Reload")
SWEP.EmptySound = Sound("Weapon_357.Empty")

sound.Add({
	name = "CUST.Weapon_357.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = {
		"weapon/357/357_fire_player_01.wav",
		"weapon/357/357_fire_player_02.wav",
		"weapon/357/357_fire_player_03.wav",
		"weapon/357/357_fire_player_04.wav",
		"weapon/357/357_fire_player_05.wav",
		"weapon/357/357_fire_player_06.wav"
		
	}
})

SWEP.Primary.Sound = Sound("CUST.Weapon_357.Single")
SWEP.Primary.Recoil = 7.4 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 51
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = 1.3

SWEP.ReloadAttach = 1

SWEP.Primary.Ammo = "357"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.5
SWEP.Spread.IronsightsMod = 0.4 -- multiply
SWEP.Spread.CrouchMod = 0.9 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.12 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 1.8 -- movement speed effect on spread (additonal)

SWEP.SwayLevel = 1
SWEP.SwayIdle = 0.8
SWEP.SwayRightMultiplier = 3.5
SWEP.SwayUpMultiplier = 3.4

SWEP.IronsightsSpeed = 4
SWEP.IronsightsRocking = 20
SWEP.IronsightsPos = Vector(-2.66, 1.14, 1.52)
SWEP.IronsightsAng = Angle(.23, -0, 4.374)
SWEP.IronsightsFOV = 0.85
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1
SWEP.BlowbackPos = Vector(0, -8, -12)
SWEP.BlowbackAngle = Angle(16, -1.2, 0)
 
SWEP.LoweredPos = Vector(3.559, -8.08, -8.641)
SWEP.LoweredAng = Angle(44.4, -5.301, 1.299)

SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.CannotChamber = true
SWEP.MuzzleFlashAttachment = nil
SWEP.VLowered = false
SWEP.VTime = CurTime()
SWEP.DrawTime = 0
SWEP.HasLoweredActivity = false

function SWEP:CustomShootEffects()
	self.VTime = CurTime() + 0.1
	self.VLowered = false
end
SWEP.IronsightsAllowAnim = {
    [ACT_VM_PRIMARYATTACK] = true
}
SWEP.HasPlayedIntro = false

function SWEP:CustomShootEffects()
    timer.Simple(0,function()
        if self:GetIronsights() then
			
			self:PlayAnim(ACT_VM_PRIMARYATTACK)
			timer.Simple(Plutonic.FireRate.RPM(88), function()
				if not IsValid(self) then return end
				self:PlayAnim(ACT_VM_IDLE)
			end)
		end
	end)
end

function SWEP:QueueIdle()
end