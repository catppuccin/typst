build_assets:
  #!/usr/bin/env python3
  import multiprocessing
  import subprocess
  from pathlib import Path

  def build_preview(previews: Path, flavor: str) -> None:
      args = [
          "typst",
          "compile",
          "--root",
          ".",
          "--font-path",
          "./font",
          "--format",
          "png",
          "--input",
          f"flavor={flavor}",
          "./examples/demo.typ",
          str(previews / f"{flavor}.png"),
      ]

      subprocess.run(args, check=True)

  def main() -> None:
    flavors = ["latte", "frappe", "macchiato", "mocha"]
    previews = Path("assets/previews")
    previews.mkdir(exist_ok=True, parents=True)
    Path("assets/.gitkeep").touch()


    print("Compiling demo assets and preview...")
    with multiprocessing.Pool() as pool:
        pool.starmap(build_preview, [(previews, flavor) for flavor in flavors])

    asset_pngs = [f"{flavor}.png" for flavor in flavors]
    print("Generating composite layout with catwalk...")
    subprocess.run(
        [
            "catwalk",
            *asset_pngs,
            "--layout",
            "composite",
            "--directory",
            str(previews),
            "--output",
            "preview.webp",
        ],
        check=True,
    )

  if __name__ == "__main__":
      main()