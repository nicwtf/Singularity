-- "addons\\plutonic\\lua\\weapons\\plutonic_mcx.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "MCX Virtus"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/w_rif_m4a1.mdl")
SWEP.ViewModel = Model("models/weapons/c_mcxvirtus.mdl")
SWEP.ViewModelFOV = 77
SWEP.UseHands =  true

SWEP.BarrelLength = 11

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.ReloadSound = Sound("")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.DoEmptyReloadAnim = true

sound.Add({
	name = "Weapon_MCXU.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = {
		"weapon/oicw/oicw_fire_player_01.wav",
		"weapon/oicw/oicw_fire_player_02.wav",
		"weapon/oicw/oicw_fire_player_03.wav",
		"weapon/oicw/oicw_fire_player_04.wav",
		"weapon/oicw/oicw_fire_player_05.wav",
		"weapon/oicw/oicw_fire_player_06.wav",
		"weapon/oicw/oicw_fire_player_07.wav",
		"weapon/oicw/oicw_fire_player_08.wav",
		"weapon/oicw/oicw_fire_player_09.wav",
		"weapon/oicw/oicw_fire_player_10.wav",
		"weapon/oicw/oicw_fire_player_11.wav",
		"weapon/oicw/oicw_fire_player_12.wav"
	}
})

SWEP.Primary.Sound = Sound("Weapon_MCXU.Single")
SWEP.Primary.Recoil = .3 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 11
SWEP.Primary.PenetrationScale = 0.25
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.050
SWEP.Primary.Delay = RPM(860)
SWEP.Primary.Piercing = true

SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0.00
SWEP.Spread.Max = 1
SWEP.Spread.IronsightsMod = 0.5 -- multiply
SWEP.Spread.CrouchMod = 0.5 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.03 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.3 -- movement speed effect on spread (additonal)
SWEP.IronsightsSpeed = 5.2
SWEP.IronsightsPos = Vector(-2.541, -1.15, 0.4)
SWEP.IronsightsAng = Angle(0, .4, 1.1)
SWEP.IronsightsFOV = 0.76
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.BlowbackPos         = Vector(0, -2, -0.01) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0.0, -0, 0)

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.MuzzleFlashAttachment = "1"

SWEP.LoweredPos = Vector(6, -7, -1.1)
SWEP.LoweredAng = Angle(12, 43, 15)
SWEP.CenteredPos = Vector(-2.031,1.22,  -4.58)
SWEP.CenteredAng = Angle(2.92, 2.509, -23.216)

sound.Add({
	name = "Weapon_MCX.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = "weapons/galil/galil_shoot.ogg"
})

sound.Add({
	name = "ArcCW_MCX.Magin",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105},
	sound ={ "weapons/cod_mw_2k19/virtus_mcx/mcx_reload_mag_in.wav", "weapons/cod_mw_2k19/virtus_mcx/mcx_reload_mag_in_2.wav"}
})

sound.Add({
	name = "ArcCW_MCX.Magin2",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105},
	sound ={ "weapons/cod_mw_2k19/virtus_mcx/mcx_reload_mag_in.wav", "weapons/cod_mw_2k19/virtus_mcx/mcx_reload_mag_in_2.wav"}
})


sound.Add({
	name = "ArcCW_MCX.Maginsoh",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105},
	sound = "weapons/cod_mw_2k19/virtus_mcx/mcx_reload_mag_insoh.wav"
})

sound.Add({
	name = "ArcCW_MCX.Magout",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105},
	sound = "weapons/cod_mw_2k19/virtus_mcx/mcx_reload_mag_out.wav"
})

sound.Add({
	name = "ArcCW_MCX.Bolt",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105},
	sound = "weapons/cod_mw_2k19/virtus_mcx/mcx_reload_bolt.wav"
})

SWEP.Attachments = {}