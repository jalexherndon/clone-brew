define "Brew/util/navigation/HashManager", [
  "dojo/_base/declare",
  "dojo/_base/lang",
  "dojo/hash",
  "dojo/topic"

], (declare, lang, hash, topic) ->

  HashManager = declare "Brew.util.navigation.HashManager", null,
    defaultHash: "/home"
    loginHash: "/login"

    startup: ->
      currentHash = hash()
      @_returnHash = currentHash if currentHash.length and currentHash isnt @loginHash
      @_isFirstPageLoad = true
      topic.subscribe "/dojo/hashchange", lang.hitch(this, @_onHashChange)

    setHash: (newHash, replace, allowSame, silent) ->
      authenticated = Brew.auth.LocalProvider.isAuthenticated()
      newHash = @_returnHash or @defaultHash  unless newHash
      newHash = if authenticated then newHash else @loginHash
      @_silent = silent

      if newHash isnt hash()
        hash newHash, replace
      else if allowSame or @_isFirstPageLoad
        delete @_isFirstPageLoad
        @_onHashChange newHash

    getHash: ->
      hash()

    _onHashChange: (hash) ->
      if @_silent
        delete @_silent
      else
        topic.publish Brew.util.Messages.HASH_CHANGE, hash

  lang.getObject "util.navigation.HashManager", true, Brew
  Brew.util.navigation.HashManager = new HashManager()
  Brew.util.navigation.HashManager
