build: update format assets

install: build
  mkdir -p gallery
  ./common/scripts/package "@local"

update: tmThemes whiskers format

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

assets:
  #!/usr/bin/env sh
  python3 ./justscripts/build_assets.py

dev-tools:
  #!/usr/bin/env sh
  if [[ ! -x "$(command -v brew)" ]]; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
  fi

  brew update
  brew upgrade
  brew install python typstyle catppuccin/tap/catwalk catppuccin/tap/whiskers yarn
  yarn install
  yarn upgrade

  if [[ ! -x "$(command -v cargo)" ]]; then
    echo "Cargo is not installed. Cannot install typst-test."
    echo "Vist https://www.rust-lang.org to install Rust."
    exit 1
  fi

  cargo install --locked --git https://github.com/tingerrr/typst-test

test *filter:
  typst-test run {{filter}}

update-test *filter:
  typst-test update {{filter}}

@format:
  echo "Running prettier on tmThemes."
  yarn prettier **/*.tmTheme -w

  echo "Running typstyle on typst files."
  typstyle -c 120 format-all

@clean:
  echo "Removing tmThemes and assets..."
  rm -rf src/tmThemes assets

[private]
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

[private]
@whiskers:
  echo "Building Catppuccin pallets for Typst..."
  whiskers typst.tera
