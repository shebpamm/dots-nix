local M = {}

M.setup = {
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
        ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
        ["https://json.schemastore.org/chart.json"] = "Chart.yaml",
        ['kubernetes'] = "*.yaml",
      },
    },
  },
}

return M
