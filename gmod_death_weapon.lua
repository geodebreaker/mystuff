if SERVER then
--    AddCSLuaFile()
end

local SWEP = {}
SWEP.Base = "weapon_base"
SWEP.PrintName = "death"

SWEP.Primary = {}
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true

SWEP.Secondary = {}
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

function SWEP:Initialize()
    self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
    if not IsFirstTimePredicted() then return end
    self:SetNextPrimaryFire(CurTime() + 0.01)
    if SERVER then
        local owner = self:GetOwner()
        if not IsValid(owner) then return end
        local b = {}
        b.Num = 1
        b.Src = owner:GetShootPos()
        b.Dir = owner:GetAimVector()
        b.Spread = Vector(0,0,0)
        b.Tracer = 1
        b.Force = 5
        b.Damage = 100000
        owner:FireBullets(b)
    end
    self:EmitSound("Weapon_Pistol.Single")
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:GetOwner():MuzzleFlash()
    self:GetOwner():SetAnimation(PLAYER_ATTACK1)
end

function SWEP:SecondaryAttack()
    if not IsFirstTimePredicted() then return end
    self:SetNextPrimaryFire(CurTime() + 0.01)
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
    local tr = owner:GetEyeTrace()
    if SERVER then
        local e = ents.Create("env_explosion")
        if not IsValid(e) then return end
        e:SetPos(tr.HitPos)
        e:SetOwner(owner)
        e:Spawn()
        e:SetKeyValue("iMagnitude", "300")
        e:Fire("Explode", 0, 0)
    end
end

function SWEP:Reload()
  if not IsFirstTimePredicted() then return end
  local owner = self:GetOwner()
  if not IsValid(owner) then return end
  owner:SetHealth(2147483647)
end

weapons.Register(SWEP,"weapon_death")
