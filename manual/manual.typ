#import "/src/lib.typ": catppuccin, flavors, get-flavor, version
#import "/src/tidy/styles.typ" as styles: ctp-tidy-style, show-type
#import "/src/tidy/show-module.typ": show-module
#import "template.typ": *

#import "@preview/tidy:0.4.3" as tidy: render-examples, show-example as example
#import "@preview/oxifmt:1.0.0": strfmt

#let flavor = sys.inputs.at("flavor", default: flavors.mocha)
#let palette = get-flavor(flavor)

#let show-type(type) = styles.show-type(type, style-args: ctp-tidy-style(
  flavor: flavor,
))

#show: project.with(
  title: "Catppuccin for Typst",
  subtitle: "🪶 Soothing pastel theme for Typst",
  authors: ("TimeTravelPenguin",),
  abstract: [
    The *catppuccin* package provides colourful #link(
      "https://catppuccin.com/",
      [Catppuccin],
    ) aesthetics for #link("https://typst.app/", [Typst]) documents.
    It provides four soothing pastel themes that is easy on the eyes.
    This manual provides a detailed documentation of the package.
  ],
  date: datetime.today().display("[month repr:long] [day], [year]"),
  version: version,
  url: "https://github.com/catppuccin/typst",
  flavor: flavor,
)

= Overview
== About

This document provides a detailed documentation of the *catppuccin* package for
Typst. Inspired by the #LaTeX
#link("https://github.com/catppuccin/latex")[Catppuccin package], this package
hopes to make writing in Typst more pleasurable and easy to use.

As someone who has done a lot of #LaTeX, I found myself spending a lot of time
writing in dark themes (usually by inverting the document colors). Eventually I
found the Catppuccin package for #LaTeX, and I incorporated it into my custom
preable to allow me to enable, disable, or configure the enabled theme. When I
finished, I would submit my work with the theme disabled, without explicitly
removing code!

== Basic Usage

Using this package is simple. The following is an example of how to use the
package.

```typ
#import "catppuccin.typ": catppuccin, flavors

#show: catppuccin.with(flavor: flavors.mocha)

// The rest of your document
```

You can disable the theme by commenting out or deleting the show block.
#pagebreak()

#let show-mod(
  namespace,
  show-module-name: true,
  preamble: "",
  style-alt: (:),
) = {
  let doc = tidy.parse-module(
    namespace.contents,
    name: namespace.name,
    scope: namespace.scope,
    preamble: preamble,
  )

  show-module(
    doc,
    flavor: flavor,
    show-module-name: show-module-name,
    style-alt: style-alt,
  )
}

#pagebreak(weak: true)
= Modules

#show-mod(make-namespace(
  name: "Catppuccin",
  scope: (
    "flavors": flavors,
    "get-flavor": get-flavor,
    "show-type": show-type,
  ),
  "catppuccin.typ",
))

#pagebreak(weak: true)
= Flavor Schema <flavor-schema>

The Catppuccin package comes with four flavors: *Latte*, *Frappe*, *Macchiato*,
and *Mocha*. Each flavor has its own unique color palette that is easy on the
eyes. You can choose a flavor by setting the `flavor` parameter in the
```typ catppuccin.with``` function.

In this package, we refer to the dictionary related to each flavor with the type
alias #show-type("flavor").

Here we describe the schema for the #show-type("flavor") dictionary. Use
```typc get-flavor()``` function to get the dictionary for a specific flavor.

- *name* #show-type("string") --- The name of the flavor (e.g. Frappé)
- *identifier* #show-type("string") --- The identifier of the flavor (e.g.
  frappe)
- *emoji* #show-type("string") --- The emoji associated with the flavor.
- *order* #show-type("integer") --- The order of the flavor in the Catppuccin
  lineup.
- *dark* #show-type("boolean") --- Whether the flavor is a dark theme.
- *light* #show-type("boolean") --- Whether the flavor is a light theme.
- *colors* #show-type("dictionary") --- A dictionary of colors used in the
  flavor. Keys are the color names as a #show-type("string") and values are
  dictionaries with the following keys:
  - *name* #show-type("string") --- The name of the color.
  - *order* #show-type("integer") --- The order of the color in the palette.
  - *hex* #show-type("string") --- The hex value of the color.
  - *rgb* #show-type("string") --- The RGB value of the color.
  - *accent* #show-type("boolean") --- Whether the color is an accent color.

#show-mod(
  make-namespace(
    name: "Flavors",
    scope: (
      "flavors": flavors,
      "get-flavor": get-flavor,
    ),
    "flavors.typ",
  ),
  style-alt: (
    show-example: example.show-example.with(layout: (code, preview) => grid(
      columns: 2,
      column-gutter: 1cm,
      code, preview,
    )),
  ),
)

#show-mod(
  make-namespace(
    name: "Flavors",
    scope: (
      "flavors": flavors,
      "get-flavor": get-flavor,
    ),
    "flavors/catppuccin-frappe.typ",
    "flavors/catppuccin-latte.typ",
    "flavors/catppuccin-macchiato.typ",
    "flavors/catppuccin-mocha.typ",
  ),
  show-module-name: false,
  style-alt: (show-example: styles.show-example.with(ratio: 1.5)),
)

#pagebreak(weak: true)
= Miscellaneous
#show-mod(make-namespace(name: "Version", "version.typ", scope: (
  "version": version,
)))
