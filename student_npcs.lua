

E_MODEL_MOMOI = smlua_model_util_get_id("momoi_npc_geo")

local function SetStudentIdleAnimation()
    local student = find_object_with_behavior(get_behavior_from_id(id_bhvMessagePanel))
    while student ~= nil do
        smlua_anim_util_set_animation(student, "sumire_idle")
        student = obj_get_next_with_same_behavior_id(student)
    end
end
hook_event(HOOK_ON_LEVEL_INIT, SetStudentIdleAnimation)
hook_event(HOOK_ON_WARP, SetStudentIdleAnimation)



