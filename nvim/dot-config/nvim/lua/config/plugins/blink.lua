return {
    'saghen/blink.cmp',

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.3.0' },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- Use the nvim style comp interaction keymaps
        keymap = {
            preset = 'default',
            -- Unbind these to avoid conflict with
            -- the config in LuaSnip super-tab
            ['<Tab>'] = {},
            ['<S-Tab>'] = {},
        },
        appearance = {
            nerd_font_variant = 'mono'
        },
        -- Dont show docs automatically
        completion = {
            documentation = {
                auto_show = true,
            },
            list = {
                selection = {
                    -- When `true`, will automatically select the first item in the completion list
                    preselect = true,
                    auto_insert = false,
                },
            },
        },
        cmdline = {
            keymap = {
                preset = 'inherit',
            },
            completion = {
                menu = {
                    auto_show = false,
                },
                list = {
                    selection = {
                        -- When `true`, will automatically select the first item in the completion list
                        preselect = true,
                        auto_insert = false,
                    },
                },
            },

        },
        -- Use luasnip preset
        snippets = { preset = 'luasnip' },
        -- Default source providers
        sources = {
            default = { 'lsp', 'path' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
