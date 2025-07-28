# Development Environment Setup

This document outlines how to set up per-project development environments, specifically using `direnv` and Nix flakes.

After saving your changes to `flake.nix`, `direnv` will automatically detect the change and reload the environment.

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

---

## Per-Project NodeJS Configuration using `setup-nodejs-env`

Our NixOS configuration also includes a script, `setup-nodejs-env`, to quickly bootstrap a per-project Node.js development environment.

Follow these steps to configure a specific Node.js version for a project:

### 1. Run the `setup-nodejs-env` Script

Navigate to the root directory of your Node.js project and run the script with the desired major version number.

For example, to set up an environment with Node.js 18, run:

```sh
setup-nodejs-env 18
```

The script will create two files in your project directory:
- `flake.nix`: Configured to use the specified Node.js version (e.g., `pkgs.nodejs_18`).
- `.envrc`: Instructs `direnv` to use the `flake.nix` file.

### 2. Allow `direnv`

Just like with the JDK setup, you must grant `direnv` permission to load the new configuration.

```sh
direnv allow
```

`direnv` will now build the environment defined in `flake.nix`, making the specified Node.js version available in your shell.

### 3. Verify the Setup

Once `direnv` loads the environment, you can verify that the correct Node.js version is active:

```sh
node -v
```

This should display the version of Node.js you specified.

### 4. Customization (Optional)

You can add other Node.js-related tools like `yarn` or `pnpm` to your environment by editing the generated `flake.nix` file and adding them to the `buildInputs` list.

```nix
# ...
buildInputs = [
  pkgs.nodejs_18
  pkgs.yarn
];
# ...
```
