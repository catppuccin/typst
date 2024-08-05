#import "../catppuccin.typ": themes, get_palette

#import "@preview/tidy:0.3.0"

#let get_tidy_colors(theme: themes.mocha) = {
  let palette = get_palette(theme)

  let function-name-color = palette.colors.blue.rgb
  let rainbow-map = (
    (palette.colors.sky.rgb, 0%),
    (palette.colors.green.rgb, 33%),
    (palette.colors.yellow.rgb, 66%),
    (palette.colors.red.rgb, 100%),
  )

  let gradient-for-color-types = gradient.linear(angle: 7deg, ..rainbow-map)
  let default-type-color = palette.colors.overlay2.rgb

  let colors = (
    "default": default-type-color,
    "content": palette.colors.teal.rgb,
    "string": palette.colors.green.rgb,
    "str": palette.colors.green.rgb,
    "none": palette.colors.flamingo.rgb,
    "auto": palette.colors.flamingo.rgb,
    "boolean": palette.colors.yellow.rgb,
    "integer": palette.colors.mauve.rgb,
    "int": palette.colors.mauve.rgb,
    "float": palette.colors.mauve.rgb,
    "ratio": palette.colors.mauve.rgb,
    "length": palette.colors.mauve.rgb,
    "angle": palette.colors.mauve.rgb,
    "relative length": palette.colors.mauve.rgb,
    "relative": palette.colors.mauve.rgb,
    "fraction": palette.colors.mauve.rgb,
    "symbol": default-type-color,
    "array": default-type-color,
    "dictionary": default-type-color,
    "arguments": default-type-color,
    "selector": default-type-color,
    "module": default-type-color,
    "stroke": default-type-color,
    "function": palette.colors.rosewater.rgb,
    "color": gradient-for-color-types,
    "gradient": gradient-for-color-types,
    "signature-func-name": palette.colors.blue.rgb,
  )

  colors
}

// Move this somewhere else
#let show-module(docs, theme: themes.mocha) = {
  let palette = get_palette(theme)
  let tidy_colors = get_tidy_colors(theme: theme)
  tidy.show-module(docs, colors: tidy_colors)
}