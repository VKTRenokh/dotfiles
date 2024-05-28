--stylua: ignore start
return {
  s("plugin", {
    t({"{", ""}),
    t("\t'"), i(1), t({"',", ""}),
    t("\tkeys = {"), i(2), t({ "},", "" }),
    t("\topts = {"), i(3), t({ "},", "" }),
    t("\tconfig = "), c(4, {
      i(1, "true"), 
      {t({ "function(_, opts)", "\t\t" }), i(1), t({ "",  "\tend" })}
    }), t(','),
    t({'', "}"})
  }),
}
--stylua: ignore end
