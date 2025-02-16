{ pkgs, ... }:
let
  jdtlsSource =
    let
      version = "1.44.0";
    in
    pkgs.stdenv.mkDerivation {
      name = "jdtls-source";
      version = "${version}";
      src = pkgs.fetchurl {
        url = "https://download.eclipse.org/jdtls/milestones/${version}/jdt-language-server-${version}-202501221502.tar.gz";
        hash = "sha256-0+q4TwbRSPx6CKGvRv9kuAQdpAAwRRWGPWLKTmzacrM=";
      };
      unpackPhase = ":";
      nativeBuildInputs = [ ];
      installPhase = ''
        mkdir -p ./tmp
        tar xf "$src" --directory ./tmp
        cp -R "./tmp" "$out"
      '';
    };

  javaTest =
    let
      version = "0.43.0";
    in
    pkgs.stdenv.mkDerivation {
      name = "vscode-java-test";
      version = "${version}";
      src = pkgs.fetchurl {
        # https://open-vsx.org/extension/vscjava/vscode-java-test
        url = "https://open-vsx.org/api/vscjava/vscode-java-test/${version}/file/vscjava.vscode-java-test-${version}.vsix";
        hash = "sha256-MPrGkKtqV728vbiNX1nXmGAWuv1ULKs4tKdryrvUBZI=";
      };
      unpackPhase = ":";
      nativeBuildInputs = [ pkgs.unzip ];
      installPhase = ''
        cp "$src" "tmp.zip"
        mkdir -p ./tmp
        unzip "tmp.zip" -d ./tmp
        cp -R "./tmp/extension/server" "$out"
      '';
    };

  javaDebug =
    let
      version = "0.58.1";
    in
    pkgs.stdenv.mkDerivation {
      name = "vscode-java-debug";
      version = "${version}";
      src = pkgs.fetchurl {
        # https://open-vsx.org/extension/vscjava/vscode-java-debug
        url = "https://open-vsx.org/api/vscjava/vscode-java-debug/${version}/file/vscjava.vscode-java-debug-${version}.vsix";
        hash = "sha256-0e31eigyGvyx2Iq4xSXx7E7e+DfM2c6P4scXnyxqdPc=";
      };
      unpackPhase = ":";
      nativeBuildInputs = [ pkgs.unzip ];
      installPhase = ''
        cp "$src" "tmp.zip"
        mkdir -p ./tmp
        unzip "tmp.zip" -d ./tmp
        cp -R "./tmp/extension/server" "$out"
      '';
    };

  springExtensions =
    let
      version = "1.59.0";
    in
    pkgs.stdenv.mkDerivation {
      name = "vscode-spring-boot";
      version = "${version}";
      src = pkgs.fetchurl {
        # https://open-vsx.org/extension/VMware/vscode-spring-boot
        url = "https://open-vsx.org/api/VMware/vscode-spring-boot/${version}/file/VMware.vscode-spring-boot-${version}.vsix";
        hash = "sha256-m1N1pOjyrWp+AQjijcRbAgkl3gUNw6iuK02wPgNa7MU=";
      };
      unpackPhase = ":";
      nativeBuildInputs = [ pkgs.unzip ];
      installPhase = ''
        cp "$src" "tmp.zip"
        mkdir -p ./tmp
        unzip "tmp.zip" -d ./tmp
        cp -R "./tmp/extension" "$out"
      '';
    };

  gradleLs =
    let
      version = "3.15.0";
    in
    pkgs.stdenv.mkDerivation {
      name = "vscode-gradle";
      version = "${version}";
      src = pkgs.fetchurl {
        # https://open-vsx.org/extension/vscjava/vscode-gradle
        url = "https://open-vsx.org/api/vscjava/vscode-gradle/${version}/file/vscjava.vscode-gradle-${version}.vsix";
        hash = "sha256-/aX/6deD+vXF2DF6V/uXji0/0A0jXkTAGRermQDjpNI=";
      };
      unpackPhase = ":";
      nativeBuildInputs = [ pkgs.unzip ];
      installPhase = ''
        cp "$src" "tmp.zip"
        mkdir -p ./tmp
        unzip "tmp.zip" -d ./tmp
        cp -R "./tmp/extension" "$out"
      '';
    };
in
{
  programs.neovim.extraPackages = with pkgs; [
    jdt-language-server
  ];

  home.file = {
    ".jdtls/plugins".source = "${jdtlsSource}/plugins";
    ".jdtls/config_linux/config.ini".source = "${jdtlsSource}/config_linux/config.ini";
    ".jdtls/config_mac/config.ini".source = "${jdtlsSource}/config_mac/config.ini";
    ".jdtls/bundles/java-test".source = javaTest;
    ".jdtls/bundles/java-debug-adapter".source = javaDebug;
    ".jdtls/bundles/vscode-spring-boot".source = springExtensions;
    ".jdtls/bundles/vscode-gradle".source = gradleLs;
  };
}
