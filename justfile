build: tmThemes whiskers format build_assets

tmThemes:
  #!/usr/bin/env sh

  cd src || exit
  mkdir -p tmThemes

  echo "Downloading Catppuccin tmThemes..."
  COMMIT_HASH="d3feec47b16a8e99eabb34cdfbaa115541d374fc"
  wget -q "https://github.com/catppuccin/bat/raw/$COMMIT_HASH/themes/Catppuccin%20Latte.tmTheme" -O tmThemes/latte.tmTheme &
  wget -q "https://github.com/catppuccin/bat/raw/$COMMIT_HASH/themes/Catppuccin%20Frappe.tmTheme" -O tmThemes/frappe.tmTheme &
  wget -q "https://github.com/catppuccin/bat/raw/$COMMIT_HASH/themes/Catppuccin%20Macchiato.tmTheme" -O tmThemes/macchiato.tmTheme &
  wget -q "https://github.com/catppuccin/bat/raw/$COMMIT_HASH/themes/Catppuccin%20Mocha.tmTheme" -O tmThemes/mocha.tmTheme &

  wait

@whiskers:
  echo "Building Catppuccin pallets for Typst..."
  whiskers typst.tera

install: build
  #!/usr/bin/env sh
  python3 ./justscripts/install.py

manual +flavors="mocha": build
  #!/usr/bin/env sh

  flavors="{{flavors}}"

  case "$flavors" in
    *all*)
      flavors="latte frappe macchiato mocha"
      ;;
  esac

  for flavor in $flavors; do
    echo "Building manual for $flavor..."
    typst compile --root . --font-path ./font --input flavor="$flavor" manual/manual.typ "manual/manual_$flavor.pdf"
  done

build_assets:
  #!/usr/bin/env sh
  python3 ./justscripts/build_assets.py

format:
  #!/usr/bin/env sh

  if ! command -v yarn &> /dev/null; then
    echo "yarn not found, skipping prettier..."
  else
    echo "Running prettier on tmThemes."
    yarn prettier **/*.tmTheme -w
  fi

  if ! command -v typstyle &> /dev/null; then
    echo "typstyle not found, skipping typstyle..."
  else
    echo "Running typstyle on typst files."
    typstyle -c 120 format-all
  fi

@clean:
  echo "Removing tmThemes and assets..."
  rm -rf tmThemes assets
