#import "flavors.typ": latte, frappe, macchiato, mocha, color-names, color-schema, flavors, get-or-validate-flavor
#import "styling/code.typ": config-code-blocks
#import "valkyrie/typst-schema.typ": *
#import "@preview/valkyrie:0.2.1" as z

/// Configure your document to use a Catppuccin flavor.
///
/// ==== Example:
/// ```typ
///   #import "@preview/catppuccin": catppuccin, flavors
///
///   #show: catppuccin.with(flavors.mocha, code-block: true, code-syntax: true)
/// ```
/// This should be used at the top of your document.
///
/// - flavor (string, flavor): The flavor to set.
/// - code-block (boolean): Whether to styalise code blocks.
/// - code-syntax (boolean): Whether to the Catppuccin flavor to code syntax highlighting.
/// - block-config (dictionary): Additional configuration for code blocks.
/// - inline-config (dictionary): Additional configuration for code boxes.
/// - body (content): The content to apply the flavor to.
/// -> content
#let catppuccin(
  flavor,
  code-block: true,
  code-syntax: true,
  block-config: (:),
  inline-config: (:),
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
