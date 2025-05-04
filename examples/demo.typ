#import "/src/lib.typ": catppuccin, flavors, get-flavor
#import "@preview/cetz:0.3.4": canvas
#import "@preview/cetz-plot:0.1.1": plot

#let flavor = sys.inputs.at("flavor", default: flavors.mocha.identifier)
#let palette = get-flavor(flavor)

#set document(
  title: "Catppuccin",
  author: "TimeTravelPenguin",
  keywords: "theme, typst, catppuccin",
  date: datetime.today(),
)

#set page(height: auto)

#set text(font: "Nunito", size: 0.9em)
#show: catppuccin.with(flavor)

#align(center, heading(text(size: 2em, font: "Jellee", "Catppuccin")))
#align(center, text(
  palette.emoji + " Soothing pastel theme for Typst",
  size: 1.4em,
))

#let accents = palette.colors.pairs().filter(pair => pair.at(1).accent)
#let bases = palette.colors.pairs().filter(pair => not pair.at(1).accent)

#let color-swatches(pairs) = pairs.map(pair => {
  stack(
    dir: ltr,
    spacing: 4pt,
    rect(fill: pair.at(1).rgb, stroke: 0.5pt + white, width: 15pt, height: 7pt),
    text(pair.at(1).name),
  )
})

#let TeX = context {
  set text(font: "Libertinus Serif")
  let e = measure(text(1em, "E"))
  let T = "T"
  let E = text(1em, baseline: e.height / 4, "E")
  let X = "X"
  box(T + h(-0.1em) + E + h(-0.125em) + X)
}

#let LaTeX = context {
  set text(font: "Libertinus Serif")
  let l = measure(text(1em, "L"))
  let a = measure(text(0.7em, "A"))
  let L = "L"
  let A = text(0.7em, baseline: a.height - l.height, "A")
  box(L + h(-0.3em) + A + h(-0.1em) + TeX)
}


Typst makes it very easy to customise the look of your documents. Inspiration
for this project came from Catppuccin for #LaTeX [#link("https://github.com/catppuccin/latex")[#text(fill: palette.colors.blue.rgb, "link")]]. This doument is currently
using the flavor #text(fill: palette.colors.mauve.rgb, style: "italic", flavor).

=== Accents
#align(center, grid(columns: 7, align: left, gutter: 1em, ..color-swatches(
    accents,
  )))

=== Base Colors
#align(center, grid(columns: 6, align: left, gutter: 1em, ..color-swatches(
    bases,
  )))

// === Code Blocks
// Unlike #LaTeX, Typst make code highlighting a breeze! The following is a code
// demo show how to use this package by using ```typ #show``` in Typst:
//
// #text(size: 8pt)[
//   ```typ
//   #import "catppuccin": catppuccin, flavors, get-flavor
//   #show: catppuccin.with(flavor: flavors.mocha, code-block: true)
//
//   #let palette = get-flavor(flavor)
//   #let mauve = palette.colors.mauve.rgb
//
//   = Catppuccin
//   🪶 Soothing pastel theme for #text(fill: mauve, Typst)
//   ```
// ]

=== Plotting (via CeTZ)

Plots and other figures can be made to look even better when using the current
flavor's palette!

#let plot-str = "#let styles = (
  palette.colors.red.rgb,
  palette.colors.green.rgb,
  palette.colors.blue.rgb,
).map(c => (
  stroke: palette.colors.crust.rgb,
  fill: c.transparentize(25%),
))

#canvas(length: 8mm, {
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
})"

#let scope = (palette: palette, canvas: canvas, plot: plot)
#let plot = eval(scope: scope, "[" + plot-str + "]")
#align(center, grid(
  columns: 2,
  column-gutter: 2em,
  text(size: 7.5pt, raw(lang: "typ", block: true, plot-str)),
  [#v(1fr) #plot #v(1fr)],
))
