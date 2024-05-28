return function(opts)
  vim.diagnostic.config(opts.diagnostics)

  local servers = opts.servers

  local hasCmp, cmpNvimLsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    hasCmp and cmpNvimLsp.default_capabilities() or {},
    opts.capabilities or {}
  )

  local function setup(server)
    local serverOpts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
    }, servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, serverOpts) then
        return
      end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, serverOpts) then
        return
      end
    end

    require("lspconfig")[server].setup(serverOpts)
  end

  local hasMason, mlsp = pcall(require, "mason-lspconfig")
  local allMslpServers = {}

  if hasMason then
    allMslpServers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  end

  local ensureInstalled = {} ---@type string[]
  for server, serverOpts in pairs(servers) do
    if serverOpts then
      serverOpts = serverOpts == true and {} or serverOpts

      if serverOpts.mason == false or not vim.tbl_contains(allMslpServers, server) then
        vim.notify(server)
        setup(server)
      elseif serverOpts.enabled ~= false then
        ensureInstalled[#ensureInstalled + 1] = server
      end
    end
  end

  if hasMason then
    mlsp.setup({ ensure_installed = ensureInstalled, handlers = { setup } })
  end
end
