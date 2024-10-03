[group("Build")]
[doc("Build the template provided by this package")]
[no-cd]
compile-template:
  #!/usr/bin/env sh

  echo "\nBuilding package template..."
  version="$(grep -m 1 version typst.toml | grep -e '\d.\d.\d' -o)"

  cd template
  echo "#import \"@preview/catppuccin:$version\": catppuccin, themes, get-palette" > main.typ
  cat template_body.typ >> main.typ

  echo "Building template thumbnail..."
  idx=1
  for flavor in latte frappe macchiato mocha; do
    echo "  - ($idx/4) Building $flavor thumbnail"
    idx=$((idx + 1))
    typst compile --root .. --font-path ../fonts \
      --input flavor="$flavor" --ppi 300 main.typ "$flavor.png"
  done

  echo "Combining images into template preview..."
  echo "  - (1/3) Combining combined thumbnail"
  catwalk latte.png frappe.png macchiato.png mocha.png --layout grid --output thumbnail.png

  echo "  - (2/3) Optimizing png thumbnail"
  oxipng -q -o max --strip safe thumbnail.png

  echo "  - (3/3) Converting thumbnail to webp"
  magick thumbnail.png -resize 2000x thumbnail.webp

  echo "Cleaning up..."
  find . -type f -name "*.png" -depth 1 | xargs rm -f
