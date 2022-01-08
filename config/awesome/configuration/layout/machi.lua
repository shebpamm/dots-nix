local machi = require "../../modules/layout-machi"

return {
  machi = machi,
  primary = machi.layout.create { name = "primary_machi" },
  secondary = machi.layout.create { name = "secondary_machi", new_placement_cb = machi.layout.placement.empty },
}
