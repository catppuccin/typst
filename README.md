<h3 align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Logo"/><br/>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
	Catppuccin for <a href="https://github.com/catppuccin/typst">Typst</a>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

<p align="center">
	<a href="https://github.com/catppuccin/typst/stargazers"><img src="https://img.shields.io/github/stars/catppuccin/typst?colorA=363a4f&colorB=b7bdf8&style=for-the-badge"></a>
	<a href="https://github.com/catppuccin/typst/issues"><img src="https://img.shields.io/github/issues/catppuccin/typst?colorA=363a4f&colorB=f5a97f&style=for-the-badge"></a>
	<a href="https://github.com/catppuccin/typst/contributors"><img src="https://img.shields.io/github/contributors/catppuccin/typst?colorA=363a4f&colorB=a6da95&style=for-the-badge"></a>
</p>

<p align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/typst/main/assets/previews/preview.webp"/>
</p>

## Previews

<details>
<summary>🌻 Latte</summary>
<img src="https://raw.githubusercontent.com/catppuccin/typst/main/assets/previews/latte.png"/>
</details>
<details>
<summary>🪴 Frappé</summary>
<img src="https://raw.githubusercontent.com/catppuccin/typst/main/assets/previews/frappe.png"/>
</details>
<details>
<summary>🌺 Macchiato</summary>
<img src="https://raw.githubusercontent.com/catppuccin/typst/main/assets/previews/macchiato.png"/>
</details>
<details>
<summary>🌿 Mocha</summary>
<img src="https://raw.githubusercontent.com/catppuccin/typst/main/assets/previews/mocha.png"/>
</details>

## Installation

Eventually, this package will be made available through Typst's built-in package manager. For now, there are two methods you can follow to install this package:

### Method 1: Using the install script

1. Clone or download this repository into a directory on your system.
2. Ensure you have [Just](https://github.com/casey/just) installed on your system.
3. Open the directory containing the repository in a commandline terminal and run the following command:

   ```sh
   just install
   ```

   Or, to first build the package and then install it, run:

   ```sh
   just tmThemes whiskers install
   ```

If you received no errors, the package should now be installed and available for use in your Typst documents.

If you receive an error, you will either see a message stating that your platform is not supported for the automated install or something bad happened. In the latter case, please [open an issue](https://github.com/catppuccin/typst/issues/new?assignees=&labels=bug&template=bug.yaml) on this repository.

### Method 2: Manual install

1. Clone or download this repository to you computer.
2. Move the contents of the downloaded repository into `{data-dir}/typst/packages/local/catppuccin/{version}` to make them available locally on your system. Here, `{data-dir}` is

   - `$XDG_DATA_HOME` or `~/.local/share` on Linux
   - `~/Library/Application Support` on macOS
   - `%APPDATA%` on Windows

   Further instruction can be found on Typst's [package](https://github.com/typst/packages?tab=readme-ov-file#local-packages) repository. As an example, using v0.1.0, you path may look like `~/.local/share/typst/packages/local/catppuccin/0.1.0`.

## Usage

In your project, import the package (ensure you have the correct version number) with

```typst
#import "@local/catppuccin:0.1.0": catppuccin, themes
```

To format your document with a theme, use the following syntax towards the top of your document:

```typst
#show: catppuccin.with(themes.mocha, code_block: true, code_syntax: true)
```

Replace `mocha` with the flavour of your choice! This can also be passed as a string literal `"mocha"`. You can further adjust the arguments to `catppuccin.with` to customise the theme look of your document.

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
