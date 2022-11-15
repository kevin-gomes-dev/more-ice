-- This simply allows you to play 4 levels of the ice cave as opposed to one. To be
-- similar to Spelunky HD / Spelunky Classic
meta.name = '4 Ice Caves'
meta.version = '1.0'
meta.description =
    'Ice caves are now 4 levels. Allows for smaller levels to compensate'
meta.author = 'plow'

local level_count = 1
local frozen_ice_level_count = true

---Change state's level and next level info to be ice caves
local function set_ice_caves()
  state.level_next = level_count
  state.world_next = 5
  state.theme_next = THEME.ICE_CAVES
end

---Change state's next level info to be ice caves
local function set_neo()
  state.level_next = 1
  state.world_next = 6
  state.theme_next = THEME.NEO_BABYLON
end

---Unfreeze the ice level count
local function maybe_unfreeze_level_count()
  if state.theme == THEME.ICE_CAVES then
    frozen_ice_level_count = false
  end
end

---Freeze the ice level count. Note if this stays frozen,
---we forever repeat the same ice level
local function freeze_level_count()
  frozen_ice_level_count = true
end

---Resets our level count
local function reset_level_count()
  level_count = 1
end

---Main function to handle logic. If we are in ice caves and have not yet
---gone through 4 levels, increment amount we went through and set
---the next level to be ice caves again
local function main()
  if not frozen_ice_level_count
      and state.theme == THEME.ICE_CAVES then
    if level_count < 4 then
      level_count = level_count + 1
      set_ice_caves()
    else
      -- Duplicate reset since it happens on start, and we can't travel backwards
      -- But here just for easier testing and in case a mod allows going backwards
      reset_level_count()
      set_neo()
    end

    freeze_level_count()
  end
end

-- On transition, if we haven't gone through 4 levels, reset state.level
set_callback(main, ON.LOADING)
set_callback(maybe_unfreeze_level_count, ON.LEVEL)
set_callback(reset_level_count, ON.START)
