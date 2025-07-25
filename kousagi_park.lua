-- kousagi park unique warp for act 6

function OnLevelInit()	
	local m = gMarioStates[0]
    local level = gNetworkPlayers[0].currLevelNum
    local act = gNetworkPlayers[0].currActNum

    if level == LEVEL_WF and act == 6 then
		local secondSpawn = obj_get_first_with_behavior_id(id_bhvStaticObject)
		if secondSpawn ~= nil then
			m.pos.x = secondSpawn.oPosX
			m.pos.y = secondSpawn.oPosY
			m.pos.z = secondSpawn.oPosZ
			m.faceAngle.y = 0x4000
		end
    end
end

hook_event(HOOK_ON_LEVEL_INIT, OnLevelInit)