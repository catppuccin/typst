#import "flavors.typ": latte, frappe, macchiato, mocha, get-flavor, flavors, parse-flavor
#import "valkyrie/typst-schema.typ": *
#import "@preview/valkyrie:0.2.1" as z

/// Configure your document to use a Catppuccin flavor.
///
/// ==== Example:
/// ```typ
///   #import "@preview/catppuccin": catppuccin, flavors
///
///   #show: catppuccin.with(flavors.mocha)
/// ```
/// This should be used at the top of your document.
///
/// - flavor (string | flavor): The flavor to set.
/// - body (content): The content to apply the flavor to.
/// -> content
#let catppuccin(flavor, body) = [
  #let flavor = parse-flavor(flavor)

  #set page(fill: flavor.colors.base.rgb)
  #set text(fill: flavor.colors.text.rgb)

  #body
]
