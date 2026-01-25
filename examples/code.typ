#import "/src/lib.typ": config-code-blocks, flavors

#show: config-code-blocks.with(flavors.latte)

Using catppuccin for syntax highlighting:

```typ
#import "@preview/catppuccin:1.0.1": config-code-blocks, flavors
#show: config-code-blocks.with(flavors.mocha)
```

