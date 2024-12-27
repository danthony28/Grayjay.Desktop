{
	description = "Grayjay Desktop's CEF library";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = {
		self,
		nixpkgs,
	}: let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};

		# getArch = system: nix2Net."${system}";
		# nix2Net = {
		# 	x86_64-linux = "linux-x64";
		# };

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
			pkgs.buildDotnetModule { # might have to be `rec`?
				name = "grayjay-desktop-cef";

				src = "${sourceRepo}/Grayjay.Desktop.CEF";
				# pubDir = "./bin/Release/net8.0/${getArch system}/publish";
				installPath = "$out";

				dontDotnetBuild = true;

				nativeBuildInputs = with pkgs; [
					libsodium
				];

				# preInstall = ''
				# 	mkdir -p $pubDir/wwwroot
				# # # 	This gets handled by ../flake.nix
				# # 	ln -s ${pkgs.grayjayPackages.web} $pubDir/wwwroot/web
				# 	cp -r $pubDir/ $out/
				# '';

				# fixupPhase = ''
				# 	rm -rf $out/lib
				# '';

				meta = {
					description = "Grayjay Desktop's CEF library";
				};
			};
	};
}
