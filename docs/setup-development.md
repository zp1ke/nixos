# Development Environment Setup

This document outlines how to set up per-project development environments, specifically for managing Java Development Kit (JDK) versions using `direnv` and Nix flakes.

## Per-Project JDK Configuration with `direnv`

Our NixOS configuration comes with `direnv` and `nix-direnv` pre-installed and configured. This allows you to define specific environments for your projects that are automatically loaded when you `cd` into the project directory.

Follow these steps to configure a specific JDK for a project:

### 1. Create a `.envrc` file

In the root of your Java project, create a file named `.envrc` with the following content:

```sh
use flake
```

This command tells `direnv` to use the Nix flake in the current directory to build the development environment.

### 2. Create a `flake.nix` file

In the same directory, create a `flake.nix` file. This file defines the project's dependencies, including the JDK.

Here is a template for a simple Java project using JDK 21:

```nix
{
  description = "A simple Java development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          # Specify the JDK version you need
          pkgs.jdk21

          # You can add other tools like Maven or Gradle here
          # pkgs.maven
          # pkgs.gradle
        ];

        # You can also set environment variables if needed
        # shellHook = ''
        #   export JAVA_HOME="${pkgs.jdk21}"
        # '';
      };
    };
}
```

**Customization:**

*   **JDK Version:** You can change `pkgs.jdk21` to other available versions like `pkgs.jdk17`, `pkgs.jdk`, etc.
*   **Build Tools:** Uncomment or add other build tools like `pkgs.maven` or `pkgs.gradle` to the `buildInputs` list as needed.

### 3. Allow `direnv`

After creating or modifying the `.envrc` file, you need to grant `direnv` permission to load it. Run the following command in your project directory:

```sh
direnv allow
```

`direnv` will now parse the `flake.nix` file and make the specified JDK and any other tools available in your shell.

### 4. Verify the Setup

Once `direnv` loads the environment, you can verify that the correct Java version is active:

```sh
java -version
```

This should display the version of the JDK you specified in your `flake.nix`. You have now successfully configured a per-project JDK environment!
