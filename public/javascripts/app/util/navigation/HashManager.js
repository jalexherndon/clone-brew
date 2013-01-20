(function() {

  define("Brew/util/navigation/HashManager", ["dojo/_base/declare", "dojo/_base/lang", "dojo/hash", "dojo/topic"], function(declare, lang, hash, topic) {
    var HashManager;
    HashManager = declare("Brew.util.navigation.HashManager", null, {
      defaultHash: "/library",
      loginHash: "/login",
      startup: function() {
        var currentHash;
        currentHash = this.getHash();
        if (currentHash.length && currentHash !== this.loginHash) {
          this._returnHash = currentHash;
        }
        this._isFirstPageLoad = true;
        return topic.subscribe("/dojo/hashchange", lang.hitch(this, this._onHashChange));
      },
      setHash: function(newHash, replace, allowSame, silent) {
        if (newHash !== this.loginHash ? !Brew.auth.LocalProvider.isAuthenticated(true) : void 0) {
          return;
        }
        if (!newHash) {
          newHash = this._returnHash || this.defaultHash;
        }
        this._silent = silent;
        if (newHash !== this.getHash()) {
          return hash(newHash, replace);
        } else if (allowSame || this._isFirstPageLoad) {
          delete this._isFirstPageLoad;
          return this._onHashChange(newHash);
        }
      },
      getHash: function() {
        return hash();
      },
      _onHashChange: function(hash) {
        if (this._silent) {
          return delete this._silent;
        } else {
          return topic.publish(Brew.util.Messages.HASH_CHANGE, hash);
        }
      }
    });
    lang.getObject("util.navigation.HashManager", true, Brew);
    Brew.util.navigation.HashManager = new HashManager();
    return Brew.util.navigation.HashManager;
  });

}).call(this);
