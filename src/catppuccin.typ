#import "flavors.typ": latte, frappe, macchiato, mocha

/// The available flavors for Catppuccin. Given simply by the dictionary
/// ```typ
///  #let themes = (
///    latte: "latte",
///    frappe: "frappe",
///    macchiato: "macchiato",
///    mocha: "mocha",
///  )
///```
/// These names are used to set the theme of the document. To access the accented names, you can use @@get_palette() and access the `name` key. See @@get_palette()'s section @schema[Schema].
///
/// -> dictionary
#let themes = (
  latte: "latte",
  frappe: "frappe",
  macchiato: "macchiato",
  mocha: "mocha",
)

/// Get the color palette for the given theme.
/// ==== Schema <schema>
/// - name (```typ string```): The name of the flavor (e.g. Frappé)
/// - emoji (```typ string```): The emoji associated with the flavor.
/// - order (```typ integer```): The order of the flavor in the Catppuccin lineup.
/// - dark (```typ boolean```): Whether the flavor is a dark theme.
/// - light (```typ boolean```): Whether the flavor is a light theme.
/// - colors (```typ dictionary```): A dictionary of colors used in the flavor. Keys are the color names as a ```typ string``` and values are dictionaries with the following keys:
///   - name (```typ string```): The name of the color.
///   - order (```typ integer```): The order of the color in the palette.
///   - hex (```typ string```): The hex value of the color.
///   - rgb (```typ string```): The RGB value of the color.
///   - accent (```typ boolean```): Whether the color is an accent color.
///
/// ==== Example
/// #example(
/// ```typ
///   #let items = themes.values().map(theme => [
///     #let palette = get_palette(theme)
///     #let rainbow = (
///       "red", "yellow", "green",
///       "blue", "mauve",
///     ).map(c => palette.colors.at(c).rgb)
///
///     #let fills = (
///       gradient.linear(..rainbow),
///       gradient.radial(..rainbow),
///       gradient.conic(..rainbow),
///     )
///
///     #stack(
///       dir: ttb,
///       spacing: 4pt,
///       text(palette.name + ":"),
///       stack(
///         dir: ltr,
///         spacing: 3mm,
///         ..fills.map(fill => square(fill: fill))
///       )
///     )
///   ])
///
///   #grid(columns: 1, gutter: 1em, ..items)
/// ```, ratio: 1.5)
///
/// - theme (string): The theme to get the palette for. The dict @@themes can be used to simplify this.
/// -> dictionary
#let get_palette(theme) = {
  assert(theme in themes.values(), message: "Invalid theme: " + repr(theme))

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
  #let palette = get_palette(theme)

  #let tmTheme = "tmThemes/" + theme + ".tmTheme"
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
///
/// *Example:*
/// ```typ
///   #import "@preview/catppuccin": catppuccin, themes
///
///   #show: catppuccin.with(themes.mocha, code_block: true, code_syntax: true)
/// ```
/// This should be used at the top of your document.
///
/// - theme (string): The flavor to set.
/// - code_block (boolean): Whether to styalise code blocks.
/// - code_syntax (boolean): Whether to use Catppuccin syntax highlighting in code blocks.
/// - body (content): The content to apply the flavor to.
/// -> content
#let catppuccin(theme, code_block: true, code_syntax: true, body) = [
  #let palette = get_palette(theme)

  #set page(fill: palette.colors.base.rgb)
  #set text(fill: palette.colors.text.rgb)

  #show: config_code_blocks.with(theme, code_block: code_block, code_syntax: code_syntax)

  #body
]
