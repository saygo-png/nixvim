{ lib, config, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "haskell-tools";
  packPathName = "haskell-tools.nvim";
  package = "haskell-tools-nvim";

  # This is a filetype plugin that doesn't use a setup function.
  # Configuration is passed to a global table.
  callSetup = false;

  maintainers = [ lib.maintainers.saygo-png ];

  settingsExample = {
    foo = 42;
    bar.__raw = "function() print('hello') end";
  };

  extraOptions = {
    enableTelescope = lib.mkEnableOption "telescope integration";
  };

  extraConfig = cfg: {
    globals.haskell_tools = cfg.settings;

    plugins.telescope.enabledExtensions = lib.mkIf cfg.enableTelescope [ "ht" ];

    warnings =
      let
        hlsEnabled = config.lsp.servers.hls.enable || config.plugins.lsp.servers.hls.enable == true;
      in
      lib.nixvim.mkWarnings "plugins.haskell-tools" [
        {
          when = hlsEnabled;
          message = ''
            It is recommended to disable hls when using haskell-tools
            as it can cause conflicts. The plugin sets up the server already.
          '';
        }
      ];
  };
}
