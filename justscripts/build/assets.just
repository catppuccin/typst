FLAVORS := "latte frappe macchiato mocha"
PREVIEWS := "assets/previews/"

[private]
build_assets: build_previews convert_previews_to_webp build_catwalk_preview

[private]
build_previews: prep_preview_dir
  #!/usr/bin/env sh

  for flavor in {{FLAVORS}}; do
    echo "Building preview for $flavor..."
    typst compile --root . --font-path ./fonts --format png \
      --input flavor="$flavor" ./examples/demo.typ {{join(PREVIEWS, "$flavor.png")}} &
  done

  wait

[private]
@prep_preview_dir:
  mkdir -p {{PREVIEWS}}
  touch ./assets/.gitkeep

[private]
convert_previews_to_webp:
  #!/usr/bin/env sh

  echo "Converting previews to WebP..."

  for preview in {{join(PREVIEWS, "*.png")}}; do
    magick "$preview" {{join(PREVIEWS, "$(basename $preview .png).webp")}}
    rm "$preview"
  done

[private]
@build_catwalk_preview:
  catwalk latte.webp frappe.webp macchiato.webp mocha.webp --layout composite --directory {{PREVIEWS}} --output preview.webp
