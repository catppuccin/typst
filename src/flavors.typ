#import "flavors/catppuccin-latte.typ": latte
#import "flavors/catppuccin-frappe.typ": frappe
#import "flavors/catppuccin-macchiato.typ": macchiato
#import "flavors/catppuccin-mocha.typ": mocha

/// The available flavors for Catppuccin. Given simply by the dictionary
/// ```typ
///  #let flavors = (
///    latte: { ... },
///    frappe: { ... },
///    macchiato: { ... },
///    mocha: { ... },
///  )
///```
///
/// -> dictionary
#let flavors = (
  latte: latte,
  frappe: frappe,
  macchiato: macchiato,
  mocha: mocha,
)

/// Get the palette for the given flavor.
///
/// ==== Example
/// #example(
/// ```typ
///   #let items = flavors.values().map(flavor => [
///     #let rainbow = (
///       "red", "yellow", "green",
///       "blue", "mauve",
///     ).map(c => flavor.colors.at(c).rgb)
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
///       text(flavor.name + ":"),
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
/// - flavor (string): The flavor name as a string to get the flavor for. This function is provided as a helper for anyone requiring dynamic resolution of a flavor.
/// -> dictionary
#let get-flavor(flavor) = {
  assert(type(flavor) == str, message: "Invalid type. Argument should be a string. Got a " + repr(type(flavor)))
  assert(flavor in flavors.keys(), message: "Invalid flavor name: " + repr(flavor))

  flavors.at(flavor)
}
