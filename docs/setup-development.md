# Development Environment Setup

This document outlines how to set up per-project development environments, specifically for managing Java Development Kit (JDK) versions using `direnv` and Nix flakes.

## Per-Project JDK Configuration using `setup-jdk-env`

Our NixOS configuration includes a convenient script, `setup-jdk-env`, to quickly bootstrap a per-project Java development environment. This script automatically generates the necessary `flake.nix` and `.envrc` files for you.

Follow these steps to configure a specific JDK for a project:

### 1. Run the `setup-jdk-env` Script

Navigate to the root directory of your Java project in the terminal and run the `setup-jdk-env` script, passing the desired JDK version number as an argument.

For example, to set up an environment with JDK 21, run:

```sh
setup-jdk-env 21
```

The script will create two files in your project directory:
- `flake.nix`: Configured to use the specified JDK version (e.g., `pkgs.jdk21`).
- `.envrc`: Instructs `direnv` to use the `flake.nix` file.

### 2. Allow `direnv`

After the script runs, you must grant `direnv` permission to load the new configuration. Run the following command:

```sh
direnv allow
```

`direnv` will now build the environment defined in `flake.nix`, making the specified JDK available in your shell.

### 3. Verify the Setup

Once `direnv` loads the environment, you can verify that the correct Java version is active:

```sh
java -version
```

This should display the version of the JDK you specified.

### 4. Customization (Optional)

If you need to add more development tools like Maven or Gradle, you can edit the generated `flake.nix` file and add them to the `buildInputs` list. For example:

```nix
# ...
buildInputs = [
  pkgs.jdk21
  pkgs.maven
];
# ...
```

After saving your changes to `flake.nix`, `direnv` will automatically detect the change and reload the environment.
