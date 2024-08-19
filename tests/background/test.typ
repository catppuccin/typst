#import "/src/lib.typ": catppuccin, themes, get-palette

#set page(width: auto, height: auto)

#let perms = ()
#for theme in themes.values() {
  for code-block in (true, false) {
    for syntax in (true, false) {
      perms.push((theme: theme, code-block: code-block, syntax: syntax))
    }
  }
}

#for p in perms [
  #pagebreak(weak: true)
  #show: catppuccin.with(p.theme, code-block: p.code-block, code-syntax: p.syntax)

  = #get-palette(p.theme).name
  - Code block: #p.code-block
  - Code syntax: #p.syntax

  ```typ
  #import "/src/lib.typ": catppuccin, themes, get-palette

  #let perms = ()
  #for theme in themes.values() {
    for code-block in (true, false) {
      for syntax in (true, false) {
        perms.push((theme: theme, code-block: code-block, syntax: syntax))
      }
    }
  }

  #for p in perms [
    #show: catppuccin.with(p.theme, code-block: p.code-block, code-syntax: p.syntax)
    = #get-palette(p.theme).name
    == Code block: #p.code-block
    == Code syntax: #p.syntax
  ]
  ```
]
