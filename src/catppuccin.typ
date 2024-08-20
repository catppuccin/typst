#import "flavors.typ": latte, frappe, macchiato, mocha
#import "valkyrie/typst-schema.typ": *
#import "@preview/valkyrie:0.2.1" as z

/// The available flavors for Catppuccin. Given simply by the dictionary
/// ```typ
///  #let themes = (
///    latte: "latte",
///    frappe: "frappe",
///    macchiato: "macchiato",
///    mocha: "mocha",
///  )
///```
/// These names are used to set the theme of the document. To access the accented names, you can use @@get-palette() and access the `name` key.
///
/// -> dictionary
#let themes = (
  latte: "latte",
  frappe: "frappe",
  macchiato: "macchiato",
  mocha: "mocha",
)

/// Get the color palette for the given theme. The returned dictionary has keys as defined in @flavor-schema[Flavor Schemas].
///
/// ==== Example
/// #example(
/// ```typ
///   #let items = themes.values().map(theme => [
///     #let palette = get-palette(theme)
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
#let get-palette(theme) = {
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

#let code-block-config-schema = z.dictionary((
  inset: inset-schema(default: 7pt),
  outset: outset-schema(default: (y: 3pt)),
  radius: radius-schema(default: 3pt),
  breakable: z.boolean(default: false),
  width: z.either(
    rel-or-length(),
    z.function(),
    sides-schema,
    post-transform: (self, it) => if type(it) == dictionary and it == (:) {
      0pt
    } else {
      it
    },

    default: it => measure(it).width + 1cm,
  ),
))

#let code-box-config-schema = z.dictionary((
  inset: inset-schema(default: (x: 2pt, y: 0pt)),
  outset: outset-schema(default: (y: 2pt)),
  radius: radius-schema(default: 3pt),
))

#let config-code-blocks(theme, code-block: true, code-syntax: true, block-config: (:), inline-config: (:), body) = [
  #let palette = get-palette(theme)

  #let tmTheme = "tmThemes/" + theme + ".tmTheme"
  #set raw(theme: tmTheme) if code-syntax

  #show raw.where(block: false): it => [
    #let config = z.parse(inline-config, code-box-config-schema)
    #box(..config, it)
  ]

  #show raw.where(block: true): it => [
    #let config = z.parse(block-config, code-block-config-schema) + (fill: palette.colors.crust.rgb)

    #if type(config.at("width")) == function {
      config.insert("width", (config.at("width"))(it))
    }

    #set align(center)
    #block(..config, it)
  ]

  #body
]

/// Configure your document to use a Catppuccin flavor.
///
/// ==== Example:
/// ```typ
///   #import "@preview/catppuccin": catppuccin, themes
///
///   #show: catppuccin.with(themes.mocha, code-block: true, code-syntax: true)
/// ```
/// This should be used at the top of your document.
///
/// - theme (string): The flavor to set.
/// - code-block (boolean): Whether to styalise code blocks.
/// - code-syntax (boolean): Whether to use Catppuccin syntax highlighting in code blocks.
/// - body (content): The content to apply the flavor to.
/// -> content
#let catppuccin(theme, code-block: true, code-syntax: true, body) = [
  #let palette = get-palette(theme)

  #set page(fill: palette.colors.base.rgb)
  #set text(fill: palette.colors.text.rgb)

  #show: config-code-blocks.with(theme, code-block: code-block, code-syntax: code-syntax)

  #body
]
