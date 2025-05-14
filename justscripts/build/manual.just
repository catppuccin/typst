[group("Build")]
[doc("Builds the manual using the provided flavor(s).")]
[no-cd]
manual +flavors="mocha":
  #!/usr/bin/env sh
  set -euo pipefail

  echo "\nBuilding the package manual..."

  flavors="{{flavors}}"

  case "$flavors" in
    *all*)
      flavors="latte frappe macchiato mocha"
      ;;
  esac

  logo_light_path="/assets/logos/logo_light.png"
  logo_dark_path="/assets/logos/logo_dark.png"

  for flavor in $flavors; do
    if [[ "$flavor" == "latte" ]]; then
      logo="$logo_light_path"
    else
      logo="$logo_dark_path"
    fi

    echo "Building manual for $flavor..."
    typst compile --root . \
      --font-path ./fonts \
      --input flavor="$flavor" \
      --input logo="$logo" \
      manual/manual.typ "manual/manual_$flavor.pdf"
  done

