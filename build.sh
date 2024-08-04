#!/usr/bin/env bash

(
  cd src || exit
  mkdir -p tmThemes

  echo "Downloading Catppuccin tmThemes..."
  wget https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme -O tmThemes/latte.tmTheme
  wget https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme -O tmThemes/frappe.tmTheme
  wget https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme -O tmThemes/macchiato.tmTheme
  wget https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme -O tmThemes/mocha.tmTheme
)

echo "Building Catppuccin pallets for Typst..."
whiskers catppuccin.tera || exit

mkdir -p assets/previews
touch assets/.gitkeep

flavors=("latte" "frappe" "macchiato" "mocha")
for flavor in "${flavors[@]}"; do
  echo "Compiling demo for '$flavor'..."
  typst compile --font-path ./font --root . --input flavor="$flavor" \
    ./examples/demo.typ ./assets/previews/"$flavor".png || exit
done

layouts=("composite" "stacked" "grid" "row")
for layout in "${layouts[@]}"; do
  echo "Creating catwalk with layout '$layout'..."
  catwalk latte.png frappe.png macchiato.png mocha.png \
    --layout "$layout" --directory ./assets/previews --output catwalk_"$layout".webp || exit
done

echo "Done!"
