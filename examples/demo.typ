#import "../src/lib.typ": catppuccin, themes, get_palette, get_palette
#import "@preview/cetz:0.2.2": canvas, plot

#let theme = sys.inputs.at("flavor", default: themes.mocha)
#let palette = get_palette(theme)

#set document(
  title: "Catppuccin",
  author: "TimeTravelPenguin",
  keywords: "theme, typst, catppuccin",
  date: datetime.today(),
)

#show: catppuccin.with(theme: theme, code_block: true)

#align(center, heading(text(size: 2em, font: "Jellee Roman", "Catppuccin")))
#align(
  center,
  text(palette.emoji + " Soothing pastel theme for Typst", size: 1.4em),
)

#let accents = palette.colors.pairs().filter(pair => pair.at(1).accent)
#let bases = palette.colors.pairs().filter(pair => not pair.at(1).accent)

#let color_swatches(pairs) = pairs.map(
  pair => {
    stack(
      dir: ltr,
      spacing: 4pt,
      rect(fill: pair.at(1).rgb, stroke: 0.5pt + white, width: 15pt, height: 7pt),
      text(pair.at(1).name),
    )
  },
)

#let TeX = style(styles => {
  let e = measure(text(1em, "E"), styles)
  let T = "T"
  let E = text(1em, baseline: e.height / 4, "E")
  let X = "X"
  box(T + h(-0.1em) + E + h(-0.125em) + X)
})

#let LaTeX = style(styles => {
  let l = measure(text(1em, "L"), styles)
  let a = measure(text(0.7em, "A"), styles)
  let L = "L"
  let A = text(0.7em, baseline: a.height - l.height, "A")
  box(L + h(-0.3em) + A + h(-0.1em) + TeX)
})

Typst makes it very easy to customise the look of your documents. Inspiration
for this project came from Catppuccin for #LaTeX [#link(
  "https://github.com/catppuccin/latex",
)[#text(fill: palette.colors.blue.rgb, "link")]].

This doument uses the flavor #text(fill: palette.colors.mauve.rgb, style: "italic", theme).

=== Accents
#align(
  center,
  grid(columns: 7, align: left, gutter: 1em, ..color_swatches(accents)),
)

=== Base Colors
#align(
  center,
  grid(columns: 6, align: left, gutter: 1em, ..color_swatches(bases)),
)

=== Code Blocks
Unlike #LaTeX, Typst make code highlighting a breeze! The following is a demo of
using ```typ #let``` in Typst:

```typ
#import "catppuccin": catppuccin, themes

#show: catppuccin.with(theme: themes.mocha)

= Catppuccin
✨ Soothing pastel theme for Typst
```

=== Plotting (via CeTZ)

Plots and other figures can be made to look even better when using the current
flavor's palette!

#let styles = (
  palette.colors.red.rgb,
  palette.colors.green.rgb,
  palette.colors.blue.rgb,
).map(c =>
(stroke: palette.colors.crust.rgb, fill: c.transparentize(25%)))

#align(center, {
  canvas(length: 1cm, {
    plot.plot(
      size: (8, 6),
      x-tick-step: none,
      x-ticks: ((-calc.pi, $-pi$), (0, $0$), (calc.pi, $pi$)),
      y-tick-step: 1,
      {
        plot.add(
          hypograph: true,
          style: styles.at(0),
          domain: (-calc.pi, calc.pi),
          calc.sin,
        )
        plot.add(
          hypograph: true,
          style: styles.at(1),
          domain: (-calc.pi, calc.pi),
          x => calc.cos(x - calc.pi) + calc.sin(2 * x),
        )
        plot.add(
          hypograph: true,
          style: styles.at(2),
          domain: (-calc.pi, calc.pi),
          x => calc.cos(x + calc.pi) + calc.sin(x / 2),
        )
      },
    )
  })
})

This demo plots several functions using the current flavor's palette. These
functions are:
#align(center, grid(
  columns: 3,
  column-gutter: 1.5cm,
  $sin(x)$,
  $cos(x - pi) + sin(2x)$,
  $cos(x + pi) + sin(x / 2)$,
))