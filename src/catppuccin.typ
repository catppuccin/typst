#import "flavors.typ": latte, frappe, macchiato, mocha

#let themes = (
  latte: "latte",
  frappe: "frappe",
  macchiato: "macchiato",
  mocha: "mocha",
)

#let get_palette(theme) = {
  if theme not in themes.values() {
    panic("Invalid theme: " + theme)
  }

  if theme == themes.latte {
    latte
  } else if theme == themes.frappe {
    frappe
  } else if theme == themes.macchiato {
    macchiato
  } else if theme == themes.mocha {
    mocha
  } else {
    panic("Invalid theme: " + theme)
  }
}

#let config_code_blocks(theme: themes.mocha, code_block: true, body) = [
  #let tmTheme = "tmThemes/" + theme + ".tmTheme"
  #let palette = get_palette(theme)

  #set raw(theme: tmTheme)

  #show raw.where(block: false): box.with(inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt)

  #show raw.where(block: true): it => [
    #set align(center)
    #set block(
      fill: palette.colors.crust.rgb,
      inset: 10pt,
      outset: (y: 3pt),
      radius: 4pt,
    )
    #it
  ]

  #body
]

#let catppuccin(theme: themes.mocha, code_block: true, body) = [
  #let palette = get_palette(theme)

  #set page(fill: palette.colors.base.rgb)
  #set text(fill: palette.colors.text.rgb)

  #show: config_code_blocks.with(theme: theme, code_block: code_block)
  #body
]