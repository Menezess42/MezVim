{
    description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        nixCats.url = "github:BirdeeHub/nixCats-nvim";
    };

    outputs = { self, nixpkgs, nixCats, ... }@inputs: let

        inherit (nixCats) utils;

    luaPath = "${./.}";

    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;

    extra_pkg_config = {
        allowUnfree = true;
    };

    dependencyOverlays = /* (import ./overlays inputs) ++ */ [
        (utils.standardPluginOverlay inputs)
    ];

    categoryDefinitions = { pkgs, settings, categories, extra, name, mkNvimPlugin, ... }@packageDef: {
        lspsAndRuntimeDeps = {
# some categories of stuff.
            general = with pkgs; [
                universal-ctags
                    ripgrep
                    fd
            ];
# these names are arbitrary.
            lint = with pkgs; [
            ];
# but you can choose which ones you want
# per nvim package you export
            debug = with pkgs; {
                go = [ delve ];
            };
            go = with pkgs; [
                gopls
                    gotools
                    go-tools
                    gccgo
            ];
# and easily check if they are included in lua
            format = with pkgs; [
            ];
            neonixdev = {
# also you can do this.
                inherit (pkgs) nix-doc lua-language-server nixd;
# and each will be its own sub category
            };
        };
        startupPlugins = {
            debug = with pkgs.vimPlugins; [
                nvim-nio
            ];
            general = with pkgs.vimPlugins; {
                always = [
                    lze
                        vim-repeat
                        plenary-nvim
                        no-neck-pain-nvim
                        nvim-highlight-colors
                        nvim-autopairs
                        rainbow-delimiters-nvim
                        vim-tmux-navigator
                        nvim-ufo
                        markdown-preview-nvim
                        image-nvim
                        molten-nvim
#lsp_lines-nvim
                ];
                extra = [
                    oil-nvim
                        nvim-web-devicons
                ];
            };
        };
        optionalPlugins = {
            debug = with pkgs.vimPlugins; {
                default = [
                    nvim-dap
                        nvim-dap-ui
                        nvim-dap-virtual-text
                        no-neck-pain-nvim
                ];
            };
            lint = with pkgs.vimPlugins; [
                nvim-lint
            ];
            format = with pkgs.vimPlugins; [
                conform-nvim
            ];
            markdown = with pkgs.vimPlugins; [
                markdown-preview-nvim
            ];
            neonixdev = with pkgs.vimPlugins; [
                lazydev-nvim
            ];
            python = with pkgs.vimPlugins; [
                ale
                    pyright
            ];
            general = {
                cmp = with pkgs.vimPlugins; [
                    nvim-cmp
                        jupytext-nvim
                        luasnip
                        friendly-snippets
                        cmp_luasnip
                        cmp-buffer
                        cmp-path
                        cmp-nvim-lua
                        cmp-nvim-lsp
                        cmp-cmdline
                        cmp-nvim-lsp-signature-help
                        cmp-cmdline-history
                        lspkind-nvim
                        vim-dadbod
                        vim-dadbod-completion
                        vim-dadbod-ui
                ];
                treesitter = with pkgs.vimPlugins; [
                    nvim-treesitter-textobjects
                        nvim-treesitter.withAllGrammars
                ];
                telescope = with pkgs.vimPlugins; [
                    telescope-fzf-native-nvim
                        telescope-ui-select-nvim
                        telescope-nvim
                ];
                always = with pkgs.vimPlugins; [
                    nvim-lspconfig
                        lualine-nvim
                        gitsigns-nvim
                        vim-sleuth
                        vim-fugitive
                        vim-rhubarb
                        nvim-surround
                        no-neck-pain-nvim
                        nvim-highlight-colors
                ];
                extra = with pkgs.vimPlugins; [
                    fidget-nvim
                        which-key-nvim
                        comment-nvim
                        undotree
                        indent-blankline-nvim
                        vim-startuptime
                ];
# molten = with pkgs.vimPlugins; [
#     image-nvim
#         molten-nvim
# ];
            };
        };
        sharedLibraries = {
            general = with pkgs; [
            ];
            moltenDeps = with pkgs; [
                imagemagick
            ];
        };
        environmentVariables = {
            test = {
                CATTESTVAR = "It worked!";
            };
        };
        extraWrapperArgs = {
            test = [
                '' --set CATTESTVAR2 "It worked again!"''
            ];
        };
        extraPython3Packages = {
            test = (_:[]);
# moltenDeps = ps: with ps; [
# pynvim
# jupyter-client
# cairosvg
# pnglatex
# plotly
# pyperclip
# ];
        };
        extraLuaPackages = {
# test = [ (_:[]) ];
            general = ps: [ps.magick];
        };
    };
    packageDefinitions = {
        MezVim = {pkgs , ... }: {
            settings = {
                wrapRc = true;
                aliases = [ "mezvim" "mvim" "mvi"];
            };
            categories = {
                markdown = true;
                general = true;
                lint = true;
                format = true;
                neonixdev = true;
                test = {
                    subtest1 = true;
                };
                lspDebugMode=false;
                moltenDeps = true;
            };
            extra = {
                nixdExtras = {
                    nixpkgs = nixpkgs;
                };
            };
        };
    };
    defaultPackageName = "MezVim";
    in
        forEachSystem (system: let
                nixCatsBuilder = utils.baseBuilder luaPath {
                inherit nixpkgs system dependencyOverlays extra_pkg_config;
                } categoryDefinitions packageDefinitions;
                defaultPackage = nixCatsBuilder defaultPackageName;
                pkgs = import nixpkgs { inherit system; };
                in
                {
                packages = utils.mkAllWithDefault defaultPackage;
                devShells = {
                default = pkgs.mkShell {
                name = defaultPackageName;
                packages = [ defaultPackage ];
                inputsFrom = [ ];
                shellHook = ''
                '';
                };
                };

                }) // (let
                nixosModule = utils.mkNixosModules {
                    inherit defaultPackageName dependencyOverlays luaPath
                        categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
                };
                homeModule = utils.mkHomeModules {
                    inherit defaultPackageName dependencyOverlays luaPath
                        categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
                };
                in {
                    overlays = utils.makeOverlays luaPath {
                        inherit nixpkgs dependencyOverlays extra_pkg_config;
                    } categoryDefinitions packageDefinitions defaultPackageName;

                    nixosModules.default = nixosModule;
                    homeModules.default = homeModule;

                    inherit utils nixosModule homeModule;
                    inherit (utils) templates;
                });

}
