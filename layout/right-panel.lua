local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local wifi_widget = require('widget.wifi')
local bluetooth_widget = require('widget.bluetooth.bluetooth')
local battery_widget = require('widget.battery')
local volume_widget = require('widget.pulseaudio')
local clickable_container = require('widget.material.clickable-container')

local dpi = require('beautiful').xresources.apply_dpi

local icons = require('theme.icons')

local textclock = wibox.widget.textclock('<span font="Inter Medium bold 11">%m/%d/%Y %I:%M %p</span>')

local date_widget = wibox.container.margin(textclock, dpi(8), dpi(8), dpi(8), dpi(8))

local systray = wibox.widget.systray()
systray:set_horizontal(true)
systray:set_base_size(26)

local RightPanel = function(s, offset)
  local offsetx = 0
  if offset == true then
    offsetx = 128
    offsety = 4
  end
  local panel =
    wibox(
    {
      ontop = false,
      screen = s,
      height = dpi(32),
      width = 600,
      x = s.geometry.width - dpi(630),
      y = s.geometry.y  + offsety,
      stretch = false,
      bg = "00",
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
      {
        {
          battery_widget,
          left = 10, 
          right = 10,
          top = 5, 
          bottom = 5,
          widget = wibox.container.margin
        },
        bg = "#FF5C8F",
        shape = gears.shape.rectangle,
        shape_border_color = "#68A8E4",
        shape_border_width = 3,
        widget = wibox.container.background    
      },
      {
        { 
          volume_widget,
          left = 10,
          right = 12, 
          top = 5,
          bottom = 5,
          widget = wibox.container.margin
        },
        
          bg = "#2C78BF",
          shape = gears.shape.rectangle,
          shape_border_color = "#68A8E4",
          shape_border_width = 3,
          widget = wibox.container.background
      },

      {
        {
          wifi_widget,
          left = 10,
          right = 12, 
          top = 5,
          bottom = 5,
          widget = wibox.container.margin
        },
        bg = "#FED06E",
        shape = gears.shape.rectangle,
        shape_border_color = "#68A8E4",
        shape_border_width = 3,
        widget = wibox.container.background,
      },
      {
        {
          bluetooth_widget,
          left = 5,
          right = 10, 
          widget = wibox.container.margin
        },
        bg = "#FF8700",
        shape = gears.shape.rectangle,
        shape_border_color = "#68A8E4",
        shape_border_width = 3,
        widget = wibox.container.background,
      },
      {
        {
          date_widget,
          left = 1, 
          right = 1,
          top = 1,
          bottom = 1,
          widget = wibox.container.margin
        },
        bg = "#98BC37",
        shape = gears.shape.rectangle,
        shape_border_color = "#68A8E4",
        shape_border_width = 3,
        widget = wibox.container.background
      },
      spacing = 10,
      layout = wibox.layout.fixed.horizontal,
  }
  return panel
end

return RightPanel
