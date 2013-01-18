define "Brew/util/navigation/HashManager", [
  "dojo/_base/declare",
  "dojo/_base/lang",
  "dojo/hash",
  "dojo/topic"

], (declare, lang, hash, topic) ->

  HashManager = declare "Brew.util.navigation.HashManager", null,
    defaultHash: "/library"
    loginHash: "/login"

    startup: ->
      currentHash = @getHash()
      @_returnHash = currentHash if currentHash.length and currentHash isnt @loginHash
      @_isFirstPageLoad = true
      topic.subscribe "/dojo/hashchange", lang.hitch(this, @_onHashChange)

    setHash: (newHash, replace, allowSame, silent) ->
      return if !Brew.auth.LocalProvider.isAuthenticated(true) unless newHash is @loginHash
      newHash = @_returnHash or @defaultHash  unless newHash
      @_silent = silent

      if newHash isnt @getHash()
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
