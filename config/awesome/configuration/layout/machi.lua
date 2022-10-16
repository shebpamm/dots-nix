local machi = require "../../modules/layout-machi"
local awful = require "awful"
local gears = require "gears"

local placement = awful.placement

priorities = {
  {
    class = "Spotify",
    placement = {
      horizontal = "right",
      vertical = "top",
    },
  },

  {
    class = "discord",
    placement = {
      horizontal = "right",
      vertical = "bottom",
    },
  },

  {
    class = "Google-chrome",
    placement = {
      horizontal = "left",
    },
  },
}

function empty_with_priority(c, instance, areas, geometry)
  local area_client_count = {}
  for _, oc in ipairs(c.screen.tiled_clients) do
    local cd = instance.client_data[oc]
    if cd and cd.placement and cd.area then
      area_client_count[cd.area] = (area_client_count[cd.area] or 0) + 1
    end
  end
  local choice_client_count = nil
  local choice_spare_score = nil
  local choice = nil
  for i = 1, #areas do
    local a = areas[i]
    if a.habitable then
      -- +1 for the new client
      local client_count = (area_client_count[i] or 0) + 1

      local parent = areas[a.parent_id]

      local placement_score = 0
      local size_score = (a.width * a.height) / (parent.width * parent.height)

      for j = 1, #priorities do
        local rule = priorities[j]
        if c.class == rule.class then

          if rule.placement then
            if rule.placement.horizontal == "right" then
              placement_score = placement_score + a.x + a.width
            elseif rule.placement.horizontal == "left" then
              placement_score = placement_score + -a.x
            end
            if rule.placement.vertical == "bottom" then
              placement_score = placement_score + a.y
            elseif rule.placement.vertical == "top" then
              placement_score = placement_score - a.y
            end
          end

          if rule.size then
            if rule.size == "min" then
              size_score = math.abs(size_score) * -1
            elseif rule.size == "disable" then
              size_score = 0
            end
          end
        end
      end

      local spare_score = (size_score + placement_score) / client_count

      if choice == nil or (choice_client_count > 1 and client_count == 1) then
        choice_client_count = client_count
        choice_spare_score = spare_score
        choice = i
      elseif (choice_client_count > 1) == (client_count > 1) and choice_spare_score < spare_score then
        choice_client_count = client_count
        choice_spare_score = spare_score
        choice = i
      end
    end
  end
  instance.client_data[c].lu = nil
  instance.client_data[c].rd = nil
  instance.client_data[c].area = choice
  geometry.x = areas[choice].x
  geometry.y = areas[choice].y
  geometry.width = areas[choice].width
  geometry.height = areas[choice].height
end

return {
  machi = machi,
  primary = machi.layout.create { name = "primary_machi" },
  secondary = machi.layout.create { name = "secondary_machi", new_placement_cb = empty_with_priority },
}
