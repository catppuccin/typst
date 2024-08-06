[private]
install_local:
  #!/usr/bin/env python3
  import os
  import platform
  import shutil
  import tomllib
  from pathlib import Path


  def get_pkg_dir_base() -> Path:
      system = platform.system().lower()
      match system:
          case "linux":
              return Path("~/.local/share/typst").expanduser().resolve(strict=True)
          case "darwin":
              return Path("~/Library/Application Support/typst").expanduser().resolve(strict=True)
          case "windows":
              return Path(f"{os.getenv('APPDATA')}/Local/typst").resolve(strict=True)
          case _:
              raise ValueError(f"Unsupported platform: {system}")


  base_dir = get_pkg_dir_base()
  typst_toml_path = Path("typst.toml").resolve(strict=True)

  with typst_toml_path.open("rb") as f:
      typst_toml = tomllib.load(f)
      package: dict = typst_toml.get("package")

  pkg_name = package.get("name")
  if pkg_name != "catppuccin":
      raise ValueError(f"Invalid package name: {pkg_name}")

  version = package.get("version")
  if version is None:
      raise ValueError("Invalid package version")

  pkg_dir = base_dir / "packages/local/catppuccin" / version

  if pkg_dir.exists():
      shutil.rmtree(pkg_dir, ignore_errors=False)

  shutil.copytree(".", pkg_dir)
