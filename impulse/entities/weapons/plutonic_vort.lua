-- "addons\\plutonic\\lua\\weapons\\plutonic_vort.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
if SERVER then
	util.AddNetworkString("impulseHL2RPVortBeam")
end
SWEP.Base = "plutonic_base_melee"

SWEP.PrintName = "Vortigaunt Powers"
SWEP.Category = "Plutonic: Misc"
SWEP.Instructions = "Fire energy bolts that explode in a radius, these powers take a bit of your health so don't use them too fast. [EXPERIMENTAL]"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"
SWEP.HitAnim = ACT_VM_SECONDARYATTACK

SWEP.WorldModel = Model("")
SWEP.ViewModel = Model("models/weapons/c_vortbeamvm.mdl")
SWEP.ViewModelFOV = 54
SWEP.CenteredPos = Vector(0,0,0)
SWEP.CenteredAng = Angle(0, 0, 0)

SWEP.Slot = 4
SWEP.SlotPos = 1

--SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("Canister.ImpactHard")
SWEP.Primary.ImpactSoundWorldOnly = true
SWEP.Primary.Recoil = 2.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 0 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.HitDelay = 0.4
SWEP.Primary.Delay = 1.4
SWEP.Primary.Range = 9000
SWEP.Primary.ImpactEffect = "none"
SWEP.Primary.StunTime = 0.2
SWEP.Projectile = {}
SWEP.Projectile.Model = Model("models/items/ar2_grenade.mdl")
SWEP.Projectile.Touch = true
SWEP.Projectile.FireSound = Sound("BaseGrenade.Explode")
SWEP.Projectile.ForceMod = 4
SWEP.DamagedAmount = 0
SWEP.IsAlwaysRaised = true
SWEP.NextHealThink = CurTime() + 1
local charge = Sound("npc/vort/attack_charge.wav")
local shoot  = Sound("npc/vort/attack_shoot.wav")

local Clamp = math.Clamp

--[[
	HEALING MECHANIC:

	Health Regens every 0.75 seconds
	It heals to your pure health value, meaning it only gives back what you lost from vort energy
	does this using FUNNY FUICKING MATH :)
]]

-- function SWEP:Think()
--	if self.NextHealThink < CurTime() then
--		self.NextHealThink = CurTime() + 0.75
--		if self.DamagedAmount > 0 then
--			self.DamagedAmount = Clamp(self.DamagedAmount - 1,0,100)
--			self.Owner:SetHealth(Clamp(self.Owner:Health()+1,0,100))
--		end
--	end
-- end

function SWEP:VortBeam()
	-- server networks the effect, clients run it since it uses control points.
	if SERVER then
		local ply = self.Owner
		if not IsValid(ply) then return end
		local blastPos = ply:GetEyeTrace().HitPos
		if not blastPos then return end -- literally impossible
		local rf = RecipientFilter()
		rf:AddPVS(ply:GetPos())
		rf:AddPVS(blastPos)
		net.Start("impulseHL2RPVortBeam")
		net.WriteEntity(ply)
		net.WriteVector(blastPos)
		net.Send(rf)
	end
end

function SWEP:PrePrimaryAttack()
	local vm = self.Owner:GetViewModel()
	--vm:SendViewModelMatchingSequence(vm:LookupSequence("altfire"))
	
	local ply = self.Owner
	local blastPos = ply:GetEyeTrace().HitPos
	if SERVER then
		local edf = EffectData()
		local blastPos = ply:GetEyeTrace().HitPos
		self:VortBeam() -- network the beam to players
		ply:EmitSound(charge)
		vm:SendViewModelMatchingSequence(vm:LookupSequence("altfire"))
		timer.Simple(0.35,function()
			ply:StopSound(charge)
			ply:EmitSound(shoot)
			local blastPos = ply:GetEyeTrace().HitPos

			if ply:IsValid() then
				if ply:Team() == TEAM_VORT and ply:GetSkin() == 1 then
					util.BlastDamage(ply,ply,blastPos,148,40) --inflictor, attacker, damageOrigin, damageRadius, damage
				else
					util.BlastDamage(ply,ply,blastPos,128,30) --inflictor, attacker, damageOrigin, damageRadius, damage
				end
			end

			local edf = EffectData()
			edf:SetOrigin(blastPos)
			edf:SetNormal(VectorRand())
			edf:SetRadius(128)
			util.Effect("cball_explode", edf)
		end) 
		timer.Simple(0.85,function()
			vm:SendViewModelMatchingSequence(vm:LookupSequence("idle"))
		end)
		return
	end
	
	
end

if CLIENT then
	
	net.Receive("impulseHL2RPVortBeam",function()
		local ply = net.ReadEntity()
		local blastPos = net.ReadVector()
		local id = 4
		local mdl = ply
		local isVort = ply == LocalPlayer()
		local isTP = impulse.GetSetting("view_thirdperson")
		timer.Simple(0.35,function()
			if not LocalPlayer():Alive() then return end
			local id = 4
			local mdl = ply
			if isVort then
				if not isTP then
					id = 1
					mdl = ply:GetViewModel()
				end
			end
			local d = CreateParticleSystem(mdl,"vortigaunt_beam", PATTACH_POINT_FOLLOW,id,Vector(0,0,0))
    			if isVort then
				if not isTP then
					d:SetIsViewModelEffect(true)
				end
			end
    			d:AddControlPoint(1, Entity(0), 0, 0, blastPos)
		
		end)
	end)
end
SWEP.Attachments = {}