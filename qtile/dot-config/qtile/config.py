from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal



mod = "mod4"
terminal = guess_terminal()
keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    Key([mod], "h", lazy.layout.swap_left(), desc="Swap the window to be on top of the stack."),
    Key([mod], "j", lazy.layout.down(), desc="Focus down."),
    Key([mod], "k", lazy.layout.up(), desc="Focus up."),
    Key([mod], "l", lazy.layout.shuffle_down(), desc="Shuffle the window down."),
    Key([mod], "n", lazy.layout.reset(), desc="Reset all window sizes"),
    Key([mod], "w", lazy.layout.left(), desc="Focus the top of the stack."),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "o", lazy.layout.maximize(), desc="Toggle between min and max."),
    Key([mod], "f", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "Return", lazy.spawn("alacritty"), desc="Launch terminal"),
    Key([mod, "shift"], "h", lazy.layout.shrink_main(), desc="Grow window to the left"),
    Key([mod, "shift"], "l", lazy.layout.grow_main(), desc="Grow window to the right"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),

    # Multimedia Keys
    Key([], "XF86AudioLowerVolume", lazy.spawn('pactl set-sink-volume $(pactl get-default-sink) -5%',shell=True)),
    Key([], "XF86AudioRaiseVolume", lazy.spawn('pactl set-sink-volume $(pactl get-default-sink) +5%',shell=True)),
    Key([], "XF86AudioMute", lazy.spawn('pactl set-sink-mute $(pactl get-default-sink) toggle',shell=True)),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([mod], "XF86AudioLowerVolume", lazy.spawn("pacmd set-default-sink 1")),
    Key([mod], "XF86AudioRaiseVolume", lazy.spawn("pacmd set-default-sink 2")),
]

def giveMonad(splitratio, automax = True):
    return layout.MonadTall(
        align = 0,
        auto_maximize = automax,
        border_focus = '#ff9e64',
        border_normal = '#3d59a1',
        border_width = 4,
        ratio = splitratio,
        new_client_position = "bottom",
        min_secondary_size = 130,
        )


regularMonad = layout.MonadTall(
        align = 0,
        auto_maximize = True,
        border_focus = '#ff9e64',
        border_normal = '#3d59a1',
        border_width = 4,
        ratio = 2/3,
        new_client_position = "bottom",
        min_secondary_size = 130,
        )

texMonad = layout.MonadTall(
        align = 0,
        auto_maximize = True,
        border_focus = '#ff9e64',
        border_normal = '#3d59a1',
        border_width = 4,
        ratio = 0.708,
        new_client_position = "bottom",
        min_secondary_size = 100,
        )

# Default Fallback Monad Layout
layouts = [
        regularMonad
]


# Initialize all "desktops"
# groups = [Group(i) for i in ['TeX','Res','Ink','Code','Sys','Misc']]
groups = [
        Group(
            "Sys",
            layouts = [giveMonad(0.5)],
            ),
        Group(
            "Code",
            layouts = [giveMonad(0.66)],
            ),
        # Workspace for TeX
        Group(
            "TeX",
            layouts = [giveMonad(0.708)],
            ),
        # Workspace for translation, synonyms and lookup
        Group(
            "Syn",
            layouts = [giveMonad(0.708)],
            ),
        # Research workspace
        Group(
            "Res",
            layouts = [giveMonad(0.5)]
            ),
        # Media Workspace for Inkscape Workflow
        Group(
            "Ink",
            layouts = [giveMonad(2/3, automax=False)],
            ),
        Group(
            "Med",
            layouts = [giveMonad(0.5)]
            ),
        ]




for index, i in enumerate(groups):
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                str(index+1),
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                str(index+1),
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            )])



widget_defaults = dict(
    font="JetBrains Mono Bold",
    fontsize=13,
    padding=2,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(
                    fontsize=14,
                    block_highlight_text_color="ff007c",
                    center_aligned=True,
                    disable_drag=True,
                    highlight_color='292e42',
                    highlight_method='line',
                    this_current_screen_border='ff007c',
                    this_screen_border='ff007c',
                    use_mouse_wheel=False,
                    visible_groups=['Sys'],
                    ),
                widget.GroupBox(
                    fontsize=14,
                    block_highlight_text_color="ff9e64",
                    center_aligned=True,
                    disable_drag=True,
                    highlight_color='292e42',
                    highlight_method='line',
                    this_current_screen_border='ff9e64',
                    this_screen_border='ff9e64',
                    use_mouse_wheel=False,
                    visible_groups=[group.name for group in groups[1:]],
                    ),
                widget.Prompt(
                    cursor=True,
                    cursorblink=0,
                    fmt='<span text_transform="uppercase" rise="7pt">{}</span>',
                    cursor_color='#292e42',
                    ),
                widget.Spacer(length=bar.STRETCH),
                widget.CurrentLayout(fmt='<span text_transform="uppercase" rise="7pt">{}</span>'),
                widget.Spacer(length=bar.STRETCH),
                widget.Clock(
                    format="%A KW-%W %d.%m.%Y %H:%M:%S",
                    fmt='<span rise="7pt">{}</span>'
                    ),
                widget.Spacer(length=5),
                widget.NetUP(
                        host="google.com",
                        display_fmt='{0}',
                        down_string='󰅛',
                        down_foreground='FF0000',
                        up_foreground='00FF00',
                        up_string='󰱓'
                    ),
                widget.Spacer(length=10),
            ],
            # Size/thickness of the bar
            24,
            background = "#292e42",
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
