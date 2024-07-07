-- "addons\\plutonic\\lua\\weapons\\plutonic_fishingrod.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base_melee"

SWEP.PrintName = "Fishing Rod"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee2"

SWEP.WorldModel = Model("models/weapons/hl2meleepack/w_hook.mdl")
SWEP.Attachments = {}
SWEP.ViewModel = Model("models/weapons/hl2meleepack/v_hook.mdl")
SWEP.ViewModelFOV = 74

SWEP.Slot = 4
SWEP.SlotPos = 1

--SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("Canister.ImpactHard")
SWEP.Primary.ImpactSoundWorldOnly = true
SWEP.Primary.Recoil = 1.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 19 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.HitDelay = 0.3
SWEP.Primary.Delay = 0.9
SWEP.Primary.Range = 75
SWEP.Primary.StunTime = 0.3

function SWEP:PrePrimaryAttack()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("misscenter1"))
end

function SWEP:MeleeHitFallback(tr)
	
	local fishname = {"Leach"}
	
	if tr and tr.MatType == MAT_SLOSH then
		--if self.Owner.TreeLastPos and self.Owner.TreeLastPos:DistToSqr(self.Owner:GetPos()) < 6200 then
			self.Owner.TreeLastHP = (self.Owner.TreeLastHP or math.random(5, 8)) - 1

			--if self.Owner.TreeLastHP < 1 then
				if self.Owner:CanHoldItem("util_leach") then -- specific util until more fish are added
					self.Owner:GiveInventoryItem("util_leach")
					self.Owner:Notify("You have gained 1 "..fishname[1])

					self.Owner.TreeLastPos = self.Owner:GetPos()
					self.Owner.TreeLastHP = math.random(5, 8)
				else
					self.Owner:Notify("You don't have the space to hold any more fish.")
					self.Owner.TreeLastPos = self.Owner:GetPos()
					self.Owner.TreeLastHP = 5
				end
			--end
		--else
		--	self.Owner.TreeLastPos = self.Owner:GetPos()
		--	self.Owner.TreeLastHP = math.random(5, 8)
		--end

		self:EmitSound("Wood.ImpactHard")

		return true
	end

	return false
end