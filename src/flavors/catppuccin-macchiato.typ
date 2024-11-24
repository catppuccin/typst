/// The Macchiato flavor and palette.
///
/// ==== Example
/// #example(
/// ```typ
///   #let flavor = flavors.macchiato
///   #let palette = get-palette(flavor)
///   Selected flavor: #palette.name #palette.emoji
/// ```, ratio: 1.6)
///
/// -> flavor
#let macchiato = (
  name: "Macchiato",
  emoji: "🌺",
  order: 2,
  dark: true,
  light: false,
  colors: (
    rosewater: (
      name: "Rosewater",
      order: 0,
      hex: "#f4dbd6",
      rgb: rgb(244, 219, 214),
      accent: true,
    ),
    flamingo: (
      name: "Flamingo",
      order: 1,
      hex: "#f0c6c6",
      rgb: rgb(240, 198, 198),
      accent: true,
    ),
    pink: (
      name: "Pink",
      order: 2,
      hex: "#f5bde6",
      rgb: rgb(245, 189, 230),
      accent: true,
    ),
    mauve: (
      name: "Mauve",
      order: 3,
      hex: "#c6a0f6",
      rgb: rgb(198, 160, 246),
      accent: true,
    ),
    red: (
      name: "Red",
      order: 4,
      hex: "#ed8796",
      rgb: rgb(237, 135, 150),
      accent: true,
    ),
    maroon: (
      name: "Maroon",
      order: 5,
      hex: "#ee99a0",
      rgb: rgb(238, 153, 160),
      accent: true,
    ),
    peach: (
      name: "Peach",
      order: 6,
      hex: "#f5a97f",
      rgb: rgb(245, 169, 127),
      accent: true,
    ),
    yellow: (
      name: "Yellow",
      order: 7,
      hex: "#eed49f",
      rgb: rgb(238, 212, 159),
      accent: true,
    ),
    green: (
      name: "Green",
      order: 8,
      hex: "#a6da95",
      rgb: rgb(166, 218, 149),
      accent: true,
    ),
    teal: (
      name: "Teal",
      order: 9,
      hex: "#8bd5ca",
      rgb: rgb(139, 213, 202),
      accent: true,
    ),
    sky: (
      name: "Sky",
      order: 10,
      hex: "#91d7e3",
      rgb: rgb(145, 215, 227),
      accent: true,
    ),
    sapphire: (
      name: "Sapphire",
      order: 11,
      hex: "#7dc4e4",
      rgb: rgb(125, 196, 228),
      accent: true,
    ),
    blue: (
      name: "Blue",
      order: 12,
      hex: "#8aadf4",
      rgb: rgb(138, 173, 244),
      accent: true,
    ),
    lavender: (
      name: "Lavender",
      order: 13,
      hex: "#b7bdf8",
      rgb: rgb(183, 189, 248),
      accent: true,
    ),
    text: (
      name: "Text",
      order: 14,
      hex: "#cad3f5",
      rgb: rgb(202, 211, 245),
      accent: false,
    ),
    subtext1: (
      name: "Subtext 1",
      order: 15,
      hex: "#b8c0e0",
      rgb: rgb(184, 192, 224),
      accent: false,
    ),
    subtext0: (
      name: "Subtext 0",
      order: 16,
      hex: "#a5adcb",
      rgb: rgb(165, 173, 203),
      accent: false,
    ),
    overlay2: (
      name: "Overlay 2",
      order: 17,
      hex: "#939ab7",
      rgb: rgb(147, 154, 183),
      accent: false,
    ),
    overlay1: (
      name: "Overlay 1",
      order: 18,
      hex: "#8087a2",
      rgb: rgb(128, 135, 162),
      accent: false,
    ),
    overlay0: (
      name: "Overlay 0",
      order: 19,
      hex: "#6e738d",
      rgb: rgb(110, 115, 141),
      accent: false,
    ),
    surface2: (
      name: "Surface 2",
      order: 20,
      hex: "#5b6078",
      rgb: rgb(91, 96, 120),
      accent: false,
    ),
    surface1: (
      name: "Surface 1",
      order: 21,
      hex: "#494d64",
      rgb: rgb(73, 77, 100),
      accent: false,
    ),
    surface0: (
      name: "Surface 0",
      order: 22,
      hex: "#363a4f",
      rgb: rgb(54, 58, 79),
      accent: false,
    ),
    base: (
      name: "Base",
      order: 23,
      hex: "#24273a",
      rgb: rgb(36, 39, 58),
      accent: false,
    ),
    mantle: (
      name: "Mantle",
      order: 24,
      hex: "#1e2030",
      rgb: rgb(30, 32, 48),
      accent: false,
    ),
    crust: (
      name: "Crust",
      order: 25,
      hex: "#181926",
      rgb: rgb(24, 25, 38),
      accent: false,
    ),
  ),
)
