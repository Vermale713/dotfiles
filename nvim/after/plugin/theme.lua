local clients_lsp = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_clients()
  if next(clients) == nil then
    return ""
  end

  local c = {}
  for _, client in pairs(clients) do
    table.insert(c, client.name)
  end
  return " " .. table.concat(c, "|")
end

require('bufferline').setup({
  options = {
    close_command = "bp|sp|bn|bd! %d",
    right_mouse_command = "bp|sp|bn|bd! %d",
    left_mouse_command = "buffer %d",
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    show_close_icon = false,
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 10,
    show_tab_indicators = true,
    indicator = {},
    enforce_regular_tabs = false,
    view = "multiwindow",
    show_buffer_close_icons = true,
    separator_style = "slope",
    always_show_bufferline = true,
    diagnostics = "nvim_lsp",
    themable = true,
  },
})
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = "kanagawa",
    -- component_separators = { left = '', right = ''},
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
  },

  sections = {
    lualine_a = { { "mode", icon = "" } },
    lualine_b = {
      {
        "filetype",
        icon_only = true,
        padding = { left = 1, right = 0 },
      },
      "filename",
    },
    lualine_c = {
      {
        "branch",
        icon = "",
      },
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        colored = false,
      },
    },
    lualine_x = {
      {
        "diagnostics",
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        update_in_insert = true,
      },
    },
    lualine_y = { clients_lsp },
    lualine_z = { { "location", icon = "" } },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_y = {},
    lualine_x = {},
    lualine_z = { "location" },
  },
})
