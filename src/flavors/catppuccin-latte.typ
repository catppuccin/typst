/// The Latte color palette.
///
/// ==== Example
/// #example(
/// ```typ
///   #let theme = themes.latte
///   #let palette = get_palette(theme)
///   Selected theme: #palette.name #palette.emoji
/// ```, ratio: 1.5)
///
/// -> dictionary
#let latte = (
  name: "Latte",
  emoji: "🌻",
  order: 0,
  dark: false,
  light: true,
  colors: (
    rosewater: (
      name: "Rosewater",
      order: 0,
      hex: "#dc8a78",
      rgb: rgb(220, 138, 120),
      accent: true,
    ),
    flamingo: (
      name: "Flamingo",
      order: 1,
      hex: "#dd7878",
      rgb: rgb(221, 120, 120),
      accent: true,
    ),
    pink: (
      name: "Pink",
      order: 2,
      hex: "#ea76cb",
      rgb: rgb(234, 118, 203),
      accent: true,
    ),
    mauve: (
      name: "Mauve",
      order: 3,
      hex: "#8839ef",
      rgb: rgb(136, 57, 239),
      accent: true,
    ),
    red: (
      name: "Red",
      order: 4,
      hex: "#d20f39",
      rgb: rgb(210, 15, 57),
      accent: true,
    ),
    maroon: (
      name: "Maroon",
      order: 5,
      hex: "#e64553",
      rgb: rgb(230, 69, 83),
      accent: true,
    ),
    peach: (
      name: "Peach",
      order: 6,
      hex: "#fe640b",
      rgb: rgb(254, 100, 11),
      accent: true,
    ),
    yellow: (
      name: "Yellow",
      order: 7,
      hex: "#df8e1d",
      rgb: rgb(223, 142, 29),
      accent: true,
    ),
    green: (
      name: "Green",
      order: 8,
      hex: "#40a02b",
      rgb: rgb(64, 160, 43),
      accent: true,
    ),
    teal: (
      name: "Teal",
      order: 9,
      hex: "#179299",
      rgb: rgb(23, 146, 153),
      accent: true,
    ),
    sky: (
      name: "Sky",
      order: 10,
      hex: "#04a5e5",
      rgb: rgb(4, 165, 229),
      accent: true,
    ),
    sapphire: (
      name: "Sapphire",
      order: 11,
      hex: "#209fb5",
      rgb: rgb(32, 159, 181),
      accent: true,
    ),
    blue: (
      name: "Blue",
      order: 12,
      hex: "#1e66f5",
      rgb: rgb(30, 102, 245),
      accent: true,
    ),
    lavender: (
      name: "Lavender",
      order: 13,
      hex: "#7287fd",
      rgb: rgb(114, 135, 253),
      accent: true,
    ),
    text: (
      name: "Text",
      order: 14,
      hex: "#4c4f69",
      rgb: rgb(76, 79, 105),
      accent: false,
    ),
    subtext1: (
      name: "Subtext 1",
      order: 15,
      hex: "#5c5f77",
      rgb: rgb(92, 95, 119),
      accent: false,
    ),
    subtext0: (
      name: "Subtext 0",
      order: 16,
      hex: "#6c6f85",
      rgb: rgb(108, 111, 133),
      accent: false,
    ),
    overlay2: (
      name: "Overlay 2",
      order: 17,
      hex: "#7c7f93",
      rgb: rgb(124, 127, 147),
      accent: false,
    ),
    overlay1: (
      name: "Overlay 1",
      order: 18,
      hex: "#8c8fa1",
      rgb: rgb(140, 143, 161),
      accent: false,
    ),
    overlay0: (
      name: "Overlay 0",
      order: 19,
      hex: "#9ca0b0",
      rgb: rgb(156, 160, 176),
      accent: false,
    ),
    surface2: (
      name: "Surface 2",
      order: 20,
      hex: "#acb0be",
      rgb: rgb(172, 176, 190),
      accent: false,
    ),
    surface1: (
      name: "Surface 1",
      order: 21,
      hex: "#bcc0cc",
      rgb: rgb(188, 192, 204),
      accent: false,
    ),
    surface0: (
      name: "Surface 0",
      order: 22,
      hex: "#ccd0da",
      rgb: rgb(204, 208, 218),
      accent: false,
    ),
    base: (
      name: "Base",
      order: 23,
      hex: "#eff1f5",
      rgb: rgb(239, 241, 245),
      accent: false,
    ),
    mantle: (
      name: "Mantle",
      order: 24,
      hex: "#e6e9ef",
      rgb: rgb(230, 233, 239),
      accent: false,
    ),
    crust: (
      name: "Crust",
      order: 25,
      hex: "#dce0e8",
      rgb: rgb(220, 224, 232),
      accent: false,
    ),
  ),
)
