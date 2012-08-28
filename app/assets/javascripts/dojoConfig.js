var dojoConfig = {
    tlmSiblingOfDojo: false,
    isDebug: true,
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
        location: ".",
        main: "App"
    }],

    // Startup the App
    deps: ["Brew/App", "dojo/domReady!"],
    callback: function(App) {
        App.startup();
    }
};
