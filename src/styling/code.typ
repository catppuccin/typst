#import "../flavors.typ": flavors, get-or-validate-flavor
#import "../valkyrie/typst-schema.typ": *
#import "@preview/valkyrie:0.2.2" as z

// TODO: This module might be significantly easier if we use codly for code block styling.

#let default-code-block-config = (
  inset: (x: 3em, y: 1.5em),
  outset: 3pt,
  radius: 3pt,
  breakable: false,
)

#let default-code-box-config = (
  inset: (left: 3pt),
  radius: 3pt,
)

/// Configures the appearance of code blocks and code boxes.
/// -> content
#let config-code-blocks(
  /// The flavor to set -> string | flavor
  flavor,
  /// Whether to stylise code blocks -> boolean
  code-block: true,
  /// Whether to the Catppuccin flavor to code syntax highlighting -> boolean
  code-syntax: true,
  /// Additional configuration for code blocks -> dictionary
  block-config: (:),
  /// Additional configuration for code boxes -> dictionary
  inline-config: (:),
  /// The content to apply the configuration to -> content
  body,
) = [
  #let palette = get-or-validate-flavor(flavor)
  #let tmTheme = "../tmThemes/" + palette.identifier + ".tmTheme"
  #set raw(theme: tmTheme) if code-syntax

  #show raw.where(block: false): it => [
    #let config = default-code-box-config + inline-config
    #box(..config, it)
  ]

  #show raw.where(block: true): it => {
    if not code-block {
      return it
    }

    context [
      #let config = (
        default-code-block-config
          + (fill: palette.colors.crust.rgb)
          + block-config
      )
      #block(..config, it)
    ]
  }

  #body
]
