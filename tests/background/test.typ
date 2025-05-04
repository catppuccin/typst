#set page(width: auto, height: auto)
#import "/src/lib.typ": catppuccin, config-code-blocks, flavors, get-flavor

#let perms = ()
#for flavor in flavors.values() {
  for code-block in (true, false) {
    for syntax in (true, false) {
      perms.push((flavor: flavor, code-block: code-block, syntax: syntax))
    }
  }
}

#for p in perms {
  show: catppuccin.with(
    p.flavor,
    code-block: p.code-block,
    code-syntax: p.syntax,
  )
  pagebreak(weak: true)

  block([
    = #p.flavor.name
    - Code block: #p.code-block
    - Code syntax: #p.syntax

    ```typ
    #import "/src/lib.typ": catppuccin, flavors, get-flavor

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
      = #p.flavor.name
      == Code block: #p.code-block
      == Code syntax: #p.syntax
    ]
    ```
  ])
}
