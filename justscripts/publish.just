GIT_URL := "https://github.com/typst/packages.git"

[no-cd]
prepare-package:
  #!/usr/bin/env sh

  if [[ ! -d "package" ]]; then
    echo "Cloning the package repo..."
    git clone "{{GIT_URL}}" --depth=1 package
  fi

  (
    cd package
    git switch -C "catppuccin-branch"
    git reset --hard "origin/main" # Reset branch in case it was modified
  ) || exit 1


  # Get the version from the typst.toml file
  version=$(awk -F '"' '/^version/ { print $2 }' typst.toml)
  pdir="package/packages/preview/catppuccin/$version"

  if [[ -d "$pdir" ]]; then
    echo "The package directory for Catppuccin version $version already exists. Aborting."
    exit 1
  fi

  mkdir -p "$pdir"

  cp -r assets "$pdir"
  cp -r fonts "$pdir"
  cp -r manual "$pdir"
  cp -r src "$pdir"
  cp typst.toml "$pdir"

  cd $pdir
  git add .
  git commit -m "added catppuccin version $version"



