{ lib, fetchFromGitHub, jre, makeWrapper, maven }:

maven.buildMavenPackage rec {
  pname = "ktfmt";
  version = "0.45";

  src = fetchFromGitHub {
    owner = "facebook";
    repo = pname;
    rev = "${pname}-${version}";
    hash = "sha256-pZkdLmFORnC4qD0B99MU5xTCXbYMO6KblwOrZZR6hRc=";
  };

  mvnHash = "sha256-pzMjkkdkbVqVxZPW2I0YWPl5/l6+SyNkhd6gkm9Uoyc=";

  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin $out/share/ktfmt
    install -Dm644 core/target/ktfmt-*-jar-with-dependencies.jar $out/share/ktfmt/ktfmt.jar

    makeWrapper ${jre}/bin/java $out/bin/ktfmt \
      --add-flags "-jar $out/share/ktfmt/ktfmt.jar"
  '';

  meta = with lib; {
    description = "Simple command line wrapper around JD Core Java Decompiler project";
    homepage = "https://github.com/intoolswetrust/jd-cli";
    license = licenses.gpl3;
    maintainers = with maintainers; [ majiir ];
  };
}

