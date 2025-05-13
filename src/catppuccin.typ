#import "flavors.typ": (
  color-names,
  color-schema,
  flavors,
  frappe,
  get-or-validate-flavor,
  latte,
  macchiato,
  mocha,
)

/// Configures the appearance of code blocks and code boxes.
/// -> content
#let config-code-blocks(
  /// The flavor to set -> string | flavor
  flavor,
  body,
) = {
  let palette = get-or-validate-flavor(flavor)
  let tmTheme = "./tmThemes/" + palette.identifier + ".tmTheme"
  set raw(theme: tmTheme)

  body
}

/// Configure your document to use a Catppuccin flavor.
///
/// ==== Example
/// ```typ
///   #import "@preview/catppuccin": catppuccin, flavors
///
///   #show: catppuccin.with(flavors.mocha)
/// ```
/// This should be used at the top of your document.
///
/// -> content
#let catppuccin(
  /// The flavor to set -> string | flavor
  flavor,
  body,
) = {
  let flavor = get-or-validate-flavor(flavor)

  set page(fill: flavor.colors.base.rgb)
  set text(fill: flavor.colors.text.rgb)

  show: config-code-blocks.with(flavor)

  body
}
