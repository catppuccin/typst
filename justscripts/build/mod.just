import "assets.just"
import "manual.just"
import "modules.just"

[group("Build")]
[doc("Builds package modules, formats files, and builds assets.")]
[no-cd]
@all: lib assets (manual "latte mocha")
  echo "\nPerforming post-build tasks..."

  echo "Formatting files..."
  typstyle -c 80 format-all

  echo "Optimizing .png files..."
  find . -type f -iname "*.png" -not -path "./tests/*" | xargs oxipng -q -o max --strip safe

  echo "\nBuild complete"
