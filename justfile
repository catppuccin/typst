mod build "./justscripts/build"

default:
  @just --list --justfile {{justfile()}}

[group("Build")]
[doc("Removes the compiled modules, assets, temporary files, and any manuals.")]
[no-cd]
@clean:
  echo "Cleaning up all built files..."
  rm -rf src/tmThemes assets manual/{.temp,*.pdf} \
    tests/**/{out,diff} template/main.typ template/*.webp

[group("Installation")]
[doc("Installs the package to the system under @local/@preview.")]
install namespace="@local":
  #!/usr/bin/env sh
  if [[ {{namespace}} == "@local" ]] || [[ {{namespace}} == "@preview" ]]; then
    mkdir -p gallery # required for the following script
    ./common/scripts/package {{namespace}}
    echo "\nNote that you currently need to manually copy the template directory."
  else
    echo "Invalid namespace. Please use either @local or @preview."
  fi

[group("Development")]
[unix]
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

[group("Testing")]
test *filter:
  typst-test run {{filter}}

[group("Testing")]
update-test *filter:
  typst-test update {{filter}}

[group("Development")]
[confirm("Have you bumped the version in typst.toml? (y/N)")]
new-publishing-branch:
  #!/usr/bin/env sh
  version="$(grep -m 1 version typst.toml | grep -e '[0-9]\.[0-9]\.[0-9]' -o)"

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

