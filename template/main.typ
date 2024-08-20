#import "@preview/catppuccin:0.1.0": catppuccin, themes, get-palette

#let theme = themes.mocha
#show: catppuccin.with(theme)
#let palette = get-palette(theme)
#let colors = palette.colors

#set text(font: "Nunito")
#show heading: it => {
  show: text.with(font: "Jellee")
  it
}

#show link: it => underline(text(fill: colors.blue.rgb, it))

/*
  Everything beyond this point is the document body!
  Delete the text below and start enjoying the soothing pastel colors!
*/

= #palette.emoji Catppuccin

This template comes with #text(fill: colors.mauve.rgb, style: "italic", "two") fonts!
- #text(fill: colors.mauve.rgb, font: "Jellee", "Jellee"), the font we all know an love. Nothing really comes close to spelling Catppuccin quite like #text(font: "Jellee", "Catppuccin") does! \[#link("https://hanken.co/products/jellee", "source")\]
- #text(fill: colors.mauve.rgb, weight: "black", "Nunito"), which is a nice, easy-to-read font. I personally feel that it suites the aesthetic well, while coming across as a perfectly usable font! \[#link("https://fonts.google.com/specimen/Nunito", "source")\]

Make sure that, if you want to use the fonts, you compile the document with `--font-path`:
```bash
$ typst compile --font-path "./fonts" main.typ
```

Enjoy this package! I will leave you with this display of the `palette` schema:

// I am just printing the palette here, showing only the first color to reduce clutter!
#let schema = palette
#schema.insert(
  "colors",
  schema.colors.pairs().fold(
    (:),
    (acc, (k, v)) => (
      acc + if acc == (:) {
        ((k): v)
      } else {
        ((k): ("...",))
      }
    ),
  ),
)

#stack(dir: ltr, align(top + center, ```typc get-palette(theme) =```), box[#schema])
