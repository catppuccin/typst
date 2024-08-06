build_assets:
  #!/usr/bin/env python3
  import subprocess
  from concurrent import futures
  from concurrent.futures import ProcessPoolExecutor
  from pathlib import Path
  from subprocess import CompletedProcess


  def build_preview(previews: Path, flavor: str) -> CompletedProcess[bytes]:
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

      return subprocess.run(args, check=False, stderr=subprocess.PIPE)


  def main() -> None:
      flavors = ["latte", "frappe", "macchiato", "mocha"]
      previews = Path("assets/previews")
      previews.mkdir(exist_ok=True, parents=True)
      Path("assets/.gitkeep").touch()

      print("Compiling demo assets and preview...")
      with ProcessPoolExecutor() as pool:
          future_to_flavor = {pool.submit(build_preview, previews, flavor): flavor for flavor in flavors}
          for future in futures.as_completed(future_to_flavor):
              flavor = future_to_flavor[future]
              result = future.result()
              if result.returncode != 0:
                  print(f"Failed to compile preview for {flavor}:\n\n{result.stderr.decode()}")
                  raise subprocess.CalledProcessError(result.returncode, result.args)

              print(f"Compiled preview for {flavor}")

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
