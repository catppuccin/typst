UPSTREAM_URL := "https://github.com/typst/packages.git"
FORK_URL := "https://github.com/TimeTravelPenguin/packages.git"

_default:
  @just --list package

[group("Packaging")]
[doc("Prepares the package for release.")]
[no-cd]
new: init update

[private]
[no-cd]
init:
  #!/usr/bin/env sh
  set -euxo pipefail

  git clone {{FORK_URL}} package
  cd package

  # Add upstream
  git remote add upstream {{UPSTREAM_URL}}

  # Bootstrap local main
  git fetch upstream --tags --prune
  git checkout main
  git reset --hard upstream/main

  # Create feature branch
  git switch -c "catppuccin-branch"
  git reset --mixed origin/catppuccin-branch

[group("Packaging")]
[doc("Updates the package with the latest changes.")]
[no-cd]
update:
  #!/usr/bin/env sh
  set -euo pipefail

  # Get the version from the typst.toml file
  version=$(awk -F '"' '/^version/ { print $2 }' typst.toml)
  pdir="package/packages/preview/catppuccin/$version"

  # Check if origin has a tag matching the version. If not, error.
  if ! git ls-remote --tags origin | grep -q "refs/tags/v$version"; then
    echo "The tag v$version does not exist in the origin repository. Please create using:"
    echo "  git tag -a \"v$version\" -m \"v$version\" && git push origin \"v$version\""
    exit 1
  fi

  mkdir -p "$pdir"

  cp -r assets/previews "$pdir"
  cp -r manual "$pdir"
  cp -r src "$pdir"
  cp typst.toml "$pdir"
  cp README.md "$pdir"
  cp LICENSE "$pdir"

  (
    cd "$pdir/manual"
    rm -f *.typ
  )

