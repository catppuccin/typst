FLAVORS := "latte frappe macchiato mocha"
PREVIEWS := "assets/previews/"

[group("Build")]
[doc("Build the repository assets.")]
[no-cd]
build-assets:
  #!/usr/bin/env sh
  mkdir -p {{PREVIEWS}}
  touch ./assets/.gitkeep

  for flavor in {{FLAVORS}}; do
    echo "Building preview for $flavor..."
    typst compile --root . --font-path ./fonts --format png \
      --input flavor="$flavor" ./examples/demo.typ {{join(PREVIEWS, "$flavor.png")}} &
  done

  wait

  echo "Converting previews to WebP..."
  for preview in {{join(PREVIEWS, "*.png")}}; do
    magick "$preview" {{join(PREVIEWS, "$(basename $preview .png).webp")}}
    rm "$preview"
  done

  catwalk latte.webp frappe.webp macchiato.webp mocha.webp --layout composite --directory {{PREVIEWS}} --output preview.webp
