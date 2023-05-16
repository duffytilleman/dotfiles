--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, and understand
  what your configuration is doing.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set comma as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)

function Dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. Dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Other plugin pre-load settings
vim.g.fugitive_legacy_commands = 0

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- use - to navigate up to folder
  'tpope/vim-vinegar',

  -- Unix commands, e.g. :Delete
  'tpope/vim-eunuch',

  -- crs (coerce to snake_case), :Subvert and more
  'tpope/vim-abolish',

  -- change surrounding quotes, parens, xml tags e.g. cs([
  'tpope/vim-surround',

  -- make vim-surround and other plugins work with `.` to repeat
  'tpope/vim-repeat',

  -- database client with :DB
  'tpope/vim-dadbod',

  'mg979/vim-visual-multi',

  {
    "dpayne/CodeGPT.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require("codegpt.config")

      -- vim.g["codegpt_commands_defaults"]["completion"]["model"] = "gpt-4"
      -- vim.g["codegpt_commands_defaults"]["code_edit"]["model"] = "gpt-4"

      vim.g["codegpt_commands_defaults"] = {
        ["completion"] = {
          user_message_template =
          "I have the following {{language}} code snippet: ```{{filetype}}\n{{text_selection}}```\nComplete the rest. Use best practices and write really good documentation. {{language_instructions}} Only return the code snippet and nothing else.",
          language_instructions = {
            cpp = "Use modern C++ features.",
            java = "Use modern Java syntax. Use var when applicable.",
          },
          model = "gpt-4",
        },
        ["code_edit"] = {
          user_message_template =
          "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\n{{command_args}}. {{language_instructions}} Only return the code snippet and nothing else.",
          language_instructions = {
            cpp = "Use modern C++ syntax.",
          },
          model = "gpt-4",
        },
        ["explain"] = {
          user_message_template =
          "Explain the following {{language}} code: ```{{filetype}}\n{{text_selection}}``` Explain as if you were explaining to another developer.",
          callback_type = "text_popup",
        },
        ["question"] = {
          user_message_template =
          "I have a question about the following {{language}} code: ```{{filetype}}\n{{text_selection}}``` {{command_args}}",
          callback_type = "text_popup",
        },
        ["debug"] = {
          user_message_template =
          "Analyze the following {{language}} code for bugs: ```{{filetype}}\n{{text_selection}}```",
          callback_type = "text_popup",
        },
        ["doc"] = {
          user_message_template =
          "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\nWrite really good documentation using best practices for the given language. Attention paid to documenting parameters, return types, any exceptions or errors. {{language_instructions}} Only return the code snippet and nothing else.",
          language_instructions = {
            cpp = "Use doxygen style comments for functions.",
            java = "Use JavaDoc style comments for functions.",
          },
        },
        ["opt"] = {
          user_message_template =
          "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\nOptimize this code. {{language_instructions}} Only return the code snippet and nothing else.",
          language_instructions = {
            cpp = "Use modern C++.",
          },
        },
        ["tests"] = {
          user_message_template =
          "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\nWrite really good unit tests using best practices for the given language. {{language_instructions}} Only return the unit tests. Only return the code snippet and nothing else. ",
          callback_type = "code_popup",
          language_instructions = {
            cpp = "Use modern C++ syntax. Generate unit tests using the gtest framework.",
            java = "Generate unit tests using the junit framework.",
          },
        },
        ["chat"] = {
          system_message_template = "You are a general assistant to a software developer.",
          user_message_template = "{{command_args}}",
          callback_type = "text_popup",
        },
      }

      vim.g["codegpt_hooks"] = {
        request_started = function()
          vim.cmd("hi StatusLine ctermbg=NONE ctermfg=yellow")
        end,
        request_finished = vim.schedule_wrap(function()
          vim.cmd("hi StatusLine ctermbg=NONE ctermfg=NONE")
        end)
      }
    end
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- {
  --   'jose-elias-alvarez/typescript.nvim',
  --   opts = {
  --     -- disable_commands = false, -- prevent the plugin from creating Vim commands
  --     debug = false, -- enable debug logging for commands
  --     go_to_source_definition = {
  --       fallback = true, -- fall back to standard LSP definition on failure
  --     },
  --     server = { -- pass options to lspconfig's setup method
  --       -- on_attach = ...,
  --     },
  --   },
  -- },

  -- {
  --   'jose-elias-alvarez/null-ls.nvim',
  --   opts = {
  --     sources = {
  --       require("typescript.extensions.null-ls.code-actions"),
  --     },
  --   },
  -- },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',          opts = {} },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'nordtheme/vim',
    priority = 1000,
    config = function()
      vim.g.nord_disable_background = true
      vim.cmd.colorscheme 'nord'
    end,
  },

  -- { -- Nord theme
  --   'shaunsingh/nord.nvim',
  --   priority=1000,
  --   opts={
  --     options={
  --       nord_disable_background = true
  --     }
  --   },
  --   config = function()
  --     vim.g.nord_disable_background = true
  --     vim.cmd [[highlight IndentBlanklineIndent1 guifg=#555555 gui=nocombine]]
  --     vim.cmd.colorscheme 'nord'
  --   end,
  -- },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          {
            'filename',
            path = 4
          }
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 4
          }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      }
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
      char_highlight_list = {
        "IndentBlanklineIndent1",
      }
    },
  },

  -- Needed for Comment.nvim to work with vue SFC
  'JoosepAlviste/nvim-ts-context-commentstring',

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        -- From https://github.com/JoosepAlviste/nvim-ts-context-commentstring
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    opts = {}
  },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })

      -- From https://github.com/JoosepAlviste/nvim-ts-context-commentstring
      require 'nvim-treesitter.configs'.setup {
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        }
      }
    end,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  -- { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]
-- Basic key setup

vim.g.mapleader = ","


-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = '[,] Find existing buffers' })
vim.keymap.set('n', '<C-b>', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- If the current file has a containing git dir, use that as the base for telescope find commands, etc, otherwise use CWD
local getProjectRoot = function()
  local root_dir = vim.fn.getcwd()
  for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
    print("Checking if dir is a git project: ", dir)
    if vim.fn.isdirectory(dir .. "/.git") == 1 then
      root_dir = dir
      break
    end
  end
  print("Found project root as: ", root_dir)
  return root_dir
end

vim.keymap.set('n', '<C-p>', function()
  require('telescope.builtin').find_files { search_dirs = { getProjectRoot() } }
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sf', function()
  require('telescope.builtin').find_files { search_dirs = { getProjectRoot() } }
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', function()
  require('telescope.builtin').grep_string { cwd = getProjectRoot() }
end, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', function()
  require('telescope.builtin').live_grep { cwd = getProjectRoot() }
end, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')

  nmap('<C-]>', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('<C-\\>', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>I', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  --  See https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md for names
  -- tsserver = {},
  volar = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

vim.api.nvim_exec([[
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
]], false)
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#555555 gui=nocombine]]
vim.cmd [[highlight comment guifg=#999999 gui=nocombine]]

vim.keymap.set('i', 'kj', '<Esc>', {})
vim.keymap.set('', '<F2>', ':set paste!<CR>', {})

-- Move lines up and down with arrow keys
vim.keymap.set('n', '<Down>', ':m .+1<CR>==', { noremap = true })
vim.keymap.set('n', '<Up>', ':m .-2<CR>==', { noremap = true })
vim.keymap.set('i', '<Down>', '<Esc>:m .+1<CR>==gi', { noremap = true })
vim.keymap.set('i', '<Up>', '<Esc>:m .-2<CR>==gi', { noremap = true })
vim.keymap.set('v', '<Down>', ':m \'>+1<CR>gv=gv', { noremap = true })
vim.keymap.set('v', '<Up>', ':m \'<-2<CR>gv=gv', { noremap = true })

vim.keymap.set('n', '<leader>t', '<cmd>lua vim.lsp.buf.hover()<cr>', { noremap = true })
vim.keymap.set('n', '<C-\\>', '<cmd>lua vim.lsp.buf.references()<cr>', { noremap = true })
vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', { noremap = true })
vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', { noremap = true })

-- Create an empty line underneath without moving the cursor
vim.keymap.set('', '<CR>', 'v:lua.create_empty_line()', { expr = true, noremap = true })
_G.create_empty_line = function()
  local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
  return buftype == 'quickfix' and '<CR>' or 'mlo<Esc>`l'
end

-- Indent with spacebar
vim.keymap.set({ 'n', 'v' }, '<space>', '>>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<S-Tab>', '<<', { noremap = true })

-- Copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<leader>Y', '"+yg_', { noremap = true })
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<leader>yy', '"+yy', { noremap = true })

-- Pane/split navigation
vim.keymap.set('', 'gh', '<C-W>h', { noremap = true })
vim.keymap.set('', 'gj', '<C-W><C-j>', { noremap = true })
vim.keymap.set('', 'gk', '<C-W><C-k>', { noremap = true })
vim.keymap.set('', 'gl', '<C-W>l', { noremap = true })
vim.keymap.set('', 'g=', '<C-W>=', { noremap = true })
vim.keymap.set('', 'g|', '<C-W>|', { noremap = true })
vim.keymap.set('', 'g<', '<C-W><', { noremap = true })
vim.keymap.set('', 'g>', '<C-W>>', { noremap = true })
vim.keymap.set('', 'g+', '<C-W>+', { noremap = true })
vim.keymap.set('', '+', ':resize +10<cr>', { noremap = true })
vim.keymap.set('', '=', ':resize -10<cr>', { noremap = true })

-- diffs
vim.keymap.set('n', '<leader>do', ':diffoff<cr>', { noremap = true })
vim.keymap.set('n', '<leader>dt', ':diffthis<cr>', { noremap = true })

-- quickly edit vimrc
vim.keymap.set('n', '<leader>ev', ':vsplit $MYVIMRC<cr>', { noremap = true })
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<cr>:echo "Sourced init.vim"<cr>', { noremap = true })
vim.keymap.set('', '<F4>', ':source $MYVIMRC<cr>:PlugInstall<cr>', { noremap = true })

-- dadbod database plugin config

-- Default to treating .sql files as pgsql (from https://github.com/lifepillar/pgsql.vim)
vim.g.sql_type_default = 'pgsql'
vim.g.db = vim.env.DATABASE_URL
-- vim.keymap.set('v', '<leader>e', ':DB $DATABASE_URL<return>', {noremap = true})
-- vim.keymap.set('n', '<leader>e', ':DB $DATABASE_URL<return>', {noremap = true})
vim.keymap.set('', '<leader>w', 'vip:DB $DATABASE_URL<return>', { noremap = true })

-- Duffy workflow shortcut
-- For use in daily activity log
vim.keymap.set('', '<leader>tt', ':w<cr>:read !date<cr>A |', { noremap = true })
vim.keymap.set('', '<leader>tl', 'yypkiconsole.log(\'<C-v><C-A>\')<C-v><Esc>', { noremap = true })

-- Fix the duplicate <leader>c mapping
vim.keymap.set('', '<leader>c', ':w ! pbcopy<cr><cr>', { noremap = true })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
