[group("Build")]
[doc("Build the template provided by this package")]
[no-cd]
compile-template:
  #!/usr/bin/env sh

version := `grep -m 1 version typst.toml | grep -e '[0-9]\.[0-9]\.[0-9]' -o`

  cd template
  echo "#import \"@preview/catppuccin:$version\": catppuccin, themes, get-palette" > main.typ
  cat template_body.typ >> main.typ

  for flavor in latte frappe macchiato mocha; do
    typst compile --root .. --font-path ../fonts \
      --input flavor="$flavor" --ppi 300 main.typ "$flavor.png"
  done

  catwalk latte.png frappe.png macchiato.png mocha.png --layout grid --output thumbnail.png
  oxipng -o max --strip safe thumbnail.png
  magick thumbnail.png -resize 2000x thumbnail.webp

  find . -type f -name "*.png" -depth 1 | xargs rm -f
