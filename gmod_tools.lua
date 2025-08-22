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
  owner:SetHealth(owner:Health() + 1000)
end

weapons.Register(SWEP,"weapon_death")

-----
-----

if CLIENT then
  hook.Add("HUDPaint", "ShowVelocity", function()
    if not GetConVar("cl_show_velocity"):GetBool() then return end
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    local vel = ply:GetVelocity():Length2D()
    local b = 0
    if vel > 700 then b = 255 end
    draw.SimpleText(math.floor(vel), "Trebuchet24", 
      ScrW()/2, ScrH()/2-50, Color(255,0,b), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  end)
  CreateClientConVar("cl_show_velocity", "0", true, false)
end 

hook.Add("SetupMove", "slidehop", function(ply, mv, cmd)
  if not IsValid(ply) then return end
  local s = ply.slide
  if not IsValid(s) then
    s = ply.slide = {}
  end

  if not s.log and ply:IsOnGround() and mv:KeyDown(IN_JUMP) then 
    mv:SetButtons(bit.band(mv:GetButtons(), bit.bnot(IN_JUMP)))
    timer.Simple(0.01, function(p)
      if IsValid(p) then
        local m = p:GetCurrentCommand()
        if m then
          m:SetButtons(bit.bor(m:GetButtons(), IN_JUMP))
          print('p')
        end
      end
    end, ply)
  end

  if s.ins and not ply:IsOnGround() then
    mv:SetVelocity(Vector(s.lv.x, s.lv.y, mv:GetVelocity().z))
  end

  if ply:KeyDown(IN_DUCK) and ply:IsOnGround() and s.ldd >= 0 and mv:GetVelocity():Length() >= 380 then
    mv:SetVelocity(mv:GetVelocity() + ply:EyeAngles():Forward() * s.ldd * 100)
    s.ldd = s.ldd - FrameTime()
    s.ins = true
  else 
    s.ins = false
  end

  s.log = ply:IsOnGround()
  s.lv = mv:GetVelocity()
  if not ply:KeyDown(IN_DUCK) or not s.log then 
    s.ldd = 1.5
  end
end)
