logo_commit := "08946855002032919592a7c8d49204a7a59c30f9"
logo_light_sha256 := "6913f28d404575178b764dad6fc5f017b746e2e60c74a3ccac970ef26789ee62"
logo_dark_sha256 := "03ce7005d2764ad9203839b1b4d19f6cdabc3d4dc6de4aa7040c16bd05d5b6aa"

[no-cd]
build_manual flavors: download_logos
  #!/usr/bin/env sh

  flavors="{{flavors}}"

  case "$flavors" in
    *all*)
      flavors="latte frappe macchiato mocha"
      ;;
  esac

  logo_light_path="/manual/.temp/logo_light.png"
  logo_dark_path="/manual/.temp/logo_dark.png"

  for flavor in $flavors; do
    if [[ "$flavor" == "latte" ]]; then
      logo="$logo_light_path"
    else
      logo="$logo_dark_path"
    fi

    echo "Building manual for $flavor..."
    typst compile --root . --font-path ./font \
      --input flavor="$flavor" --input logo="$logo" \
      manual/manual.typ "manual/manual_$flavor.pdf"
  done

[private]
download_logos:
  #!/usr/bin/env sh

  echo "Checking for Catppuccin logos in the manual subdirectory '.temp'..."

  light_logo_url="https://raw.githubusercontent.com/catppuccin/catppuccin/{{logo_commit}}/assets/logos/exports/latte_circle.png"
  dark_logo_url="https://raw.githubusercontent.com/catppuccin/catppuccin/{{logo_commit}}/assets/logos/exports/1544x1544_circle.png"

  logo_light_path="manual/.temp/logo_light.png"
  logo_dark_path="manual/.temp/logo_dark.png"

  light_sha256="{{logo_light_sha256}}"
  dark_sha256="{{logo_dark_sha256}}"

  mkdir -p manual/.temp
  touch manual/.temp/.ignore

  for opt in light dark; do
    logo_path_var="logo_${opt}_path"
    logo_path=${!logo_path_var}

    sha256_var="${opt}_sha256"
    sha256_value=${!sha256_var}

    logo_url_var="${opt}_logo_url"
    logo_url=${!logo_url_var}

    # if the image exists but has the wrong hash, remove it
    if [[ -f "$logo_path" ]] && [[ $(sha256sum "$logo_path" | awk '{print $1}') != "$sha256_value" ]]; then
      echo "The image 'logo_$opt.png' appears invalid or outdated. Removing..."
      rm "$logo_path"
    fi

    if [[ ! -f "$logo_path" ]]; then
      echo "Downloading the image 'logo_$opt.png'..."
      wget -qO "$logo_path" "$logo_url"
    fi
  done

