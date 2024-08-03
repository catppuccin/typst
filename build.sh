#!/usr/bin/env bash

echo "Building Catppuccin pallets for Typst..."
whiskers catppuccin.tera || exit

mkdir -p assets/previews
touch assets/.gitkeep

flavors=("latte" "frappe" "macchiato" "mocha")
for flavor in "${flavors[@]}"; do
  echo "Compiling demo for '$flavor'..."
  typst compile --font-path ./font --root . --input flavor="$flavor" ./examples/demo.typ ./assets/previews/"$flavor".png || exit
done

layouts=("composite" "stacked" "grid" "row")
for layout in "${layouts[@]}"; do
  echo "Creating catwalk with layout '$layout'..."
  catwalk latte.png frappe.png macchiato.png mocha.png \
    --layout "$layout" --directory ./assets/previews --output catwalk_"$layout".webp || exit
done

echo "Done!"
