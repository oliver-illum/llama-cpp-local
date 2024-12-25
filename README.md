# Llama.cpp Local Setup

This repository outlines how to set up and work with `llama.cpp` for local experimentation and usage. The following steps will guide you through installing dependencies, building the project, converting models, and running inference.

---

## Prerequisites

### 1. System Requirements

- **macOS** (M3 Pro or newer recommended)
- Linux or Windows with compatible GPU and CPU

### 2. Tools

- [Python 3.8+](https://www.python.org/downloads/)
- [CMake](https://cmake.org/download/)
- Compiler:
  - macOS: Install Xcode Command Line Tools:
    ```bash
    xcode-select --install
    ```
  - Linux: Install GCC or Clang.
  - Windows: Use Visual Studio with CMake support.

---

## Setup Instructions

### 1. Clone the Repository

Clone the `llama.cpp` repository to your local system:

```bash
mkdir llama-cpp-local && cd llama-cpp-local
git clone https://github.com/ggerganov/llama.cpp.git
```

---

### 2. Install Dependencies

#### Create a Python Virtual Environment

It’s recommended to create a virtual environment for Python dependencies:

```bash
python3 -m venv venv
source venv/bin/activate
```

#### Install Requirements

Install the dependencies defined in `llama.cpp`:

```bash
pip install -r llama.cpp/requirements.txt
```

---

### 3. Build the Project

#### Navigate to the Build Directory

Create and move into a build directory:

```bash
cd llama.cpp
mkdir build && cd build
```

#### Run CMake

Generate the build system using `cmake`:

```bash
cmake ..
```

#### Compile the Project

Build the binaries:

```bash
make
```

or for faster build

```bash
make -j$(sysctl -n hw.logicalcpu)
```

_On Linux, replace `$(sysctl -n hw.logicalcpu)` with `$(nproc)`._

#### Verify the Build

Check the `bin/` directory for the compiled binaries:

```bash
ls bin/
```

---

### 4. Convert Models

To use Hugging Face models with `llama.cpp`, convert them to GGUF format using the provided script.

#### Run Conversion

```bash
python3 ../convert_hf_to_gguf.py --model /path/to/model --outfile ./converted_model/model.gguf
```

- Replace `/path/to/model` with the directory of your Hugging Face model.
- Replace `./converted_model/model.gguf` with your desired output path.

---

### 5. Run Inference

#### Single Prompt Example

Use the `llama-cli` binary to run a single prompt:

```bash
./bin/llama-cli -m ./converted_model/model.gguf -p "Explain quantum mechanics."
```

#### Interactive Mode

To start a conversation:

```bash
./bin/llama-cli -m ./converted_model/model.gguf --interactive
```

---

## Optional Configuration

### 1. Use Symbolic Links

If you want to reference binaries or scripts outside of the `llama.cpp` folder, create symbolic links:

```bash
ln -s /path/to/llama.cpp/build/bin/llama-cli /desired/path/llama-cli
```

### 2. Automate with a Script

Create a reusable script to run commands:

```bash
#!/bin/bash
PROMPT=${1:-"What can you do?"}
./build/bin/llama-cli \
    -m ./converted_model/model.gguf \
    -p "$PROMPT" \
    -n 512 \
    --threads 12 \
    --gpu-layers 20 \
    --batch-size 2048 \
    --flash-attn \
    --ctx-size 4096
```

Save this as `run_llama.sh` and make it executable:

```bash
chmod +x run_llama.sh
./run_llama.sh "Explain relativity."
```

---

## Common Issues

### 1. Missing Dependencies

Ensure `cmake` and Python are installed correctly:

- Install CMake:
  ```bash
  brew install cmake  # macOS
  sudo apt install cmake  # Linux
  ```
- Install Python dependencies:
  ```bash
  pip install -r llama.cpp/requirements.txt
  ```

### 2. Update `llama.cpp`

To pull the latest changes from the `llama.cpp` repository:

```bash
cd llama.cpp
git pull origin master
```

---

## Directory Structure

Your project directory may look like this:

```
llama-cpp-local/
├── venv/  # Python virtual environment
├── llama.cpp/  # Cloned llama.cpp repository
│   ├── build/  # Build artifacts
│   ├── bin/  # Compiled binaries
├── converted_model/  # Converted models
├── run_llama.sh  # Script to run llama-cli
```

---

## License

This setup guide uses `llama.cpp`, which is licensed under the [Apache 2.0 License](https://github.com/ggerganov/llama.cpp/blob/master/LICENSE).

---
