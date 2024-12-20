{
    # fixes an annoying ass bug, don't remove
    nixpkgs.config.permittedInsecurePackages = [ 
        "dotnet-sdk-6.0.36"
        "dotnet-runtime-6.0.36" 
    ];
}