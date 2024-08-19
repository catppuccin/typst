#import "flavors/catppuccin-latte.typ": latte as _latte
#import "flavors/catppuccin-frappe.typ": frappe as _frappe
#import "flavors/catppuccin-macchiato.typ": macchiato as _macchiato
#import "flavors/catppuccin-mocha.typ": mocha as _mocha

/// The Latte color palette.
///
/// ==== Example
/// #example(
/// ```typ
///   #let theme = themes.latte
///   #let palette = get-palette(theme)
///   Selected theme: #palette.name #palette.emoji
/// ```, ratio: 1.6)
///
/// -> flavor
#let latte = _latte

/// The Frappé color palette.
///
/// ==== Example
/// #example(
/// ```typ
///   #let theme = themes.frappe
///   #let palette = get-palette(theme)
///   Selected theme: #palette.name #palette.emoji
/// ```, ratio: 1.6)
///
/// -> flavor
#let frappe = _frappe

/// The Macchiato color palette.
///
/// ==== Example
/// #example(
/// ```typ
///   #let theme = themes.macchiato
///   #let palette = get-palette(theme)
///   Selected theme: #palette.name #palette.emoji
/// ```, ratio: 1.6)
///
/// -> flavor
#let macchiato = _macchiato

/// The Mocha color palette.
///
/// ==== Example
/// #example(
/// ```typ
///   #let theme = themes.mocha
///   #let palette = get-palette(theme)
///   Selected theme: #palette.name #palette.emoji
/// ```, ratio: 1.6)
///
/// -> flavor
#let mocha = _mocha
