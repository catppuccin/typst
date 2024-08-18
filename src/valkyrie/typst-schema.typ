#import "@preview/valkyrie:0.2.1" as z

#let rel-or-length(..args) = z.either(z.relative(), z.length(), ..args)

#let sides-schema = z.dictionary(
  (
    left: rel-or-length(optional: true),
    right: rel-or-length(optional: true),
    top: rel-or-length(optional: true),
    bottom: rel-or-length(optional: true),
    x: rel-or-length(optional: true),
    y: rel-or-length(optional: true),
    rest: rel-or-length(optional: true),
  ),
  pre-transform: (ctx, it) => if type(it) != dictionary {
    (rest: it)
  } else {
    it
  },
  post-transform: (ctx, it) => it.pairs().fold(
    (:),
    (acc, (k, v)) => (
      acc + if v != none {
        ((k): v)
      }
    ),
  ),
)

#let inset-schema(optional: false, default: (:)) = z.either(
  rel-or-length(),
  sides-schema,
  default: default,
  optional: optional,
)

#let outset-schema(optional: false, default: (:)) = inset-schema(optional: optional, default: default)

#let radius-schema(optional: false, default: (:)) = inset-schema(optional: optional, default: default)
