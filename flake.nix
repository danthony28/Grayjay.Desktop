{
	description = "Grayjay Desktop";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = {
		self,
		nixpkgs,
	}: let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
		version = "3";

		sourceRepo =
			pkgs.fetchFromGitHub {
				owner = "futo-org";
				repo = "Grayjay.Desktop";
				rev = "3dfebc3af34d428ece9ef764914af2df03a8ee94";
				hash = "sha256-BA1IsSUciHuvUADitjed9Wf44V1Xq8iN1tw7D722aLk=";
			};
	in {
		packages.${system}.default = let
		in
			pkgs.buildNpmPackage {
				name = "grayjay-desktop-web";
				inherit version;

				src = sourceRepo;

				# postBuild = ''
				# 	cp -r ./dist $out/
				# '';

				# fixupPhase = ''
				# 	rm -rf $out/lib
				# '';

				meta = {
					description = "Grayjay Desktop: Follow creators, not platforms";
				};
			};
	};
}
