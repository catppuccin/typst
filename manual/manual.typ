#import "/src/lib.typ": catppuccin, flavors, get-flavor, version
#import "/src/styling/code.typ": config-code-blocks
#import "/src/tidy/styles.typ": get-tidy-colors, show-type as sh-type
#import "/src/tidy/show-module.typ": show-module
#import "template.typ": *
#import "@preview/tidy:0.3.0"
#import "@preview/oxifmt:0.2.1": strfmt

#let flavor = sys.inputs.at("flavor", default: flavors.mocha)
#let palette = get-flavor(flavor)

#let show-type(type) = {
  let style = (colors: get-tidy-colors(flavor: flavor))
  sh-type(type, style-args: style)
}

#show: project.with(
  title: "Catppuccin for Typst",
  subtitle: "🪶 Soothing pastel theme for Typst",
  authors: ("TimeTravelPenguin",),
  abstract: [
    The *catppuccin* package provides colourful #link("https://catppuccin.com/", [Catppuccin]) aesthetics
    for #link("https://typst.app/", [Typst]) documents. It provides four soothing
    pastel themes that is easy on the eyes. This manual provides a detailed
    documentation of the package.
  ],
  date: datetime.today().display("[month repr:long] [day], [year]"),
  version: version,
  url: "https://github.com/catppuccin/typst",
  flavor: flavor,
)

= Overview
== About

This document provides a detailed documentation of the *catppuccin* package for Typst. Inspired by the #LaTeX #link("https://github.com/catppuccin/latex")[Catppuccin package], this package hopes to make writing in Typst more pleasurable and easy to use.

As someone who has done a lot of #LaTeX, I found myself spending a lot of time writing in dark themes (usually by inverting the document colors). Eventually I found the Catppuccin package for #LaTeX, and I incorporated it into my custom preable to allow me to enable, disable, or configure the enabled theme. When I finished, I would submit my work with the theme disabled, without explicitly removing code!

I have plans for the future of this package, such as added styling and perhaps integration with other packages (if that ever becomes easier to do without making a new package).

== Basic Usage

Using this package is simple. See @usage for an example of how to use the package.

#figure(
  caption: "Example usage of the Catppuccin package",
  ```typ
  #import "catppuccin.typ": catppuccin, flavors

  #show: catppuccin.with(flavor: flavors.mocha)

  // The rest of your document
  ```,
) <usage>

You can disable the theme by commenting out or deleting the show block.
#pagebreak()

#let show-mod(
  namespace,
  show-module-name: true,
) = {
  let doc = tidy.parse-module(
    namespace.contents,
    name: namespace.name,
    scope: namespace.scope //+ ("config-code-blocks": config-code-blocks),
    // preamble: strfmt("#show: config-code-blocks.with(\"{}\")\n", flavor),
  )

  show-module(
    doc,
    flavor: flavor,
    show-module-name: show-module-name,
  )
}

= Modules

#show-mod(
  make-namespace(
    name: "Catppuccin",
    scope: (
      "flavors": flavors,
      "get-flavor": get-flavor,
      "show-type": show-type,
    ),
    "catppuccin.typ",
  ),
)

= Flavors

The Catppuccin package comes with four flavors: *Latte*, *Frappe*, *Macchiato*, and *Mocha*. Each flavor has its own unique color palette that is easy on the eyes. You can choose a flavor by setting the `flavor` parameter in the ```typ catppuccin.with``` function.

In this package, we refer to the dictionary related to each flavor with the type alias #show-type("flavor").

== Flavor Schema
<flavor-schema>

Here we describe the schema for the #show-type("flavor") dictionary. Use ```typc get-flavor()``` function to

- *name* #show-type("string") --- The name of the flavor (e.g. Frappé)
- *identifier* #show-type("string") --- The identifier of the flavor (e.g. frappe)
- *emoji* #show-type("string") --- The emoji associated with the flavor.
- *order* #show-type("integer") --- The order of the flavor in the Catppuccin lineup.
- *dark* #show-type("boolean") --- Whether the flavor is a dark theme.
- *light* #show-type("boolean") --- Whether the flavor is a light theme.
- *colors* #show-type("dictionary") --- A dictionary of colors used in the flavor. Keys are the color names as a #show-type("string") and values are dictionaries with the following keys:
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
  show-module-name: false,
)

= Styling

Please note that this module is still in development and may be subject to change.

Until Typst supports relative paths in libraries, there may not be much change here.
The current implementation and style is not perfect, but if you don't want to style things
manually, this is the best you can get. If you want to style things manually, you can use
the library #link("https://github.com/Dherse/codly","codly") to style code blocks.
In the future, we may eventually use this approach.

#show-mod(
  make-namespace(name: "Code Blocks", "styling/code.typ", scope: ("flavors": flavors, "show-type": show-type)),
)
#show-mod(make-namespace(name: "Tidy Styles", "tidy/styles.typ", scope: ("flavors": flavors, "show-type": show-type)))

= Miscellaneous
#show-mod(make-namespace(name: "Version", "version.typ", scope: ("version": version)))
