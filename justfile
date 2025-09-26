mod build "./justscripts/build"
mod package "./justscripts/package"

set dotenv-load

_default:
  @just --list --justfile {{justfile()}}

# Use this to find all @import statements in the src directory containing a version number.
# Use this to check minimum typst compiler versions to manually update ci.yaml workflow.
[private]
grep_includes: _open_includes_webpage

[private]
[macos]
_open_includes_webpage:
  #!/usr/bin/env sh
  set -e pipefail

  rg -I -N -o -r '$1' '^\s*#import\s+"@preview/([A-Za-z0-9_-]+):\d+(?:\.\d+)*"' ./src \
  | sort -u \
  | xargs -n1 -I{} open "https://typst.app/universe/package/{}"

[private]
[linux]
_open_includes_webpage:
  #!/usr/bin/env sh
  set -euo pipefail

  rg -I -N -o -r '$1' '^\s*#import\s+"@preview/([A-Za-z0-9_-]+):\d+(?:\.\d+)*"' ./src \
  | sort -u \
  | xargs -n1 -I{} xdg-open "https://typst.app/universe/package/{}"


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

