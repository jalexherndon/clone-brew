(function() {
  var ApplicationLauncher;

  ApplicationLauncher = (function() {
    var instance;

    function ApplicationLauncher() {}

    ApplicationLauncher.prototype.BASE_PATH = "/js-lib/";

    ApplicationLauncher.prototype.DOJO_PATH = "dojotoolkit/1.8.0";

    ApplicationLauncher.prototype.DOJO_PACKAGES = ["dojo", "dijit", "dojox", "dgrid", "xstyle", "put-selector"];

    ApplicationLauncher.prototype.APP_PATH = "/javascripts/app";

    ApplicationLauncher.prototype.APP_NAMESPACE = "Brew";

    ApplicationLauncher.prototype.APP_DEPENDENCIES = ["Brew/App", "dojo/domReady!"];

    ApplicationLauncher.prototype.APP_SINGLETONS = ['Brew/util/Messages', 'Brew/auth/LocalProvider', 'Brew/util/navigation/PageManager', 'Brew/util/navigation/PageMapping', 'Brew/util/navigation/HashManager', 'Brew/ui/grid/StructureFactory'];

    instance = null;

    ApplicationLauncher.init = function() {
      if (!(this.instance != null)) {
        instance = new this;
        window.dojoConfig = instance._buildDojoConfig();
      }
      return instance;
    };

    ApplicationLauncher.prototype._launchCallback = function(App) {
      if (window.location.pathname === "/") {
        return App.startup();
      }
    };

    ApplicationLauncher.prototype._isRunningInProduction = function() {
      return window.location.hostname === "clonebrew";
    };

    ApplicationLauncher.prototype._buildDojoPackagePaths = function() {
      var packagePaths;
      packagePaths = {};
      packagePaths[this.DOJO_PATH] = this.DOJO_PACKAGES;
      return packagePaths;
    };

    ApplicationLauncher.prototype._buildDojoConfig = function() {
      return {
        tlmSiblingOfDojo: false,
        isDebug: !this._isRunningInProduction(),
        async: true,
        waitSeconds: 5,
        baseUrl: this.BASE_PATH,
        packagePaths: this._buildDojoPackagePaths(),
        packages: [
          {
            name: this.APP_NAMESPACE,
            location: this.APP_PATH
          }
        ],
        require: this.APP_SINGLETONS,
        deps: this.APP_DEPENDENCIES.concat(this.APP_SINGLETONS),
        callback: this._launchCallback
      };
    };

    return ApplicationLauncher;

  })();

  ApplicationLauncher.init();

}).call(this);
