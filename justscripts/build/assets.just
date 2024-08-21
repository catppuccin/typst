FLAVORS := "latte frappe macchiato mocha"
PREVIEWS := "assets/previews/"

[group("Build")]
[doc("Build the repository assets.")]
[no-cd]
build-assets:
  #!/usr/bin/env sh

  echo "\nBuilding repository assets..."
  mkdir -p {{PREVIEWS}}
  touch ./assets/.gitkeep

  echo "\nBuilding repository assets..."
  mkdir -p {{PREVIEWS}}
  touch ./assets/.gitkeep

  echo "\nBuilding repository assets..."
  mkdir -p {{PREVIEWS}}
  touch ./assets/.gitkeep

  echo "\nBuilding repository assets..."
  mkdir -p {{PREVIEWS}}
  touch ./assets/.gitkeep

  idx=1
  for flavor in {{FLAVORS}}; do
    echo "  - ($idx/4) Building preview for $flavor..."
    idx=$((idx + 1))

    typst compile --root . --font-path ./fonts --ppi 300 --format png \
      --input flavor="$flavor" ./examples/demo.typ {{join(PREVIEWS, "$flavor.png")}}
  done

  echo "Converting previews to WebP..."
  idx=1
  for preview in {{join(PREVIEWS, "*.png")}}; do
    echo "  - ($idx/4) Converting $preview to WebP..."
    idx=$((idx + 1))

    magick "$preview" {{join(PREVIEWS, "$(basename $preview .png).webp")}}
    rm "$preview"
  done

  echo "Building composite preview..."
  catwalk latte.webp frappe.webp macchiato.webp mocha.webp --layout composite --directory {{PREVIEWS}} --output preview.webp
