#import "/src/lib.typ": catppuccin, themes, get_palette

#set page(width: auto, height: auto)

#let perms = ()
#for theme in themes.values() {
  for code_block in (true, false) {
    for syntax in (true, false) {
      perms.push((theme: theme, code_block: code_block, syntax: syntax))
    }
  }
}

#for p in perms [
  #pagebreak(weak: true)
  #show: catppuccin.with(p.theme, code_block: p.code_block, code_syntax: p.syntax)

  = #get_palette(p.theme).name
  - Code block: #p.code_block
  - Code syntax: #p.syntax

  ```typ
  #import "/src/lib.typ": catppuccin, themes, get_palette

  #let perms = ()
  #for theme in themes.values() {
    for code_block in (true, false) {
      for syntax in (true, false) {
        perms.push((theme: theme, code_block: code_block, syntax: syntax))
      }
    }
  }

  #for p in perms [
    #show: catppuccin.with(p.theme, code_block: p.code_block, code_syntax: p.syntax)
    = #get_palette(p.theme).name
    == Code block: #p.code_block
    == Code syntax: #p.syntax
  ]
  ```
]
