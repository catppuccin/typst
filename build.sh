#!/usr/bin/env bash

echo "Building Catppuccin pallets for Typst..."
whiskers catppuccin.tera || exit

mkdir -p assets
flavors=("latte" "frappe" "macchiato" "mocha")
for flavor in "${flavors[@]}"; do
  echo "Compiling demo for '$flavor'..."
  typst compile --font-path ./font --root . --input flavor="$flavor" ./examples/demo.typ ./assets/demo_"$flavor".png || exit
done

layouts=("composite" "stacked" "grid" "row")
for layout in "${layouts[@]}"; do
  echo "Creating catwalk with layout '$layout'..."
  catwalk demo_latte.png demo_frappe.png demo_macchiato.png demo_mocha.png \
    --layout "$layout" --directory ./assets --output catwalk_"$layout".webp || exit
done

echo "Done!"
