define 'Brew/util/navigation/PageMapping', [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dojo/store/Memory'
], (declare, lang, Memory) ->

  PageMapping = declare 'Brew.util.navigation.PageMapping', Memory,
    idProperty: 'hash'
    data: [{
      hash: '/login'
      content: 'Brew/content/login/LoginPage'
    },{
      hash: '/home'
      content: 'Brew/content/home/HomePage'
    },{
      hash: '/library'
      content: 'Brew/content/library/BeerPage'
      left: 'Brew/content/library/LeftNavigation'
    },{
      hash: '/404'
      content: 'Brew/content/error/404'
    },{
      hash: '/beers/:id'
      content: 'Brew/content/detail/beer/BeerPage'
    }]

    getPage: (hash, callback) ->
      [page, id] = @get hash
      pageClasses = []

      unless dojo.isObject page
        Brew.util.navigation.HashManager.setHash '/404'
        return

      pageClasses.push page.content
      pageClasses.push page.left if page.left
      require pageClasses, (Content, Left) ->
        left = new Left() if left?
        callback(new Content(pageAction: id), left)

    get: (hash, id) ->
      page = @inherited arguments

      if page?
        return [page, id]
      else
        [key, id] = @_getHashWithAction hash
        @get key, id if key?


    _getHashWithAction: (hash) ->
      for key of @index
        if @_keyHasAction(key)
          array = key.split ":"
          if hash.indexOf array[0] >= 0
            id = hash.split(array[0])[1]
            return [key, id]

      return null

    _keyHasAction: (key) ->
      key.indexOf(":") >= 0

  lang.getObject 'util.navigation.PageMapping', true, Brew
  Brew.util.navigation.PageMapping = new PageMapping()
  Brew.util.navigation.PageMapping
