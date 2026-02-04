#import "/src/lib.typ": flavors, set-code-theme

#show: set-code-theme.with(flavors.latte)

Using catppuccin for syntax highlighting:

```typ
#import "@preview/catppuccin:1.0.1": set-code-theme, flavors
#show: set-code-theme.with(flavors.mocha)
```

