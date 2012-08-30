(function() {
    var launchApp = function(App) {
        App.startup();
    },

    isRunningInProduction = function() {
        return window.location.hostname === 'clonebrew';
    };

    window.dojoConfig = {
        tlmSiblingOfDojo: false,
        isDebug: !isRunningInProduction(),
        async: true,
        waitSeconds: 5,

        // Define packages
        baseUrl: "/assets/",
        packagePaths: {
            "dojotoolkit/1.8.0/": [
                "dojo",
                "dijit",
                "dojox"
            ]
        },
        packages: [{
            name: "Brew",
            location: "."
        }],

        // Startup the App
        deps: ["Brew/App", "dojo/domReady!"],
        callback: launchApp
    };
})();