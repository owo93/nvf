{ lib, ... }:
let
  enabledLanguages = [
    "rust"
    "nix"
    "lua"
    "markdown"
    "python"
    "html"
    "typescript"
    "tsx"
    "toml"
    "json"
    "yaml"
  ];

  languageOverrides = {
    nix = {
      lsp.servers = [ "nixd" ];
      format.type = [ "nixfmt" ];
      extraDiagnostics.types = [ "deadnix" ];
    };
    html = {
      lsp.servers = [ "emmet-ls" ];
    };
    typescript = {
      lsp.servers = [ "deno" ];
    };
    tsx = {
      lsp.servers = [ "deno" ];
    };
  };
in
{
  vim = {
    treesitter = {
      enable = true;
      fold = true;
      highlight.enable = true;
      indent.enable = true;
      addDefaultGrammars = true;
      autotagHtml = true;
    };

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      # enableLSP = true; # this is deprecated, use lsp.enable
    }
    // (builtins.listToAttrs (
      map (lang: {
        name = lang;
        value = lib.recursiveUpdate {
          enable = true;
          lsp.enable = true;
        } (languageOverrides.${lang} or { });
      }) enabledLanguages
    ));
  };
}
