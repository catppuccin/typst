# Compiling the template

The compiled template `main.typ` is made by running `just build` in the root. Or, by running the private recipe `just build_template`.

When run, the file `catppuccin_src.typ` is appended to the header:

```typ
#import "@preview/catppuccin:{{version}}": catppuccin, themes, get-palette
```

Where the substring `{{version}}` is replaced with the packages' current version.
