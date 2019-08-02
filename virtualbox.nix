{
  ctf = { ... }: {
    deployment.targetEnv = "virtualbox";
    deployment.virtualbox.memorySize = 1024;
    deployment.virtualbox.vcpu = 2;
    deployment.virtualbox.headless = true;

    imports = [ ./configuration.nix ];
  };
}
