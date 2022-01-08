local gears = require "gears"
local beautiful = require "beautiful"
local cairo = require("lgi").cairo

local theme = beautiful.get()

local wallpaper_surface = gears.surface.load(theme.wallpaper)
w, h = gears.surface.get_size(wallpaper_surface)

local rotated_surface = cairo.ImageSurface.create(cairo.Format.ARGB32, h, w)
local surface_ctx = cairo.Context(rotated_surface)

surface_ctx:translate(h, 0)
surface_ctx:rotate(math.rad(90))
surface_ctx:set_source_surface(wallpaper_surface, 0, 0)
surface_ctx:paint()

for s in screen do
  if s == screen.primary then
    gears.wallpaper.maximized(rotated_surface, s)
  else
    gears.wallpaper.maximized(theme.wallpaper, s)
  end
end
