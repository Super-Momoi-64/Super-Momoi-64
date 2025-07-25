-- Filenames

local customMusicFilenames = {

[LEVEL_CASTLE_GROUNDS] = "constant moderato.ogg",
[LEVEL_BOB] = "step by step.ogg",
[LEVEL_CCM] = "pixel time.ogg",
[LEVEL_WF] = "usagi flap.ogg",
[LEVEL_JRB] = "Luminous.ogg",
[LEVEL_SL] = "pixel time.ogg",
[LEVEL_LLL] = "pixel time.ogg",
[LEVEL_BOWSER_3] = "re-aoharu.ogg",

["SPECIAL_KoopaTheQuick"] = "starting pistol.ogg",
["SPECIAL_KingBobomb"] = "was it a cat i saw.ogg",
["SPECIAL_Wiggler"] = "starting pistol.ogg",
["SPECIAL_RidingShell"] = "starting pistol.ogg",
["SPECIAL_VanishCap"] = "starting pistol.ogg",
["SPECIAL_MetalCap"] = "starting pistol.ogg",
["SPECIAL_WingCap"] = "starting pistol.ogg",

}

-- Playing and Stopping Custom Music

local audio_streams = {}
local currentSong = nil
local currentLevel = nil

for level, filename in pairs(customMusicFilenames) do
    audio_streams[level] = audio_stream_load(filename)
end

function StopCustomMusic()
    if currentSong then
        audio_stream_stop(currentSong)
        currentSong = nil
        currentLevel = nil
    end
end

function PlayCustomMusic(level)
    if customMusicFilenames[level] then
        if currentSong ~= audio_streams[level] then
		    stop_background_music(get_current_background_music()) -- stop any mario 64 songs from playing (if any)
            StopCustomMusic() -- stop all custom music from playing (if any)
            local stream = audio_streams[level] 
            audio_stream_set_looping(stream, true)
            audio_stream_play(stream, true, 1) -- play custom song
            currentSong = stream
            currentLevel = level	
        end
    else -- if cant find a custom song for level, stop custom music as it's probably a default mario 64 song playing
        StopCustomMusic()
    end
end

--- Mario Update

local ridingShell = { active = false }
local vanishCapActive = { active = false }
local metalCapActive = { active = false }
local wingCapActive = { active = false }

---@param m MarioState
function OnMarioUpdate(m)
    if m.playerIndex ~= 0 then return end 
	MarioEventMusic(m, m.riddenObj ~= nil, ridingShell, "SPECIAL_RidingShell") 
	MarioEventMusic(m, m.flags & MARIO_VANISH_CAP ~= 0, vanishCapActive, "SPECIAL_VanishCap") 
	MarioEventMusic(m, m.flags & MARIO_METAL_CAP ~= 0, metalCapActive, "SPECIAL_MetalCap") 
	MarioEventMusic(m, m.flags & MARIO_WING_CAP ~= 0, wingCapActive, "SPECIAL_WingCap") 
end

function MarioEventMusic(m, isActive, eventStatus, newMusicID)
	if isActive and not eventStatus.active then
		PlayCustomMusic(newMusicID)
		eventStatus.active = true
	elseif not isActive and eventStatus.active then
		PlayCustomMusic(gNetworkPlayers[0].currLevelNum)
		eventStatus.active = false;
	end
end

--- Update

local raceStatus = { active = true }
local gozStatus = { active = true }
local binahStatus = { active = true }

function OnUpdate()
	if obj_get_first_with_behavior_id(id_bhvGrandStar) or obj_get_first_with_behavior_id(id_bhvEndPeach) 
	or obj_get_first_with_behavior_id(id_bhvActSelector) ~= nil then
        StopCustomMusic()
    end
	
	EventMusic(id_bhvKoopa, 1033, "SPECIAL_KoopaTheQuick", KOOPA_THE_QUICK_ACT_AFTER_RACE, 
	function(obj)
		return obj.parentObj.oKoopaRaceEndpointRaceStatus == 0
	end, raceStatus)
	EventMusic(id_bhvKingBobomb, 1046, "SPECIAL_KingBobomb", 8, nil, gozStatus)
	EventMusic(id_bhvWigglerHead, 1046, "SPECIAL_Wiggler", WIGGLER_ACT_SHRINK, nil, binahStatus)
end

function EventMusic(behaviorID, originalMusicID, newMusicID, actionCheck, extraCondition, npcStatus)
	local obj = find_object_with_behavior(get_behavior_from_id(behaviorID))
	if obj ~= nil then
		if get_current_background_music() == originalMusicID then
			PlayCustomMusic(newMusicID)
			npcStatus.active = true 
		elseif obj.oAction == actionCheck then
			if extraCondition == nil or extraCondition(obj) then
				if npcStatus.active then
					npcStatus.active = false
					PlayCustomMusic(gNetworkPlayers[0].currLevelNum)
				end
			end
		end
	end
end


--- Hooks

hook_event(HOOK_MARIO_UPDATE, OnMarioUpdate)
hook_event(HOOK_UPDATE, OnUpdate)
hook_event(HOOK_ON_LEVEL_INIT, function()
    PlayCustomMusic(gNetworkPlayers[0].currLevelNum)
end)

-- needed for california dance compatability
_G.StopCustomMusic = StopCustomMusic
_G.PlayCustomMusic = PlayCustomMusic
