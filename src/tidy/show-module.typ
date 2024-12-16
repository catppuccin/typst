#import "../flavors.typ": get-flavor, flavors, get-flavor
#import "styles.typ" as styles
#import "@preview/tidy:0.3.0"

#let show-module(docs, flavor: flavors.mocha, ..args) = {
  let flavor = get-flavor(flavor)
  let tidy-colors = styles.get-tidy-colors(flavor: flavor)

  tidy.show-module(
    docs,
    colors: tidy-colors,
    style: styles,
    ..args,
  )
}
