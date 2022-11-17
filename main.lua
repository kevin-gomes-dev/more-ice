-- This simply allows you to play 4 levels of the ice cave as opposed to one. To be
-- similar to Spelunky HD / Spelunky Classic
meta.name = '4 Ice Caves'
meta.version = '1.1'
meta.description =
    'Ice caves are now 4 levels.'
meta.author = 'plow'

-- Set up our locals
local level_count = 1

---Change the exit door to go to ice caves
---Should only be 1 door in ice caves...
local function set_ice_caves()
  local door = get_entities_by(ENT_TYPE.FLOOR_DOOR_EXIT,0,0)[1]
  set_door_target(door,5,level_count,THEME.ICE_CAVES)
end

---Resets our level count
local function reset_level_count()
  level_count = 1
end

---Main function to handle logic. If we are in ice caves and have not yet
---gone through 4 levels, increment amount we went through and set
---the next level to be ice caves again
local function main()
  if state.theme == THEME.ICE_CAVES then
    if level_count < 4 then
      level_count = level_count + 1
      set_ice_caves()
    else
      -- Duplicate reset since it happens on start, and we can't travel backwards
      -- But here just for easier testing, more self contained
      reset_level_count()
    end
  end
end

-- Our callbacks. Order important to have ON.START happen before ON.LEVEL
set_callback(reset_level_count, ON.START)
set_callback(main, ON.LEVEL)