#import "../catppuccin.typ": themes, get-palette
#import "styles.typ" as styles
#import "@preview/tidy:0.3.0"

#let show-module(docs, theme: themes.mocha, ..args) = {
  let palette = get-palette(theme)
  let tidy-colors = styles.get-tidy-colors(theme: theme)
  tidy.show-module(
    docs,
    colors: tidy-colors,
    style: styles,
    ..args,
  )
}
