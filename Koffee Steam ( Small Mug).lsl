
-- Mask Flags - set to TRUE to enable
glow = FALSE            -- Make the particles glow
bounce = FALSE          -- Make particles bounce on Z plan of object
interpColor = TRUE      -- Go from start to end color
interpSize = TRUE       -- Go from start to end size
wind = TRUE             -- Particles effected by wind
followSource = FALSE    -- Particles follow the source
followVel = FALSE       -- Particles turn to velocity direction

-- Choose a pattern from the following:
-- PSYS_SRC_PATTERN_EXPLODE
-- PSYS_SRC_PATTERN_DROP
-- PSYS_SRC_PATTERN_ANGLE_CONE_EMPTY
-- PSYS_SRC_PATTERN_ANGLE_CONE
-- PSYS_SRC_PATTERN_ANGLE
pattern = PSYS_SRC_PATTERN_EXPLODE

--[[ Select a target for particles to go towards
 "" for no target, "owner" will follow object owner 
    and "self" will target this object
    or put the key of an object for particles to go to ]]
target = NULL_KEY

-- Particle paramaters
age = 2.9                             -- Life of each particle
minSpeed = 0.0001                         -- Min speed each particle is spit out at
maxSpeed = 0.00014                         -- Max speed each particle is spit out at
texture = ""                            -- Texture used for particles, default used if blank
startAlpha = 0.8                        -- Start alpha (transparency) value
endAlpha = 0.3                         -- End alpha (transparency) value
startColor = vector(0.75, 0.70, 0.65)      -- Start color of particles <R,G,B>
endColor = vector(0.8, 0.8, 0.8)        -- End color of particles <R,G,B> (if interpColor == TRUE)
startSize = vector(0.15,0.15,0.15)         -- Start size of particles 
endSize = vector(0.8,0.8,0.8)           -- End size of particles (if interpSize == TRUE)
push =  vector(0.0,0.0,0.025)            -- Force wind pushed on particles

-- System paramaters
rate = 0.10                     -- How fast (rate) to emit particles
radius = 0.03                   -- Radius to emit particles for BURST pattern
count = 5                       -- How many particles to emit per BURST 
outerAngle = 0                  -- Outer angle for all ANGLE patterns
innerAngle = 1.55               -- Inner angle for all ANGLE patterns
omega =  vector(0.0,0.0,0.0)    -- Rotation of ANGLE patterns around the source
life = 0.0                      -- Life in seconds for the system to make particles

-- Script variables
flags = 0

myTable = 
{PSYS_PART_MAX_AGE,age,
    PSYS_PART_FLAGS,flags,
    PSYS_PART_START_COLOR, startColor,
    PSYS_PART_END_COLOR, endColor,
    PSYS_PART_START_SCALE,startSize,
    PSYS_PART_END_SCALE,endSize, 
    PSYS_SRC_PATTERN, pattern,
    PSYS_SRC_BURST_RATE,rate,
    PSYS_SRC_ACCEL, push,
    PSYS_SRC_BURST_PART_COUNT,count,
    PSYS_SRC_BURST_RADIUS,radius,
    PSYS_SRC_BURST_SPEED_MIN,minSpeed,
    PSYS_SRC_BURST_SPEED_MAX,maxSpeed,
    PSYS_SRC_TARGET_KEY,target,
    PSYS_SRC_INNERANGLE,innerAngle, 
    PSYS_SRC_OUTERANGLE,outerAngle,
    PSYS_SRC_OMEGA, omega,
    PSYS_SRC_MAX_AGE, life,
    PSYS_SRC_TEXTURE, texture,
    PSYS_PART_START_ALPHA, startAlpha,
    PSYS_PART_END_ALPHA, endAlpha}


function updateParticles()
    flags = 0;
    if (target == "owner") then target = ll.GetOwner() end
    if (target == "self") then target = ll.GetKey() end
    
    flags = bit32.bor(flags, glow and PSYS_PART_EMISSIVE_MASK or 0,
                            bounce and PSYS_PART_BOUNCE_MASK or 0,
                            interpColor and PSYS_PART_INTERP_COLOR_MASK or 0,
                            interpSize and PSYS_PART_INTERP_SCALE_MASK or 0,
                            wind and PSYS_PART_WIND_MASK or 0,
                            followSource and PSYS_PART_FOLLOW_SRC_MASK or 0,
                            followVel and PSYS_PART_FOLLOW_VELOCITY_MASK or 0, 
                            target ~= "" and PSYS_PART_TARGET_POS_MASK or 0)

    ll.ParticleSystem(myTable)
end

function state_entry()
        updateParticles()
end

state_entry()