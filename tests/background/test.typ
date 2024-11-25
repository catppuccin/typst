#import "/src/lib.typ": catppuccin, flavors, parse-flavor, config-code-blocks

#set page(width: auto, height: auto)

#let perms = ()
#for flavor in flavors.keys() {
  for code-block in (true, false) {
    for syntax in (true, false) {
      perms.push((flavor: flavor, code-block: code-block, syntax: syntax))
    }
  }
}

#for p in perms [
  #pagebreak(weak: true)
  #show: catppuccin.with(p.flavor)
  #show: config-code-blocks.with(p.flavor, code-block: p.code-block, code-syntax: p.syntax)

  = #parse-flavor(p.flavor).name
  - Code block: #p.code-block
  - Code syntax: #p.syntax

  ```typ
  #import "/src/lib.typ": catppuccin, flavors, parse-flavor

  #let perms = ()
  #for flavor in flavors.values() {
    for code-block in (true, false) {
      for syntax in (true, false) {
        perms.push((flavor: flavor, code-block: code-block, syntax: syntax))
      }
    }
  }

  #for p in perms [
    #show: catppuccin.with(p.flavor, code-block: p.code-block, code-syntax: p.syntax)
    = #parse-flavor(p.flavor).name
    == Code block: #p.code-block
    == Code syntax: #p.syntax
  ]
  ```
]
