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

  # see: https://github.com/typst/packages/blob/main/docs/tips.md#sparse-checkout-of-the-repository
  git clone --depth 1 --no-checkout --filter="tree:0" git@github.com:typst/packages
  cd packages
  git sparse-checkout init
  git sparse-checkout set packages/preview/catppuccin
  git checkout main

  # If maintainers change, update the URL below
  git remote add fork "git@github.com:TimeTravelPenguin/packages.git"
  git fetch fork
  git rebase fork/main --onto origin/main

[group("Packaging")]
[doc("Updates the package with the latest changes.")]
[no-cd]
update:
  #!/usr/bin/env sh
  set -euo pipefail

  # Get the version from the typst.toml file
  version=$(awk -F '"' '/^version/ { print $2 }' typst.toml)

  # Check if origin has a tag matching the version. If not, error.
  if ! git ls-remote --tags origin | grep -q "refs/tags/v$version"; then
    echo "The tag v$version does not exist in the origin repository. Please create using:"
    echo "  git tag -a \"v$version\" -m \"v$version\" && git push origin \"v$version\""
    exit 1
  fi

  # Checkout fork branch if it exists, otherwise create a new branch
  cd packages
  fork_branch=$(git ls-remote --exit-code --heads fork "refs/heads/catppuccin-v$version")

  if [ -n "$fork_branch" ]; then
    echo "Branch fork/catppuccin-v$version exists. Checking out."
    git checkout "catppuccin-v$version"
    git pull --rebase origin main
  else
    echo "Branch fork/catppuccin-v$version does not exist. Creating new branch and checking out."
    git checkout -b "catppuccin-v$version" origin/main
  fi

  cd ..
  pdir="packages/packages/preview/catppuccin/$version"
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

