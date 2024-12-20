#import "flavors.typ": latte, frappe, macchiato, mocha, color-names, color-schema, flavors, get-or-validate-flavor
#import "styling/code.typ": config-code-blocks
#import "valkyrie/typst-schema.typ": *
#import "@preview/valkyrie:0.2.1" as z

/// Configure your document to use a Catppuccin flavor.
///
/// ==== Example
/// ```typ
///   #import "@preview/catppuccin": catppuccin, flavors
///
///   #show: catppuccin.with(flavors.mocha, code-block: true, code-syntax: true)
/// ```
/// This should be used at the top of your document.
///
/// -> content
#let catppuccin(
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
  /// The content to apply the flavor to -> content
  body,
) = [
  #let flavor = get-or-validate-flavor(flavor)

  #set page(fill: flavor.colors.base.rgb)
  #set text(fill: flavor.colors.text.rgb)

  #show: config-code-blocks.with(
    flavor,
    code-block: code-block,
    code-syntax: code-syntax,
    block-config: block-config,
    inline-config: inline-config,
  )

  #body
]
