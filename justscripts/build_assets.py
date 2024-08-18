import subprocess
from collections.abc import Callable
from concurrent import futures
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path
from subprocess import CompletedProcess

FLAVORS = ["latte", "frappe", "macchiato", "mocha"]


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


def convert_preview_to_webp(previews: Path, flavor: str) -> CompletedProcess[bytes]:
    input = previews / f"{flavor}.png"
    out = previews / f"{flavor}.webp"
    args = [
        "magick",
        str(input),
        str(out),
    ]

    return subprocess.run(args, check=False, stderr=subprocess.PIPE)


def build_combined_preview(previews: Path) -> None:
    asset_pngs = [f"{flavor}.webp" for flavor in FLAVORS]
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


def run_flavor_processes(previews: Path, func: Callable) -> None:
    with ProcessPoolExecutor() as pool:
        future_to_flavor = {pool.submit(func, previews, flavor): flavor for flavor in FLAVORS}
        for future in futures.as_completed(future_to_flavor):
            flavor = future_to_flavor[future]
            result = future.result()
            if result.returncode != 0:
                print(f"Failed running {func.__name__} for {flavor}:\n\n{result.stderr.decode()}")
                raise subprocess.CalledProcessError(result.returncode, result.args)


def build_flavor_previews(previews: Path) -> None:
    print("Compiling demo assets and preview...")
    run_flavor_processes(previews, build_preview)


def convert_previews_to_webp(previews: Path) -> None:
    print("Converting .png previews to .webp...")
    run_flavor_processes(previews, convert_preview_to_webp)

    for png in previews.glob("*.png"):
        png.unlink()


if __name__ == "__main__":
    previews = Path("assets/previews")
    previews.mkdir(exist_ok=True, parents=True)
    Path("assets/.gitkeep").touch()

    build_flavor_previews(previews)
    convert_previews_to_webp(previews)
    build_combined_preview(previews)
