#import "../catppuccin.typ": themes, get_palette
#import "styles.typ" as styles
#import "@preview/tidy:0.3.0"

#let show-module(docs, theme: themes.mocha, ..args) = {
  let palette = get_palette(theme)
  let tidy_colors = styles.get_tidy_colors(theme: theme)
  tidy.show-module(
    docs,
    colors: tidy_colors,
    style: styles,
    ..args,
  )
}
