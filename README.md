
<br />
<div align="center">
  <h1 align="center">Hamilton</h1>
  <p align="center">
    A minimalistic procedural modeling tool.
    <br />
  </p>
  <a href="https://github.com/Frobenoid/Hamilton">
    <img src="logo.png" alt="Logo" width="400" height="400">
  </a>
</div>


<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-hamilton">About Hamilton</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

## About Hamilton

**Hamilton** is a bare-bones procedural modeling engine named in honor of two of history's greatest mathematicians: [William Rowan Hamilton](https://en.wikipedia.org/wiki/William_Rowan_Hamilton) and [Richard S. Hamilton](https://en.wikipedia.org/wiki/Richard_S._Hamilton).

There are three core technical goals guiding this project:

1. **Design an extensible graph API** capable of supporting an arbitrary node implementation.
2. **Offer a completely keyboard-driven, Vim-like editing experience**, minimizing reliance on the mouse.
3. **Leverage discrete differential geometry** by eventually implementing a **manifold half-edge mesh** data structure as the geometric kernel.

Hamilton is deliberately minimal and native to Apple platforms:

- The **graph API** is written in Swift.
- The **UI** is built with SwiftUI.
- **Model I/O** is used for mesh generation and import.
- The **graphics layer** runs on MetalKit and the Metal Shading Language (MSL).
- The upcoming **geometric kernel** will be implemented in C++ and integrated via direct Swift/C++ interoperability.

Hamilton is not a production tool; it is a learning project and an experimental playground for procedural geometry.

## Getting Started

### Prerequisites

To build and run Hamilton, you’ll need:

- **macOS** (Apple Silicon strongly recommended).
- **Xcode** (version 15 or later is recommended).
- **Command Line Tools for Xcode** installed.
- A Mac with a **Metal-compatible GPU** (all recent Apple Silicon machines qualify).

This is a native-only project.

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Frobenoid/Hamilton.git
   cd Hamilton
   ```
   
2. **Open the project in Xcode**

   - Open `Hamilton.xcodeproj` in Xcode.
   - Select the `Hamilton` scheme.

3. **Build & Run**

   - Choose a **Mac (Apple Silicon)** run destination.
   - Press **⌘R** to build and run.
   - On first launch, you may need to approve the app in **System Settings → Privacy & Security** if macOS gatekeeper complains.

## Usage

Editor behavior is structured around modes (see `EditorMode.swift`). Much like vim, if you want to navigate the viewport you should enter **Normal** mode (press `Esc`) and if you want to modify the graph you should press `i`.

Hamilton is currently an experimental tool, so expect rough edges, missing features, and occasional breaking changes as the architecture evolves.

## License

Hamilton is released under the **GNU General Public License v3.0**.

See the `LICENSE` file in this repository for the full license text.

## Acknowledgments

