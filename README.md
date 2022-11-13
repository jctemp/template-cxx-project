# Project Name

The requirements are:

- CMake 3.18 or better, higher version always recommended.
- A C++17 compatible compiler

Create build folder:

```bash
rm -r build && mkdir build
```

To configure:

```bash
cmake -S . -B build
```

Add `-GNinja` if you have Ninja.

To build:

```bash
cmake --build build
```

To test (`--target` can be written as `-t` in CMake 3.15+):

```bash
cmake --build build --target test
```

---

NOTE: not fully implemented

To build docs (requires Doxygen, output in `build/docs/html`):

```bash
cmake --build build --target docs
```
