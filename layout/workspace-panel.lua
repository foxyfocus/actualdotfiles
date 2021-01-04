local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TagList = require('widget.tag-list')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')
local mat_icon_button = require('widget.material.icon-button')
local mat_icon = require('widget.material.icon')

local dpi = require('beautiful').xresources.apply_dpi

local icons = require('theme.icons')

local WorkspacePanel = function(s, offset)
  local offsetx = 0
  if offset == true then
    offsetx = dpi(55)
    offsety = dpi(4)
  end
  local panel =
    wibox(
    {
      ontop = false,
      screen = s,
      height = dpi(32),
      width = dpi(180),
      x = s.geometry.x + offsetx,
      y = s.geometry.y  + offsety,
      stretch = false,
      bg = beautiful.primary.hue_900,
      fg = beautiful.fg_normal,
      struts = {
        top = dpi(32)
      }
    }
  )

  panel:struts(
    {
      top = dpi(0)
    }
  )

  panel:setup {
      layout = wibox.layout.align.horizontal,
      expand = 'outside',
      {
        layout = wibox.layout.fixed.horizontal,
        TagList(s),
        --add_button
      },
      shape              = gears.shape.rectangle,
      bg                 = beautiful.bg_normal,
      shape_border_color = "#68A8E4",
      shape_border_width = 3,
      layout             = wibox.container.background 
  }


  return panel
end

return WorkspacePanel
