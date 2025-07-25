

--overides default bowser 3 warps to prevent accidentally entering vanilla bits or upper floor castle
function YuukaStageExit()
    if gNetworkPlayers[0].currLevelNum == LEVEL_BOWSER_3 then
        warp_to_level(LEVEL_CASTLE_GROUNDS, 0x05, ACT_UNINITIALIZED)
    end
end

function spawnEnemies()	
    if gNetworkPlayers[0].currLevelNum == LEVEL_BOWSER_3 then
        local yuukaReference = obj_get_first_with_behavior_id(id_bhvBowser)
        if yuukaReference ~= nil then
            local yuukaModel = smlua_model_util_get_id("yuuka_geo")
			
            spawn_sync_object(id_bhvThwomp, E_MODEL_THWOMP, yuukaReference.oPosX - 1000, yuukaReference.oPosY, yuukaReference.oPosZ - 1000, nil)
            spawn_sync_object(id_bhvThwomp, E_MODEL_THWOMP, yuukaReference.oPosX + 1000, yuukaReference.oPosY, yuukaReference.oPosZ - 1000, nil)
            spawn_sync_object(id_bhvThwomp, E_MODEL_THWOMP, yuukaReference.oPosX + 1000, yuukaReference.oPosY, yuukaReference.oPosZ + 1000, nil)
            spawn_sync_object(id_bhvThwomp, E_MODEL_THWOMP, yuukaReference.oPosX - 1000, yuukaReference.oPosY, yuukaReference.oPosZ + 1000, nil)
	
        end
    end
end

hook_event(HOOK_ON_DIALOG, spawnEnemies)

hook_event(HOOK_ON_PAUSE_EXIT, YuukaStageExit)

