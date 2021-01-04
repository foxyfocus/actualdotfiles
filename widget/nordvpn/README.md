# NordVPN Widget

This widget changes its icon based on the connection status of your NordVPN connection.

 ![widget_screenshot](https://bitbucket.org/easlice/awesome-as-widgets/raw/7de3043a72e1de200ec39156be755f27262bfc95/screenshots/nordvpn-status.png)

## Features
- Clicking on the icon toggles the connection on and off.
- Mousing over it gives more detailed connection information.
- Icons are customizable.
- Icons are automatically recolored based on your themes fg_normal color.
- You can disable the mouse over notification and set where it should appear.

## Dependencies

Requires the NordVPN linux app be installed, and that you are logged in.

By default it uses Arc icons, though that can be changed.

## Customization

| Name | Default | Description |
|---|---|---|
| `display_notification` | `true` | Whether to display the mouseover. |
| `notification_position` | `top_right` | Where to place the mouseover window. |
| `connected_icon` | `/usr/share/icons/Arc/status/symbolic/network-vpn-symbolic.svg`| The path to the icon to use when connected. |
| `disconnected_icon` | `/usr/share/icons/Arc/status/symbolic/network-vpn-acquiring-symbolic.svg`| The path to the icon to use when disconnected. |

## Installation

First you need to have the NordVPN client installed. (This is an exercise left up to the reader.)

Then clone this repo under **~/.config/awesome/** and add the widget to your **rc.lua**:

```lua
local nordvpn_widget = require("awesome-as-widgets.nordvpn.status")
...
s.mytasklist, -- Middle widget
	{ -- Right widgets
    	layout = wibox.layout.fixed.horizontal,
		...
        -- default
        nordvpn_widget(),
        -- customized
        nordvpn_widget({
            notification_position = "top_left",
            connected_icon = "~/icons/vpn_connected.png",
            disconnected_icon = "~/icons/vpn_disconnected.png",
        }),
		...
```
