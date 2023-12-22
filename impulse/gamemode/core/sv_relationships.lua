impulse.Relationships = impulse.Relationships or {}
impulse.Relationships.Players = impulse.Relationships.Players or {}
impulse.Relationships.NPCS = impulse.Relationships.NPCS or {}

local function StoreDefaultRelationship(npc)
	if player.GetCount() == 0 then
		return
	end

	npc.DefaultRelationship = npc:Disposition(player.GetAll()[1]) or 1
end

function impulse.Relationships.Find(ply, npcclass)
	local t = ply:Team()
	local tData = impulse.Teams.Data[t]

	if tData and tData.Relationships and tData.Relationships[npcclass] then
		return tData.Relationships[npcclass]
	end

	return impulse.Relationships.Defaults[npcclass] or D_NU
end

function impulse.Relationships.SyncNPC(npc)
	if player.GetCount() > 1 then
		for k,v in pairs(impulse.Relationships.Players) do
			if IsValid(v) then
				npc:AddEntityRelationship(v, D_HT, 99)
			else
				impulse.Relationships.Players[k] = nil
			end
		end
	end

	table.insert(impulse.Relationships.NPCS, npc)
end

function impulse.Relationships.SyncPlayer()

end