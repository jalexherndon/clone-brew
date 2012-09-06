(function() {
    var ApplicationLauncher = (function() {
        var
        BASE_PATH = '/assets/',

        DOJO_VERSION = '1.8.0',
        DOJO_PATH = 'dojotoolkit/' + DOJO_VERSION,
        DOJO_PACKAGES = ["dojo", "dijit", "dojox"],

        APP_PATH = './app',
        APP_NAMESPACE = 'Brew',
        APP_DEPENDENCIES = ["Brew/app", "dojo/domReady!"],

        launchApp = function(App) {
            App.startup();
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

                    // Startup the App
                    deps: APP_DEPENDENCIES,
                    callback: launchApp
                };
            }
        };
    })();


    window.dojoConfig = ApplicationLauncher.buildDojoConfig();
})();