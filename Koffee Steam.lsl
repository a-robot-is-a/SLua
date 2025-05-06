-- Choose a pattern from the following:
-- PSYS_SRC_PATTERN_EXPLODE
-- PSYS_SRC_PATTERN_DROP
-- PSYS_SRC_PATTERN_ANGLE_CONE_EMPTY
-- PSYS_SRC_PATTERN_ANGLE_CONE
-- PSYS_SRC_PATTERN_ANGLE
pattern = PSYS_SRC_PATTERN_ANGLE_CONE

-- Mask Flags - set to TRUE to enable
glow = false            -- Make the particles glow
bounce = false          -- Make particles bounce on Z plan of object
interpColor = true     -- Go from start to end color
interpSize = true       -- Go from start to end size
wind = true             -- Particles effected by wind
followSource = false    -- Particles follow the source
followVel = false       -- Particles turn to velocity direction

--[[ Select a target for particles to go towards
 "" for no target, "owner" will follow object owner 
    and "self" will target this object
    or put the key of an object for particles to go to ]]
target = NULL_KEY

-- Particle paramaters
texture = ""                            -- Texture used for particles, default used if blank
startAlpha = 0.25                       -- Start alpha (transparency) value
endAlpha = 0.95                         -- End alpha (transparency) value
startColor = vector( 1.0, 1.0, 1.0 )    -- Start color of particles <R,G,B>
endColor = vector( 0.8, 0.8, 0.8 )      -- End color of particles <R,G,B> (if interpColor == TRUE)
startSize = vector( 0.2,0.2,0.2 )       -- Start size of particles 
endSize = vector( 0.74,0.74,0.74 )      -- End size of particles (if interpSize == TRUE)

-- System paramaters
age = 2.0                       -- Life of each particle
rate = 0.05                     -- How fast (rate) to emit particles
radius = 0.0002                 -- Radius to emit particles for BURST pattern
angleBegin = 0.18                -- Inner angle for all ANGLE patterns
angleEnd = 0.5                  -- Outer angle for all ANGLE patterns
minSpeed = 0.05                 -- Min speed each particle is spit out at
maxSpeed = 0.2                  -- Max speed each particle is spit out at
push = vector(0.0,0.0,0.2)      -- Force wind pushed on particles
count = 2                       -- How many particles to emit per BURST
omega = vector(0.0,0.0,0.3)     -- Rotation of ANGLE patterns around the source
life = 0.0                      -- Life in seconds for the system to make particles

-- Script variables
    flags = bit32.bor( 
                  glow and PSYS_PART_EMISSIVE_MASK or 0,
                  bounce and PSYS_PART_BOUNCE_MASK or 0,
                  interpColor and PSYS_PART_INTERP_COLOR_MASK or 0,
                  interpSize and PSYS_PART_INTERP_SCALE_MASK or 0,
                  wind and PSYS_PART_WIND_MASK or 0,
                  followSource and PSYS_PART_FOLLOW_SRC_MASK or 0,
                  followVel and PSYS_PART_FOLLOW_VELOCITY_MASK or 0,
                  target ~= "" and PSYS_PART_TARGET_POS_MASK or 0)

flags = 0

myTable = {
    PSYS_SRC_PATTERN, pattern,
    PSYS_SRC_ANGLE_BEGIN, angleBegin,
    PSYS_SRC_ANGLE_END, angleEnd,
    PSYS_SRC_BURST_RADIUS,radius,
    PSYS_SRC_BURST_SPEED_MIN,minSpeed,
    PSYS_SRC_BURST_SPEED_MAX,maxSpeed,
    PSYS_SRC_ACCEL,push,
    PSYS_PART_MAX_AGE,age,
    PSYS_PART_FLAGS,flags,
    PSYS_PART_START_COLOR, startColor,
    PSYS_PART_END_COLOR, endColor,
    PSYS_PART_START_SCALE,startSize,
    PSYS_PART_END_SCALE,endSize, 
    PSYS_SRC_BURST_RATE,rate,
    PSYS_SRC_BURST_PART_COUNT,count,
    PSYS_SRC_TARGET_KEY,target,
    PSYS_SRC_OMEGA, omega,
    PSYS_SRC_MAX_AGE, life,
    PSYS_SRC_TEXTURE, texture,
    PSYS_PART_START_ALPHA, startAlpha,
    PSYS_PART_END_ALPHA, endAlpha
}

function state_entry()
        ll.ParticleSystem(myTable)
end

state_entry()
