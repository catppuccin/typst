build: tmThemes whiskers assets

tmThemes:
  #!/usr/bin/env sh

  cd src || exit
  mkdir -p tmThemes

  echo "Downloading Catppuccin tmThemes..."
  wget -q https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme -O tmThemes/latte.tmTheme &
  wget -q https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme -O tmThemes/frappe.tmTheme &
  wget -q https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme -O tmThemes/macchiato.tmTheme &
  wget -q https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme -O tmThemes/mocha.tmTheme &

  wait

whiskers:
  @echo "Building Catppuccin pallets for Typst..."
  @whiskers catppuccin.tera

assets:
  #!/usr/bin/env python3
  import subprocess
  from pathlib import Path

  import typst

  previews = Path("assets/previews")
  previews.mkdir(exist_ok=True, parents=True)
  Path("assets/.gitkeep").touch()

  flavors = ["latte", "frappe", "macchiato", "mocha"]
  for flavor in flavors:
      print(f"Compiling {flavor} demo asset preview...")
      typst.compile(
          "./examples/demo.typ",
          output=previews / f"{flavor}.png",
          format="png",
          root=".",
          font_paths=["./font"],
          sys_inputs={"flavor": flavor},
      )

  asset_pngs = [f"{flavor}.png" for flavor in flavors]
  layouts = ["composite", "stacked", "grid", "row"]
  for layout in layouts:
      print(f"Generating catwalk asset with {layout} layout...")
      subprocess.run(
          [
            "catwalk",
            *asset_pngs,
            "--layout",
            layout,
            "--directory",
            str(previews),
            "--output",
            f"catwalk_{layout}.webp",
        ],
        check=True,
    )


clean:
  rm -rf tmThemes assets