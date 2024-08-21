version := `grep -m 1 version typst.toml | grep -e '\d.\d.\d' -o`

[private]
compile_template: build_template
  typst compile --root . --font-path fonts template/main.typ
  typst compile --root . --font-path fonts --ppi 300 template/main.typ template/thumbnail.png
  oxipng -o max --strip safe template/thumbnail.png

[private]
build_template:
  echo '#import "@preview/catppuccin:{{version}}": catppuccin, themes, get-palette' > template/main.typ
  cat template/catppuccin_src.typ >> template/main.typ
