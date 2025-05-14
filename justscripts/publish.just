GIT_URL := "https://github.com/typst/packages.git"

[no-cd]
prepare-package:
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

  if [[ ! -d "package" ]]; then
    echo "Cloning the package repo..."
    git clone "{{GIT_URL}}" --depth=1 package
  fi

  (
    cd package
    git switch -C "catppuccin-branch"
    git reset --hard "origin/main" # Reset branch in case it was modified
  ) || exit 1

  if [[ -d "$pdir" ]]; then
    echo "The package directory for Catppuccin version $version already exists. Aborting."
    exit 1
  fi

  mkdir -p "$pdir"

  cp -r assets/previews "$pdir"
  cp -r manual "$pdir"
  cp -r src "$pdir"
  cp typst.toml "$pdir"
  cp README.md "$pdir"
  cp LICENSE "$pdir"

  cd $pdir
  git add .
  git commit -m "added catppuccin version $version"
