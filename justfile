mod build "./justscripts/build"
mod package "./justscripts/package"

_default:
  @just --list --justfile {{justfile()}}

[private]
[no-cd]
fetch_scripts:
  #!/usr/bin/env sh
  set -euo pipefail

  cp -r ./typst-package-template/scripts .

[group("Development")]
[doc("Updates typst dependencies in the project.")]
@update *opts:
  #!/usr/bin/env sh
  set -euo pipefail

  typst-upgrade {{ opts }} requirements.toml
  typst-upgrade {{ opts }} src
  typst-upgrade {{ opts }} manual
  typst-upgrade {{ opts }} examples


[group("Development")]
[unix]
[doc("Installs development tools and dependencies.")]
[confirm("Homebrew and Cargo are about to install some dependencies. Continue? (y/N)")]
dev-tools:
  #!/usr/bin/env sh
  set -euo pipefail

  if [[ ! -x "$(command -v brew)" ]]; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
  fi

  brew update
  brew upgrade
  brew install typstyle typos-cli oxipng catppuccin/tap/catwalk catppuccin/tap/whiskers

  if [[ ! -x "$(command -v cargo)" ]]; then
    echo "Cargo is not installed. Cannot install typst-test."
    echo "Visit https://www.rust-lang.org to install Rust."
    exit 1
  fi

  cargo install --locked --git https://github.com/tingerrr/typst-test
  cargo install typst-upgrade

