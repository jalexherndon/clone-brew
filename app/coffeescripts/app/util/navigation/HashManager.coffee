define "Brew/util/navigation/HashManager", [
  "dojo/_base/declare",
  "dojo/_base/lang",
  "dojo/hash",
  "dojo/topic",
  "dojo/io-query"

], (declare, lang, hash, topic, ioQuery) ->

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

    get: (key) ->
      param = null
      cur_hash = @getHash()
      if cur_hash.indexOf('?') > -1
        param = ioQuery.queryToObject(cur_hash.split('?')[1])[key]

      param

    set: (obj, silent) ->
      hash_parts = @getHash().split('?')
      query_obj = {}

      if hash_parts.length is 2
        lang.mixin(query_obj, ioQuery.queryToObject(hash_parts[1]))

      lang.mixin(query_obj, obj)
      hash_parts[1] = ioQuery.objectToQuery(query_obj)
      new_hash = hash_parts[0] + (if hash_parts[1].length > 0 then "?#{hash_parts[1]}" else "")

      @setHash(new_hash, false, false, silent)

    _onHashChange: (hash) ->
      if @_silent
        delete @_silent
      else
        topic.publish Brew.util.Messages.HASH_CHANGE, hash

  lang.getObject "util.navigation.HashManager", true, Brew
  Brew.util.navigation.HashManager = new HashManager()
  Brew.util.navigation.HashManager
