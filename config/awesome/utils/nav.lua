local awful = require "awful"

module = {}

local function get_tag_clients()
  local clients = {}
  local current_screen = awful.screen.focused()
  local current_tag = current_screen.selected_tag
  for _, c in ipairs(client.get()) do
    if c.screen == current_screen and c.first_tag == current_tag and c.floating == false then
      table.insert(clients, c)
    end
  end
  return clients
end

local function get_left_client()
  local clients = get_tag_clients()
  local left_client = nil
  local left_client_x = awful.screen.focused().geometry.width
  for _, c in ipairs(clients) do
    if c.x < left_client_x then
      left_client = c
      left_client_x = c.x
    end
  end

  return left_client
end

local function get_right_client()
  local clients = get_tag_clients()
  local right_client = nil
  local right_client_x = 0
  for _, c in ipairs(clients) do
    if c.x > right_client_x then
      right_client = c
      right_client_x = c.x
    end
  end

  return right_client
end

local function get_center_client()
  local clients = get_tag_clients()
  local center_point = awful.screen.focused().geometry.width / 2
  local center_client = nil
  local center_client_x = 0
  for _, c in ipairs(clients) do
    local midpoint = (c.x + c.width) / 2
    local distance = math.abs(midpoint - center_point)
    local previous_distance = math.abs(center_client_x - center_point)
    if distance < previous_distance then
      center_client = c
      center_client_x = midpoint
    end

    if distance == previous_distance and center_client == client.focus then
      center_client = c
      center_client_x = midpoint
    end
  end

  return center_client
end

local get_direction_client = function(direction)
  if direction == "left" then
    return get_left_client()
  elseif direction == "center" then
    return get_center_client()
  elseif direction == "right" then
    return get_right_client()
  end
end

function module.focus_direction(direction)
  local client = get_direction_client(direction)
  if client then
    client:emit_signal("request::activate", "nav.focus_direction", { raise = true })
  end
end

return module
