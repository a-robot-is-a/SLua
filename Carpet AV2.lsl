av2 = NULL_KEY
pos = vector(-0.235, -0.4, 1.12)
rot = ZERO_ROTATION

function offset(avSizeZ)
   local offset = 1.066 + 0.1470173019125983 * (avSizeZ - 1.3907965421676636)
   return offset
end

function state_entry() end

function link_message(sender_num, num, str, id)
    av2 = id        
    ll.RequestPermissions(av2, PERMISSION_TRIGGER_ANIMATION)
end

function run_time_permissions(perm)
    if (perm) then
        local avSize = ll.GetAgentSize(av2)
        local helpPos = vector(pos.x, pos.y, offset(avSize.z))
        ll.SetLinkPrimitiveParamsFast(3,{PRIM_POS_LOCAL,helpPos, PRIM_ROT_LOCAL,rot})            
        ll.StopAnimation("sit")            
        ll.StartAnimation("sit_ground")
    end
end  

-- Simulate the state_entry event
state_entry()
