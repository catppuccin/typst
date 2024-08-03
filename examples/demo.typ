#import "../src/lib.typ": catppuccin, themes, get_palette, get_palette

#let theme = themes.mocha
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