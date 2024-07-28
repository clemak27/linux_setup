{ pkgs, ... }:
let
  primeRun = pkgs.writeShellApplication {
    name = "prime-run";
    runtimeInputs = [ ];
    text = ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec -a "$0" "$@"
    '';
  };
in
{
  # add novideo driver with prime :(
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    offload.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    # 00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-H GT2 [UHD Graphics 630]
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    # 01:00.0 3D controller: NVIDIA Corporation TU117M [GeForce GTX 1650 Mobile / Max-Q] (rev a1)
    nvidiaBusId = "PCI:1:0:0";
  };
  # services.xserver.screenSection = ''
  #   Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
  # '';
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  environment.systemPackages = [ primeRun ];
}
