#import "flavors.typ": latte, frappe, macchiato, mocha

/// The available flavors for Catppuccin.
/// -> dict
#let themes = (
  latte: "latte",
  frappe: "frappe",
  macchiato: "macchiato",
  mocha: "mocha",
)

/// Get the color palette for the given `theme`.
/// - theme (str): The theme to get the palette for.
/// -> dict
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

#let config_code_blocks(theme, code_block: true, code_syntax: true, body) = [
  #let tmTheme = "tmThemes/" + theme + ".tmTheme"
  #let palette = get_palette(theme)

  #set raw(theme: tmTheme) if code_syntax

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

/// Configure your document to use a Catppuccin flavor.
/// - theme (str): The flavor to set.
/// - code_block (bool): Whether to styalise code blocks.
/// - code_syntax (bool): Whether to use Catppuccin syntax highlighting in code blocks.
/// - body (content): The content to apply the flavor to.
/// -> content
#let catppuccin(theme, code_block: true, code_syntax: true, body) = [
  #let palette = get_palette(theme)

  #set page(fill: palette.colors.base.rgb)
  #set text(fill: palette.colors.text.rgb)

  #show: config_code_blocks.with(theme, code_block: code_block, code_syntax: code_syntax)

  #body
]