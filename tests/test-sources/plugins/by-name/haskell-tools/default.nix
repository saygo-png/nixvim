{
  empty = {
    plugins.haskell-tools.enable = true;
  };

  defaults = {
    plugins.haskell-tools = {
      enable = true;
      settings = {
        foo = 42;
        bar.__raw = "function() print('hello') end";
      };
    };
  };
}
