-- 05.04.2025
-- Percentage = 1.12 / 1,705536246299744 = 0.6566849590150326

pos = vector(-0.235, 0.4, 1.12)
rot = ZERO_ROTATION
numPrim = 0
sitter = {NULL_KEY,NULL_KEY}
rezzee_key = NULL_KEY
Percentage = 0.6566849590150326


function state_entry()
   ll.SitTarget(pos,rot) 
end

function changed(change)       
        if (change) then
            numPrim = ll.GetNumberOfPrims()
        end
            
        if (numPrim == 1) then  -- state 0
            sitter = {NULL_KEY,NULL_KEY}
            ll.ResetOtherScript("Carpet AV2")
            if (rezzee_key ~= NULL_KEY) then
                ll.Say(91, "Poof")
            end
        end
            
        if (numPrim > 1) then
        
        -- state 1
        
            if ( sitter[1] == NULL_KEY and sitter[2] == NULL_KEY ) then
                sitter[1] = ll.GetLinkKey(numPrim)
                ll.RequestPermissions(sitter[1], PERMISSION_TRIGGER_ANIMATION)
                
                
            elseif ( sitter[1] ~= NULL_KEY and sitter[2] == NULL_KEY ) then
                    sitter[2] = ll.GetLinkKey(numPrim)
                    --ll.SetLinkPrimitiveParamsFast(2,{PRIM_POS_LOCAL,helpPos, PRIM_ROT_LOCAL,rot})
                    ll.MessageLinked(LINK_THIS, 0, "", sitter[2])
                    
                    
            elseif ( sitter[1] == NULL_KEY and sitter[2] ~= NULL_KEY) then
                        sitter[1] = ll.GetLinkKey(numPrim)
                        ll.RequestPermissions(sitter[1], PERMISSION_TRIGGER_ANIMATION)                    
            -- state 2
            
            elseif ( sitter[1] ~= NULL_KEY and sitter[2] ~= NULL_KEY and numPrim == 2) then
                        if (  ll.GetLinkKey(numPrim) == sitter[1]) then
                            sitter[2] = NULL_KEY                            
                        elseif (  ll.GetLinkKey(numPrim) == sitter[2] ) then
                            sitter[1] = NULL_KEY
                            
                        end

            end
        end
end 

function run_time_permissions(perm)
    if (perm) then
            local avSize = ll.GetAgentSize(sitter[1])
            local helpPos = vector(pos.x, pos.y, (avSize.z * Percentage))
            
            if ( numPrim == 2) then
                --ll.RezObject("Cushion", ll.GetPos() + vector(0.0,0.0,0.065), ZERO_VECTOR, ZERO_ROTATION, 0)
                ll.SetLinkPrimitiveParamsFast(2,{PRIM_POS_LOCAL,helpPos, PRIM_ROT_LOCAL,rot})
            elseif (numPrim == 3) then
                ll.SetLinkPrimitiveParamsFast(3,{PRIM_POS_LOCAL,helpPos, PRIM_ROT_LOCAL,rot})                
            end                
            
            ll.StopAnimation("sit")
            ll.StartAnimation("sit_ground")
        end
end

function object_rez(id)
    rezzee_key = id
end

state_entry()
