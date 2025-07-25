-- name: Super Momoi 64
-- incompatible: romhack
-- description: A small romhack made for /bag/

gLevelValues.entryLevel = LEVEL_CASTLE_GROUNDS
gLevelValues.exitCastleLevel = LEVEL_CASTLE_GROUNDS
gLevelValues.exitCastleWarpNode = 0x0A
gLevelValues.fixCollisionBugs = true

gBehaviorValues.trajectories.KoopaBobTrajectory = get_trajectory('momoi_the_quick')
vec3f_set(gLevelValues.starPositions.KoopaBobStarPos, 11400.0, 5820.0, -3700.0)

gBehaviorValues.KoopaBobAgility = 6.0
gBehaviorValues.KoopaCatchupAgility = 6.0
gBehaviorValues.dialogs.KoopaQuickBobStartDialog = DIALOG_042
gBehaviorValues.dialogs.KoopaQuickBobWinDialog = DIALOG_043
gBehaviorValues.dialogs.KoopaQuickLostDialog = DIALOG_044

--smlua_audio_utils_replace_sequence(0x00, 42, 75, "test") -- SEQ_LEVEL_GRASS