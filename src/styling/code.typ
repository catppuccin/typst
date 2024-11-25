#import "../flavors.typ": get-flavor, flavors
#import "../valkyrie/typst-schema.typ": *
#import "@preview/valkyrie:0.2.1" as z


#let code-block-config-schema = z.dictionary((
  inset: inset-schema(default: 7pt),
  outset: outset-schema(default: (y: 3pt)),
  radius: radius-schema(default: 3pt),
  breakable: z.boolean(default: false),
  width: z.either(
    rel-or-length(),
    z.function(),
    sides-schema,
    post-transform: (self, it) => if type(it) == dictionary and it == (:) {
      0pt
    } else {
      it
    },
    default: it => measure(it).width + 1cm,
  ),
))

#let code-box-config-schema = z.dictionary((
  inset: inset-schema(default: (x: 2pt, y: 0pt)),
  outset: outset-schema(default: (y: 2pt)),
  radius: radius-schema(default: 3pt),
))

#let config-code-blocks(flavor, code-block: true, code-syntax: true, block-config: (:), inline-config: (:), body) = [
  #let palette = if type(flavor) == str {
    get-flavor(flavor)
  } else {
    assert(flavor in flavors.values(), message: "Invalid flavor: " + repr(flavor))
    flavor
  }

  #let tmTheme = "/tmThemes/" + flavor + ".tmTheme"
  #set raw(theme: tmTheme) if code-syntax

  #show raw.where(block: false): it => [
    #let config = z.parse(inline-config, code-box-config-schema)
    #box(..config, it)
  ]

  #show raw.where(block: true): it => (
    context [
      #let config = z.parse(block-config, code-block-config-schema) + (fill: palette.colors.crust.rgb)

      #if type(config.at("width")) == function {
        config.insert("width", (config.at("width"))(it))
      }

      #set align(center)
      #block(..config, it)
    ]
  )

  #body
]
