# Node.js Development Environment Setup

This document explains how to set up per-project Node.js environments using `direnv` and Nix flakes, which is the idiomatic "Nix way".

## Per-Project Node.js Configuration with `direnv`

Our NixOS configuration comes with `direnv` and `nix-direnv` pre-installed and configured. This allows you to define specific environments for your projects that are automatically loaded when you `cd` into the project directory.

Follow these steps to configure a specific Node.js version for a project:

### 1. Run the `setup-nodejs-env` Script

Navigate to the root directory of your Node.js project in the terminal and run the `setup-nodejs-env` script, passing the desired Node.js major version number as an argument.

For example, to set up an environment with Node.js 18, run:

```sh
setup-nodejs-env 18
```

The script will create two files in your project directory:
- `flake.nix`: Configured to use the specified Node.js version (e.g., `pkgs.nodejs_18`).
- `.envrc`: Instructs `direnv` to use the `flake.nix` file.

### 2. Allow `direnv`

After the script runs, you must grant `direnv` permission to load the new configuration. Run the following command:

```sh
direnv allow
```

`direnv` will now build the environment defined in `flake.nix`, making the specified Node.js version available in your shell.

### 3. Verify the Setup

Once `direnv` loads the environment, you can verify that the correct Node.js version is active:

```sh
node -v
```

This should display the version of Node.js you specified. You have now successfully configured a per-project Node.js environment!
