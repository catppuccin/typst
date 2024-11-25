[group("Build")]
[doc("Builds the package Typst files provided by this package.")]
[no-cd]
lib:
  #!/usr/bin/env sh

  echo "\nBuilding Catppuccin pallets for Typst..."
  whiskers typst.tera

  mkdir -p tmThemes

  echo "Downloading Catppuccin tmThemes..."
  COMMIT_HASH="d3feec47b16a8e99eabb34cdfbaa115541d374fc"
  wget -q "https://github.com/catppuccin/bat/raw/$COMMIT_HASH/themes/Catppuccin%20Latte.tmTheme" -O tmThemes/latte.tmTheme &
  wget -q "https://github.com/catppuccin/bat/raw/$COMMIT_HASH/themes/Catppuccin%20Frappe.tmTheme" -O tmThemes/frappe.tmTheme &
  wget -q "https://github.com/catppuccin/bat/raw/$COMMIT_HASH/themes/Catppuccin%20Macchiato.tmTheme" -O tmThemes/macchiato.tmTheme &
  wget -q "https://github.com/catppuccin/bat/raw/$COMMIT_HASH/themes/Catppuccin%20Mocha.tmTheme" -O tmThemes/mocha.tmTheme &

  wait
