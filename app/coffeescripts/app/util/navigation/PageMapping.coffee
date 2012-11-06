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
      content: 'Brew/content/library/LibraryPage'
      left: 'Brew/content/library/LeftNavigation'
    },{
      hash: '/404'
      content: 'Brew/content/error/404'
    }]

    getPage: (hash, callback) ->
      page = @get hash
      pageClasses = []

      unless dojo.isObject page
        Brew.util.navigation.HashManager.setHash '/404'
        return

      pageClasses.push page.content
      pageClasses.push page.left if page.left
      require pageClasses, callback

  lang.getObject 'util.navigation.PageMapping', true, Brew
  Brew.util.navigation.PageMapping = new PageMapping()
  Brew.util.navigation.PageMapping
