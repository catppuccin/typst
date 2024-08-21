import "justscripts/build/assets.just"
import "justscripts/build/manual.just"
import "justscripts/build/modules.just"
import "justscripts/build/template.just"

[private]
@err message:
  echo "\033[30;41;1m Error: \033[0m\033[31m\033[1m {{message}}\033[0m"

[private]
[no-exit-message]
ensure_root:
  #!/usr/bin/env sh
  if [[ ! -f ./typst.toml ]]; then
    just err "Please run this script from the root of the Typst repository."
    exit 1
  fi

[group("Build")]
[doc("Builds package modules, formats files, and builds assets.")]
build: ensure_root build_modules test compile_template (build_manual "latte mocha") build_assets format oxipng

[group("Build")]
[doc("Builds the manual using the provided flavor(s).")]
manual +flavors="mocha": ensure_root build_modules test (build_manual flavors)

[group("Build")]
[doc("Removes the compiled modules, assets, temporary files, and any manuals.")]
@clean:
  echo "Removing tmThemes and assets..."
  rm -rf src/tmThemes assets manual/{.temp,*.pdf} \
    tests/**/{out,diff} template/main.{typ,png}

[group("Installation")]
[doc("Installs the package to the system under @local.")]
install: build
  mkdir -p gallery
  ./common/scripts/package "@local"

[private]
install-preview: build
  mkdir -p gallery
  ./common/scripts/package "@preview"

[group("Development")]
[linux, macos]
[doc("Installs development tools and dependencies.")]
[confirm("Homebrew and Cargo are about to install some dependencies. Continue? (y/N)")]
dev-tools:
  #!/usr/bin/env sh
  if [[ ! -x "$(command -v brew)" ]]; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
  fi

  brew update
  brew upgrade
  brew install typstyle typos-cli oxipng catppuccin/tap/catwalk catppuccin/tap/whiskers yarn
  yarn install
  yarn upgrade

  if [[ ! -x "$(command -v cargo)" ]]; then
    echo "Cargo is not installed. Cannot install typst-test."
    echo "Visit https://www.rust-lang.org to install Rust."
    exit 1
  fi

  cargo install --locked --git https://github.com/tingerrr/typst-test

[group("Development")]
test *filter:
  typst-test run {{filter}}

[group("Development")]
update-test *filter:
  typst-test update {{filter}}

[group("Development")]
@format:
  echo "Running prettier on tmThemes."
  yarn prettier **/*.tmTheme -w

  echo "Running typstyle on typst files."
  typstyle -c 120 format-all

[group("Development")]
@oxipng:
  echo "Optimizing .png files..."
  oxipng -o max --strip safe `find . -type f -iname "*.png" \
    -not -path "./tests/**/diff/*" -not -path "./tests/**/out/*"`

[private]
[confirm("Have you bumped the version in typst.toml? (y/N)")]
new-publishing-branch:
  #!/usr/bin/env sh
  version="$(grep -m 1 version typst.toml | grep -e '\d.\d.\d' -o)"

  echo "Stashing any changes..."
  git stash push -m "Stashing changes before creating a new publishing package."

  if [[ -d packages ]]; then
    echo "Removing existing packages directory..."
    rm -rf packages
  fi

  git checkout --orphan "catppuccin-publish-v${version}"
  git reset --hard
  git pull https://github.com/typst/packages.git main

  cd packages/preview

  if [[ ! -d "catppuccin" ]]; then
    mkdir catppuccin
  fi

  cd catppuccin

  if [[ -d "$version" ]]; then
    echo "Version $version already exists. Aborting."
    exit 1
  fi

  git clone https://github.com/catppuccin/typst.git main

  mv main "$version"
  cd "$version"

  git clean -Xdf
  rm -rf assets common examples justscripts tests gallery
  rm -f *.lock *.js *.json *.tera typos.toml justfile
  find . -name ".*" -depth 1 | xargs rm -rf

  mv fonts template/fonts
  mv template/thumbnail.png .

  @echo Directory is ready to be verified and published.
  @echo Directory at: "$(pwd)"

