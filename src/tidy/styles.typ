#import "../catppuccin.typ": themes, get_palette
#import "../utils.typ": dict-at

#import "@preview/tidy:0.3.0"
#import "@preview/tidy:0.3.0": utilities

/// A style thst can be used to generate documentation using #link("https://typst.app/universe/package/tidy")[Tidy] for the Catppuccino theme. The returned dictionary is a tidy styles dictionary with some additional keys, most importantly `ctp_palette` whose value is the associated #show-type("flavor").
///
/// - theme (string): The name of the theme to use.
/// -> dictionary
#let get_tidy_colors(theme: themes.mocha) = {
  let palette = get_palette(theme)

  let function-name-color = palette.colors.blue.rgb
  let rainbow-map = (
    (palette.colors.sky.rgb, 0%),
    (palette.colors.green.rgb, 33%),
    (palette.colors.yellow.rgb, 66%),
    (palette.colors.red.rgb, 100%),
  )

  let gradient-for-color-types = gradient.linear(angle: 7deg, ..rainbow-map)
  let default-type-color = palette.colors.overlay2.rgb

  let colors = (
    "ctp_palette": palette,
    "flavor": palette.colors.pink.rgb,
    "default": default-type-color,
    "content": palette.colors.teal.rgb,
    "string": palette.colors.green.rgb,
    "str": palette.colors.green.rgb,
    "none": palette.colors.mauve.rgb,
    "auto": palette.colors.mauve.rgb,
    "boolean": palette.colors.yellow.rgb,
    "integer": palette.colors.peach.rgb,
    "int": palette.colors.peach.rgb,
    "float": palette.colors.peach.rgb,
    "ratio": palette.colors.peach.rgb,
    "length": palette.colors.peach.rgb,
    "angle": palette.colors.peach.rgb,
    "relative length": palette.colors.peach.rgb,
    "relative": palette.colors.peach.rgb,
    "fraction": palette.colors.peach.rgb,
    "symbol": palette.colors.red.rgb,
    "array": palette.colors.yellow.rgb,
    "dictionary": palette.colors.yellow.rgb,
    "arguments": palette.colors.maroon.rgb,
    "selector": palette.colors.red.rgb,
    "module": palette.colors.yellow.rgb,
    "stroke": default-type-color,
    "function": palette.colors.blue.rgb,
    "color": gradient-for-color-types,
    "gradient": gradient-for-color-types,
    "signature-func-name": palette.colors.blue.rgb,
  )

  colors
}

#let show-outline(module-doc, style-args: (:)) = {
  let prefix = module-doc.label-prefix
  let gen-entry(name) = {
    if "enable-cross-references" in style-args and style-args.enable-cross-references {
      link(label(prefix + name), name)
    } else {
      name
    }
  }
  if module-doc.functions.len() > 0 {
    list(..module-doc.functions.map(fn => gen-entry(fn.name + "()")))
  }

  if module-doc.variables.len() > 0 {
    text([Variables:], weight: "bold")
    list(..module-doc.variables.map(var => gen-entry(var.name)))
  }
}

#let show-type(type, style-args: (:)) = {
  h(2pt)
  let clr = style-args.colors.at(type, default: style-args.colors.at("default"))
  let text_fill = dict-at(style-args.colors, "ctp_palette", "colors", "base", "rgb")
  box(outset: 2pt, fill: clr, radius: 2pt, text(fill: text_fill, raw(type, lang: none)))
  h(2pt)
}

#let show-parameter-list(fn, style-args: (:)) = {
  pad(
    x: 10pt,
    {
      set text(font: ("DejaVu Sans Mono"), size: 0.85em, weight: 340)
      text(fn.name, fill: style-args.colors.at("signature-func-name"))
      "("
      let inline-args = fn.args.len() < 2
      if not inline-args {
        "\n  "
      }
      let items = ()
      let args = fn.args
      for (arg-name, info) in fn.args {
        if style-args.omit-private-parameters and arg-name.starts-with("_") {
          continue
        }
        let types
        if "types" in info {
          types = ": " + info.types.map(x => show-type(x, style-args: style-args)).join(" ")
        }
        items.push(arg-name + types)
      }
      items.join(if inline-args {
        ", "
      } else {
        ",\n  "
      })
      if not inline-args {
        "\n"
      } + ")"
      if fn.return-types != none {
        " -> "
        fn.return-types.map(x => show-type(x, style-args: style-args)).join(" ")
      }
    },
  )
}



// Create a parameter description block, containing name, type, description and optionally the default value.
#let show-parameter-block(
  name,
  types,
  content,
  style-args,
  show-default: false,
  default: none,
) = block(
  inset: 10pt,
  radius: 3pt,
  fill: style-args.colors.ctp_palette.colors.mantle.rgb,
  width: 100%,
  breakable: style-args.break-param-descriptions,
  [
    #box(heading(level: style-args.first-heading-level + 3, name))
    #h(1.2em)
    #types.map(x => (style-args.style.show-type)(x, style-args: style-args)).join([ #text("or", size: .6em) ])

    #content
    #if show-default [ #parbreak() #style-args.local-names.default: #raw(lang: "typc", default) ]
  ],
)


#let show-function(
  fn,
  style-args,
) = {

  if style-args.colors == auto {
    style-args.colors = colors
  }

  if style-args.enable-cross-references [
    #heading(fn.name, level: style-args.first-heading-level + 1)
    #label(style-args.label-prefix + fn.name + "()")
  ] else [
    #heading(fn.name, level: style-args.first-heading-level + 1)
  ]

  utilities.eval-docstring(fn.description, style-args)

  block(
    breakable: style-args.break-param-descriptions,
    {
      heading(style-args.local-names.parameters, level: style-args.first-heading-level + 2)
      (style-args.style.show-parameter-list)(fn, style-args: style-args)
    },
  )

  for (name, info) in fn.args {
    if style-args.omit-private-parameters and name.starts-with("_") {
      continue
    }
    let types = info.at("types", default: ())
    let description = info.at("description", default: "")
    if description == "" and style-args.omit-empty-param-descriptions {
      continue
    }
    (style-args.style.show-parameter-block)(
      name,
      types,
      utilities.eval-docstring(description, style-args),
      style-args,
      show-default: "default" in info,
      default: info.at("default", default: none),
    )
  }
  v(4.8em, weak: true)
}

#let show-variable(
  var,
  style-args,
) = {
  if style-args.colors == auto {
    style-args.colors = colors
  }
  let type = if "type" not in var {
    none
  } else {
    show-type(var.type, style-args: style-args)
  }

  stack(
    dir: ltr,
    spacing: 1.2em,
    if style-args.enable-cross-references [
      #heading(var.name, level: style-args.first-heading-level + 1)
      #label(style-args.label-prefix + var.name)
    ] else [
      #heading(var.name, level: style-args.first-heading-level + 1)
    ],
    type,
  )

  utilities.eval-docstring(var.description, style-args)
  v(4.8em, weak: true)
}

#let show-reference(label, name, style-args: none) = {
  link(label, raw(name, lang: none))
}

// This function is temporarily used until the resolution of:
//    https://github.com/Mc-Zen/tidy/issues/27
#let temp-tidy-show-example(
  code,
  dir: ltr,
  scope: (:),
  preamble: "",
  ratio: 1,
  scale-preview: auto,
  mode: "code",
  inherited-scope: (:),
  code-block: block,
  preview-block: block,
  col-spacing: 5pt,
  ..options,
) = {
  set raw(block: true)
  let lang = if code.has("lang") {
    code.lang
  } else {
    "typc"
  }
  if lang == "typ" {
    mode = "markup"
  }
  if mode == "markup" and not code.has("lang") {
    lang = "typ"
  }
  set raw(lang: lang)
  if code.has("block") and code.block == false {
    code = raw(code.text, lang: lang, block: true)
  }

  let preview = [#eval(preamble + code.text, mode: mode, scope: scope + inherited-scope)]

  let preview-outer-padding = 5pt
  let preview-inner-padding = 5pt

  layout(size => style(styles => {
    let code-width
    let preview-width

    if dir.axis() == "vertical" {
      code-width = size.width
      preview-width = size.width
    } else {
      code-width = ratio / (ratio + 1) * size.width - 0.5 * col-spacing
      preview-width = size.width - code-width - col-spacing
    }

    let available-preview-width = preview-width - 2 * (preview-outer-padding + preview-inner-padding)

    let preview-size
    let scale-preview = scale-preview

    if scale-preview == auto {
      preview-size = measure(preview, styles)
      assert(
        preview-size.width != 0pt,
        message: "The code example has a relative width. Please set `scale-preview` to a fixed ratio, e.g., `100%`",
      )
      scale-preview = calc.min(1, available-preview-width / preview-size.width) * 100%
    } else {
      preview-size = measure(block(preview, width: available-preview-width / (scale-preview / 100%)), styles)
    }

    set par(hanging-indent: 0pt) // this messes up some stuff in case someone sets it

    // We first measure this thing (code + preview) to find out which of the two has
    // the larger height. Then we can just set the height for both boxes.
    let arrangement(
      width: 100%,
      height: auto,
    ) = block(
      width: width,
      inset: 0pt,
      outset: 0pt,
      stack(
        dir: dir,
        spacing: col-spacing,
        code-block(
          width: code-width,
          height: height,
          inset: 5pt,
          {
            // set text(size: .9em)
            align(left, code)
          },
        ),
        preview-block(
          height: height,
          width: preview-width,
          inset: preview-outer-padding,
          box(
            width: 100%,
            height: if height == auto {
              auto
            } else {
              height - 2 * preview-outer-padding
            },
            // fill: white,
            inset: preview-inner-padding,
            box(
              inset: 0pt,
              width: preview-size.width * (scale-preview / 100%),
              height: preview-size.height * (scale-preview / 100%),
              place(
                scale(
                  scale-preview,
                  origin: top + left,
                  block(preview, height: preview-size.height, width: preview-size.width),
                ),
              ),
            )),
        ),
      ),
    )
    let height = if dir.axis() == "vertical" {
      auto
    } else {
      measure(arrangement(width: size.width), styles).height
    }
    arrangement(height: height)
  }))
}

#let show-example(
  ..args,
) = {
  // tidy
  //   .show-example
  //   .show-example(
  //   ..args,
  //   // code-block: block.with(radius: 3pt, stroke: .5pt + luma(200)),
  //   preview-block: block.with(radius: 3pt, fill: none),
  //   col-spacing: 5pt,
  // )
  temp-tidy-show-example(
    ..args,
    col-spacing: 2cm,
  )
}
