#import "/src/lib.typ": catppuccin, themes, get-palette

#set page(width: auto, height: auto)

#let color-swatches(palette) = {
  let swatches = ()
  for (_, color) in palette.colors {
    let swatch = stack(
      dir: ltr,
      spacing: 4pt,
      rect(fill: color.rgb, width: 15pt, height: 7pt),
      [#color.name (#color.hex)],
    )

    swatches.push(swatch)
  }

  [= #palette.name #palette.emoji]
  grid(
    columns: 4,
    column-gutter: 1cm,
    row-gutter: 1em,
    ..swatches,
  )
}

#for theme in themes.values() [
  #pagebreak(weak: true)
  #show: catppuccin.with(theme)

  #let palette = get-palette(theme)
  #color-swatches(palette)
]

