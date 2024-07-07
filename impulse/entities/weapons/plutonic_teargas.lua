-- "addons\\plutonic\\lua\\weapons\\plutonic_teargas.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

hook.Add("Initialize", "impulseLSAmmoGas", function()
    game.AddAmmoType({
        name = "gas"
    })
end)

SWEP.Base = "plutonic_base_projectile"
SWEP.PrintName = "Tear Gas"
SWEP.Category = "Plutonic: HL2RP Weapons"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.IsAlwaysRaised = true
SWEP.HoldType = "grenade"
SWEP.WorldModel = Model("models/weapons/w_eq_smokegrenade.mdl")
SWEP.ViewModel = Model("models/weapons/cstrike/c_eq_smokegrenade.mdl")
SWEP.ViewModelFOV = 50

SWEP.Attachments = {}
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.Primary.Sound = ""
SWEP.Primary.Recoil = 0
SWEP.Primary.Delay = 0.8
SWEP.Primary.HitDelay = 0.1
SWEP.Primary.Ammo = "gas"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Projectile = {}
SWEP.Projectile.Model = Model("models/weapons/w_eq_smokegrenade_thrown.mdl")
SWEP.Projectile.FireSound = Sound("weapons/smokegrenade/sg_explode.wav")
SWEP.Projectile.HitSound = Sound("weapons/smokegrenade/grenade_hit1.wav")
SWEP.Projectile.Touch = false
SWEP.Projectile.ForceMod = 1.2

-- controls how long till gas deploys and how long the gas stays around
-- the particles time is controled inside the particle not here they need to be synced to be consistient
SWEP.Projectile.Timer = 5
SWEP.Projectile.RemoveWait = 40

sound.Add({
    name = "Weapon_TearGas.Hiss",
    sound = "npc/env_headcrabcanister/hiss.wav",
    level = 56,
    pitch = 100
})

-- calls the effect and sound
function SWEP:ProjectileFire()
    local sfx = EffectData()
    sfx:SetEntity(self)
    sfx:SetOrigin(self:GetPos())
    util.Effect("impulse_teargas", sfx, nil, true)
    self:EmitSound("Weapon_TearGas.Hiss")
    hook.Run("ProjectileThrown", self.Owner, "Teargas")
end

-- Removes nade after SWEP.Projectile.RemoveWait
function SWEP:ProjectileRemove()
    self:StopSound("Weapon_TearGas.Hiss")
end

-- Sets range of the damage sphere ignore the ^2
local range = 200 ^ 2

function SWEP:ProjectileThink()
    local pos = self:GetPos()
    local owner = self:GetOwner()
    if (self.NextDamageCheck or 0) > CurTime() then return end
    self.NextDamageCheck = CurTime() + 3
    local searchPlayers = player.GetAll()
    local origin = self:GetPos()

    -- debug sphere shows the outline
    -- debugoverlay.Sphere(pos, 200, 10, Color(255, 0, 0))
    
	for v = 1, #searchPlayers do
        local k = searchPlayers[v]
        
		-- impulse player protection
        if not k.beenInvSetup then 
			continue 
		end

        -- immune to gas if wearing a mask or if cp
       if k.GasSafe or k:IsCP() then continue end

		-- this sends a message the first time you enter the gas and waits
		-- the time the projectile is out
        if k:GetPos():DistToSqr(origin) < range then
            
			k:TakeDamage(5, owner, self)
			
			if not k.HasBeenNotified then
				k:Notify("You feel how the gas is making you unwell...")
				k.HasBeenNotified = true
	
				timer.Simple(self.Projectile.RemoveWait, function()
					if not IsValid(k) then 
						return 
					end
					k.HasBeenNotified = false
				end)
			end
        end
    end
end