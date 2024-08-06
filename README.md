<h3 align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Logo"/><br/>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
	Catppuccin for <a href="https://github.com/catppuccin/typst">Typst</a>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

<p align="center">
	<a href="https://github.com/timetravelpenguin/typst/stargazers"><img src="https://img.shields.io/github/stars/timetravelpenguin/typst?colorA=363a4f&colorB=b7bdf8&style=for-the-badge"></a>
	<a href="https://github.com/timetravelpenguin/typst/issues"><img src="https://img.shields.io/github/issues/timetravelpenguin/typst?colorA=363a4f&colorB=f5a97f&style=for-the-badge"></a>
	<a href="https://github.com/timetravelpenguin/typst/contributors"><img src="https://img.shields.io/github/contributors/timetravelpenguin/typst?colorA=363a4f&colorB=a6da95&style=for-the-badge"></a>
</p>

<p align="center">
	<img src="https://raw.githubusercontent.com/timetravelpenguin/typst/main/assets/previews/preview.webp"/>
</p>

## Previews

<details>
<summary>🌻 Latte</summary>
<img src="https://raw.githubusercontent.com/timetravelpenguin/typst/main/assets/previews/latte.png"/>
</details>
<details>
<summary>🪴 Frappé</summary>
<img src="https://raw.githubusercontent.com/timetravelpenguin/typst/main/assets/previews/frappe.png"/>
</details>
<details>
<summary>🌺 Macchiato</summary>
<img src="https://raw.githubusercontent.com/timetravelpenguin/typst/main/assets/previews/macchiato.png"/>
</details>
<details>
<summary>🌿 Mocha</summary>
<img src="https://raw.githubusercontent.com/timetravelpenguin/typst/main/assets/previews/mocha.png"/>
</details>

## Usage

Eventually, this package will be made available through Typst's built-in package manager. For now, you can follow these steps:

1. Clone or download this repository into `{data-dir}/typst/packages/local/catppuccin/{version}` to make them available locally on your system. Here, `{data-dir}` is

   - `$XDG_DATA_HOME` or `~/.local/share` on Linux
   - `~/Library/Application Support` on macOS
   - `%APPDATA%` on Windows

   Further instruction can be found on Tpyst's [package](https://github.com/typst/packages?tab=readme-ov-file#local-packages) repository. As an example, using v0.1.0, you path may look like `~/.local/share/typst/packages/local/catppuccin/0.1.0`.

2. In your project, import the package (ensure you have the correct version number) with

   ```typst
   #import "@local/catppuccin:0.1.0": catppuccin, themes
   ```

   Lastly, you can configure your document by calling:

   ```typst
   #show: catppuccin.with(themes.mocha, code_block: true, code_syntax: true)
   ```

   replacing `mocha` with the theme you want to use. This can also be passed as a string literal `"mocha"`. You can further adjust the arguments to `catppuccin.with` to customise the theme look of your document.

## 💝 Thanks to

- [TimeTravelPenguin](https://github.com/TimeTravelPenguin)

&nbsp;

<p align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

<p align="center">
	Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
</p>

<p align="center">
	<a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a>
</p>
