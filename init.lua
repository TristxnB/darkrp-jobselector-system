AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_jobspanel.lua")
include("shared.lua")
util.AddNetworkString("postapo_jobs_open")


function ENT:Initialize()

	self:SetModel("models/props/cs_office/computer.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE )
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end

end

function ENT:Use(ply)
	if SERVER then
        net.Start("postapo_jobs_open")
        net.Send(ply)
    end

end