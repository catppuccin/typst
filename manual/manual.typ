#import "../src/catppuccin.typ": themes, get_palette, config_code_blocks
#import "../src/tidy/styles.typ": get_tidy_colors, show-type as sh_type
#import "../src/tidy/show-module.typ": show-module
#import "template.typ": *
#import "@preview/tidy:0.3.0"
#import "@preview/oxifmt:0.2.1": strfmt

#let version = toml("../typst.toml").package.version

#let theme = sys.inputs.at("flavor", default: themes.mocha)
#let palette = get_palette(theme)

#let show-type(type) = {
  let style = (colors: get_tidy_colors(theme: theme))
  sh_type(type, style-args: style)
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

    #v(1cm)

    #underline[*THIS MANUAL IS CURRENTLY A WORK IN PROGRESS.*]
  ],
  date: datetime.today().display("[month repr:long] [day], [year]"),
  version: version,
  url: "https://github.com/catppuccin/typst",
  flavor: theme,
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
  #import "catppuccin.typ": catppuccin, themes

  #show: catppuccin.with(
    flavor: themes.mocha,
    code_block: true,
    code_syntax: true,
  )

  // The rest of your document
  ```,
) <usage>

You can disable the theme by commenting out or deleting the show block. Just note that if you are manually accessing palettes via the ```typc get-palette(flavor)``` function, you will need to manually account for those changes. It is planned to make this easier in the future be it though a redesign or simple helper functions.

#pagebreak()


#let show-mod(
  namespace,
  show-module-name: true,
) = {
  let doc = tidy.parse-module(
    namespace.contents,
    name: namespace.name,
    scope: namespace.scope + ("config_code_blocks": config_code_blocks),
    preamble: strfmt("#show: config_code_blocks.with(\"{}\")\n", theme),
  )

  show-module(
    doc,
    theme: theme,
    show-module-name: show-module-name,
  )
}

= Modules

#show-mod(
  make_namespace(
    name: "Catppuccin",
    scope: (
      "themes": themes,
      "get_palette": get_palette,
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

Here we describe the schema for the #show-type("flavor") dictionary. Use ```typc get-palette()``` function to

- *name* #show-type("string") --- The name of the flavor (e.g. Frappé)
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
  make_namespace(
    name: "Flavors",
    scope: (
      "themes": themes,
      "get_palette": get_palette,
    ),
    "flavors.typ",
  ),
  show-module-name: false,
)

#show-mod(make_namespace(name: "Tidy Styles", "tidy/styles.typ", scope: ("themes": themes, "show-type": show-type)))
#show-mod(make_namespace(name: "Version", "version.typ", scope: ("version": version)))
