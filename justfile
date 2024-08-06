import "justfiles/build_assets.just"

build: tmThemes whiskers build_assets

tmThemes:
  #!/usr/bin/env sh

  cd src || exit
  mkdir -p tmThemes

  echo "Downloading Catppuccin tmThemes..."
  wget -q https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme -O tmThemes/latte.tmTheme &
  wget -q https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme -O tmThemes/frappe.tmTheme &
  wget -q https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme -O tmThemes/macchiato.tmTheme &
  wget -q https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme -O tmThemes/mocha.tmTheme &

  wait

@whiskers:
  echo "Building Catppuccin pallets for Typst..."
  whiskers typst.tera

@clean:
  echo "Removing tmThemes and assets..."
  rm -rf tmThemes assets