#import "/src/lib.typ": catppuccin, flavors, get-flavor

#let project(
  title: "",
  subtitle: "",
  abstract: [],
  authors: (),
  url: none,
  date: none,
  version: none,
  flavor: flavors.mocha,
  body,
) = {
  let palette = get-flavor(flavor)

  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Nunito", hyphenate: false, lang: "en", fallback: true)

  show: catppuccin.with(flavor)

  show heading.where(level: 1): set text(font: "Jellee")
  show heading.where(level: 2): set text(font: "Jellee")
  show heading.where(level: 1): it => block(smallcaps(it), below: 1em)
  set heading(numbering: (..args) => if args.pos().len() <= 3 {
    numbering("1.1.", ..args)
  })

  show figure.caption: set text(size: 0.8em, fill: palette.colors.subtext0.rgb)

  show list: pad.with(x: 5%)

  let ctp-blue = palette.colors.blue.rgb
  show link: set text(fill: ctp-blue)
  // show link: it => if type(it.element) != ref {
  //   underline
  // }

  // show ref: it => {
  // set text(fill: ctp-blue)
  // underline[#it]
  // }

  v(1fr)

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title, font: "Jellee"))
    #block(text(1.0em, subtitle))

    #v(1em, weak: true)
    #let logo = sys.inputs.at("logo")
    #image(logo, width: 4cm)
    #v(1em, weak: true)

    v#version #h(1.2cm) #date
    #block(link(url))
    #v(1.5em, weak: true)
  ]

  // Author information.
  pad(top: 0.5em, x: 2em, grid(
    columns: (1fr,) * calc.min(3, authors.len()),
    gutter: 1em,
    ..authors.map(author => align(center, strong(author))),
  ))

  v(1fr, weak: true)

  // Abstract.
  pad(
    x: 3.8em,
    top: 1em,
    bottom: 1.1em,
    align(center)[
      #heading(outlined: false, numbering: none, text(
        0.85em,
        smallcaps[Abstract],
      ))
      #abstract
    ],
  )

  // Main body.
  set par(justify: true)

  v(1fr)
  pad(x: 10%, outline(depth: 2, indent: auto))
  v(1fr)
  pagebreak()

  body
}

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

#let to-title(string) = {
  assert(string.len() > 0, message: "String is empty")
  if string.len() == 1 {
    return upper(string.at(0))
  }

  return upper(string.at(0)) + string.slice(1)
}

#let make-namespace(name: none, scope: (:), ..modules) = {
  assert.ne(name, none, message: "Namespace name is required")
  assert.ne(modules, (), message: "At least one module is required")

  let contents = ()

  for module in modules.pos() {
    let mod = read("../src/" + module)
    assert.ne(mod, none, message: "Module not found: " + repr(module))
    contents.push(mod.trim())
  }

  let contents = contents.join("")
  return (
    name: name,
    scope: scope,
    contents: contents,
  )
}
