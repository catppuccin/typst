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

[group("Build")]
[doc("Removes the compiled modules, assets, temporary files, and any manuals.")]
[no-cd]
@clean:
  echo "Cleaning up all built files..."
  rm -rf src/tmThemes assets/previews manual/{.temp,*.pdf} \
     template/main.typ template/*.webp

