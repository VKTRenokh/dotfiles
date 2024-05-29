--stylua: ignore start
return {
  s('arrow', {
    c(1, {
      { t("const "), i(1, "main"), t(" = ("), i(2), t("): "), i(3), t(" => "), t({"{", "\t"}), i(4), t({"", "}"}) },
      { t("const "), i(1, "main"), t(" = ("), i(2), t("): "), i(3), t(" => "), i(4) }
    })
  }),
  s('obj', {
    t({'{', ''}), t("\t"), i(1, 'key'), t(': '), i(2, 'value'), t({' '}), i(3), t({'', '}'})
  }),
  -- TODO: implement new Map([[key, value]]) snippet
  s('map', {})
}
--stylua: ignore end
