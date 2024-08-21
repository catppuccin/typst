import "assets.just"
import "manual.just"
import "modules.just"
import "template.just"

[group("Build")]
[doc("Builds package modules, formats files, and builds assets.")]
[no-cd]
all: build-lib compile-template build-assets (build-manual "latte mocha")
  @echo "Formatting files..."
  yarn prettier **/*.tmTheme -w
  typstyle -c 120 format-all

  @echo "Optimizing .png files..."
  find . -type f -iname "*.png" -not "tests/**/*" | xargs oxipng -o max --strip safe
