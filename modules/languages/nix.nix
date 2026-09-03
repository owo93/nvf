{
  vim.languages.nix = {
    enable = true;
    lsp.enable = true;
    lsp.servers = [ "nixd" ];
    format.type = [ "nixfmt" ];
    extraDiagnostics.types = [ "deadnix" ];
  };
}
