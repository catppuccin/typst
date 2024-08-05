#import "../src/catppuccin.typ": themes, get_palette
#import "../src/tidy/styles.typ": get_tidy_colors, show-module
#import "template.typ": *
#import "@preview/tidy:0.3.0"

#let version = toml("../typst.toml").package.version

#let theme = sys.inputs.at("flavor", default: themes.mocha)
#let palette = get_palette(theme)

#show: project.with(
  title: "Catppuccin for Typst",
  subtitle: "🪶 Soothing pastel theme for Typst",
  authors: ("TimeTravelPenguin",),
  abstract: [
    *catppuccin* is a package that provides colourful #link("https://catppuccin.com/", [Catppuccin]) asthetics
    for #link("https://typst.app/", [Typst]) documents. It provides four soothing
    pastel themes that is easy on the eyes. This manual provides a detailed
    documentation of the package.

    #v(1cm)

    #underline[*THIS MANUAL IS CURRENTLY A WORK IN PROGRESS.*]
  ],
  date: datetime.today().display("[month repr:long] [day], [year]"),
  version: version,
  url: "https://github.com/TimeTravelPenguin/typst",
  flavor: theme,
)

= Intro
== Overview
=== Featuresd

#pad(x: 10%, outline(depth: 1))
#pagebreak()

#let docs = tidy.parse-module(read("../src/catppuccin.typ"), name: "Catppuccin")

#show-module(docs, theme: theme)