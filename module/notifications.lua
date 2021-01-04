local awful = require('awful')
local naughty = require('naughty')
local beautiful = require('beautiful')
local ruled = require('ruled')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi

-- Naughty presets

ruled.notification.connect_signal("request::rules", function()
  -- All notifications will match this rule.
  ruled.notification.append_rule {
      rule       = { },
      properties = {
          screen           = awful.screen.preferred,
          implicit_timeout = 5,
      }
  }
  -- Add a red background for urgent notifications.
  ruled.notification.append_rule {
      rule       = { urgency = "critical" },
      properties = { fg = "#FF0000", timeout = 0 }
  }

  ruled.notification.append_rule {
      rule       = { urgency = "normal" },
      properties = { 
          fg = beautiful.notification_fg,
          border_width = beautiful.notification_border_width,
      }
  }
end)

-- TODO how do I make this work to skip songs for spotify
--naughty.connect_signal("property::selected", function(n)
--    naughty.notification { title = "DEBUG", message = " " .. n}
--end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box { notification = n }
end)

naughty.connect_signal("request::action_icon", function(a, context, hints)
  -- use the XDG icon
   a.icon = menubar.utils.lookup_icon(hints.id)
end)

naughty.connect_signal("request::icon", function(n, context, hints)
  if context ~= "app_icon" then return end

  local path = menubar.utils.lookup_icon(hints.app_icon) or
      -- use the XDG icon
      menubar.utils.lookup_icon(hints.app_icon:lower())

  if path then
      n.icon = path
  end
end)