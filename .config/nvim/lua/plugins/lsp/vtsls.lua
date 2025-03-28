return {
          enabled = true,
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.jsx",
            "vue",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTskd = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
              tsserver = {
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    languages = { "vue" },
                    configNamespace = "typescript",
                    location = get_pkg_path(
                      "vue-language-server",
                      "/node_modules/@vue/language-server"
                    ),
                    enableForWorkspaceTypescriptVersion = true,
                  },
                },
              },
            },
            typescript = {
              suggest = { completeFunctionCalls = true },
              updateImportsOnFileMove = { enabled = "always" },
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        }
