#set page(width: auto, height: auto)
#import "/src/lib.typ": catppuccin, flavors, get-flavor

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
    row-gutter: 3.5mm,
    ..swatches,
  )
}

#for flavor in flavors.values() {
  pagebreak(weak: true)
  show: catppuccin.with(flavor)
  color-swatches(flavor)
}
