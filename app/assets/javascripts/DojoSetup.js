(function() {
    var ApplicationLauncher = (function() {
        var
        BASE_PATH = '/assets/',

        DOJO_VERSION = '1.8.0',
        DOJO_PATH = 'dojotoolkit/' + DOJO_VERSION,
        DOJO_PACKAGES = ["dojo", "dijit", "dojox"],

        APP_PATH = './app',
        APP_NAMESPACE = 'Brew',
        APP_DEPENDENCIES = ["Brew/App", "dojo/domReady!"],
        APP_SINGLETONS = [
            'Brew/util/Messages',
            'Brew/auth/LocalProvider',
            'Brew/util/navigation/PageManager',
            'Brew/util/navigation/PageMapping',
            'Brew/util/navigation/HashManager'
        ],

        launchApp = function(App) {
            if (window.location.pathname === '/') {
                App.startup();
            }
        },

        isRunningInProduction = function() {
            return window.location.hostname === 'clonebrew';
        },

        buildDojoPackagePaths = function() {
            var packagePaths = {};
            packagePaths[DOJO_PATH] = DOJO_PACKAGES;
            return packagePaths;
        };

        return {
            buildDojoConfig: function() {
                return {
                    // Configure Dojo
                    tlmSiblingOfDojo: false,
                    isDebug: !isRunningInProduction(),
                    async: true,
                    waitSeconds: 5,

                    // Define Dojo packages
                    baseUrl: BASE_PATH,
                    packagePaths: buildDojoPackagePaths(),

                    // Define Clone Brew packages
                    packages: [{
                        name: APP_NAMESPACE,
                        location: APP_PATH
                    }],

                    require: APP_SINGLETONS,

                    // Startup the App
                    deps: APP_DEPENDENCIES.concat(APP_SINGLETONS),
                    callback: launchApp
                };
            }
        };
    })();

    window.dojoConfig = ApplicationLauncher.buildDojoConfig();
})();