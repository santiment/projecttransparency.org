{composerEnv, fetchurl, fetchgit ? null, fetchhg ? null, fetchsvn ? null, noDev ? false}:

let
  packages = {
    "vlucas/phpdotenv" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "vlucas-phpdotenv-3cc116adbe4b11be5ec557bf1d24dc5e3a21d18c";
        src = fetchurl {
          url = https://api.github.com/repos/vlucas/phpdotenv/zipball/3cc116adbe4b11be5ec557bf1d24dc5e3a21d18c;
          sha256 = "1c1n4x17pd70w6gz8nm8vpkigf1975yqsk6dr80zqkxisx4klldi";
        };
      };
    };
  };
  devPackages = {};
in
composerEnv.buildPackage {
  inherit packages devPackages noDev;
  name = "santiment-projecttransparency.org";
  src = ./.;
  executable = false;
  symlinkDependencies = false;
  meta = {};
}