local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')
local terminal = "alacritty"
local hotkeys_popup = require('awful.hotkeys_popup').widget

require('module.brightness-osd')
local modkey = "Mod4"
local altKey = "Mod1"


function poweroff_command()
  awful.spawn.with_shell('poweroff')
  awful.keygrabber.stop(exit_screen_grabber)
end

-- Tag related keybindings
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key(
        {altKey},
        'space',
        function()
          screen.primary.left_panel:toggle(true)
        end,
        {description = 'show main menu', group = 'awesome'}
      ),
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
})


-- Client related keybindings
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),
        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, "Control" }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "client"}),
        awful.key({ modkey, "Shift"   }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "client"}),
    })
end)

-- Miscellaneous related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),    
})



-- Media/Power related keybindings
awful.keyboard.append_global_keybindings({
awful.key(
    {},
    'XF86MonBrightnessUp',
    function()
        awful.spawn('brightnessctl +10%', false)
        awesome.emit_signal('widget::brightness')
        awesome.emit_signal('module::brightness_osd:show', true)
    end,
    {description = 'increase brightness by 10%', group = 'hotkeys'}
),
awful.key(
    {},
    'XF86MonBrightnessDown',
    function()
        awful.spawn('brightnessctl 10%-', false)
        awesome.emit_signal('widget::brightness')
        awesome.emit_signal('module::bjrightness_osd:show', true)
    end,
    {description = 'decrease brightness by 10%', group = 'hotkeys'}
),
awful.key(
    {},
    'XF86AudioRaiseVolume',
    function()
        awful.spawn('amixer -D pulse sset Master 5%+', false)
        awesome.emit_signal('widget::volume')
        awesome.emit_signal('module::volume_osd:show', true)
    end,
    {description = 'increase volume up by 5%', group = 'hotkeys'}
),
awful.key(
    {},
    'XF86AudioMute',
    function()
        awful.spawn('amixer -D pulse set Master 1+ toggle', false)
    end,
    {description = 'toggle mute', group = 'hotkeys'}
),
awful.key(
    {},
    'XF86AudioNext',
    function()
        awful.spawn('mpc next', false)
    end,
    {description = 'next music', group = 'hotkeys'}
),
awful.key(
    {},
    'XF86AudioPrev',
    function()
        awful.spawn('mpc prev', false)
    end,
    {description = 'previous music', group = 'hotkeys'}
),
awful.key(
    {},
    'XF86AudioPlay',
    function()
        awful.spawn('mpc toggle', false)
    end,
    {description = 'play/pause music', group = 'hotkeys'}

),
awful.key(
    {},
    'XF86AudioMicMute',
    function()
        awful.spawn('amixer set Capture toggle', false)
    end,
    {description = 'mute microphone', group = 'hotkeys'}
),
awful.key(
    {},
    'XF86PowerDown',
    function()
      --
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  ),
awful.key(
    {},
    'XF86PowerOff',
    function()
        exit_screen_show()
        naughty.notify({text="your text" , replaces_id=1 } )        

    end,
    {description = 'end session menu', group = 'hotkeys'}
),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),

    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
              
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
})
