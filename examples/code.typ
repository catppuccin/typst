#import "/src/lib.typ": flavors, set-code-theme

#show: set-code-theme.with(flavors.latte)

Using catppuccin for syntax highlighting:

```typ
#import "@preview/catppuccin:1.0.1": config-code-blocks, flavors
#show: config-code-blocks.with(flavors.mocha)
```

