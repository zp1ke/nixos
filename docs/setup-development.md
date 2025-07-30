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

---

## Per-Project Flutter Configuration using `setup-flutter-env`

For Flutter projects, the best approach is to create a dedicated development shell using a Nix flake. This ensures that the specific versions of the Flutter SDK, Android SDK, and JDK are managed per-project.

### 1. Run the `setup-flutter-env` Script

Navigate to the root of your Flutter project and run the script, passing the desired Android build tools version as an argument.

For example, to use build tools version `34.0.0`, run:

```sh
setup-flutter-env 34.0.0
```

This will generate a `flake.nix` and a `.envrc` file, defining a complete and isolated Flutter development environment with:
- Flutter SDK
- Android SDK (with the specified build tools version)
- JDK 17 (required by Flutter)
- Graphics drivers (to resolve `eglinfo` warnings)

### 2. Allow `direnv`

As with the other setups, you must allow `direnv` to load the new flake-based environment.

```sh
direnv allow
```

`direnv` will now build the shell, which may take some time on the first run as it downloads the specified Android SDK components.

### 3. Verify the Setup

Once the shell is loaded, you can verify the environment and check for any remaining setup tasks.

```sh
flutter doctor
```

If prompted, accept the Android licenses:

```sh
flutter doctor --android-licenses
```

Your Flutter project now has a fully declarative, reproducible, and isolated development environment.

### 4. Customization (Optional)

You can add other Flutter-related tools to your environment by editing the generated `flake.nix` file and adding them to the `buildInputs` list. For example:

```nix
# ...
buildInputs = [
  androidSdk
  firebase-tools
  flutter
  jdk17
  mesa.drivers
  libgl
  # Add other tools like:
  # gradle
  # android-studio
];
# ...
```
