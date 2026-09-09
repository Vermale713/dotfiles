local function pack_sync()
  local active_plugins = {}
  local unused_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    print("No unused plugins.")
    return
  end

  local choice = vim.fn.confirm(
    "Remove unused plugins?\n" .. table.concat(unused_plugins, "\n"),
    "&Yes\n&No",
    2
  )
  if choice == 1 then
    vim.pack.del(unused_plugins)
  end
end

vim.api.nvim_create_user_command("PackSync", pack_sync, {
  desc = "Remove vim.pack plugins that are installed but no longer active",
})

-- Shift held a beat too long: make :W, :Wq, :Qa & co. do the obvious thing.
local function alias(name, target, opts)
  vim.api.nvim_create_user_command(name, function(cmd)
    local range = ""
    if cmd.range == 1 then
      range = tostring(cmd.line1)
    elseif cmd.range == 2 then
      range = cmd.line1 .. "," .. cmd.line2
    end

    vim.cmd(
      range
        .. target
        .. (cmd.bang and "!" or "")
        .. (cmd.args ~= "" and " " .. cmd.args or "")
    )
  end, vim.tbl_extend("force", { bang = true, bar = true }, opts or {}))
end

-- take a range and a file argument, like the commands they stand in for
local writes = {
  W = "w",
  Wq = "wq",
  WQ = "wq",
  X = "x",
}

-- no arguments, just the bang
local plain = {
  Wa = "wa",
  WA = "wa",
  Wall = "wall",
  Wqa = "wqa",
  WQa = "wqa",
  WQA = "wqa",
  Wqall = "wqall",
  Q = "q",
  Qa = "qa",
  QA = "qa",
  Qall = "qall",
  Xa = "xa",
  XA = "xa",
  Xall = "xall",
}

for name, target in pairs(writes) do
  alias(name, target, { nargs = "?", range = true, complete = "file" })
end

for name, target in pairs(plain) do
  alias(name, target)
end
