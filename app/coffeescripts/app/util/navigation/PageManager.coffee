define 'Brew/util/navigation/PageManager', [
  'dojo/_base/declare',
  'Brew/auth/LocalProvider'
  'dojo/router',
  'dojo/topic',
  'dojo/_base/lang',
  'dojo/query'
], (declare, LocalProvider, router, topic, lang, query) ->

  loadNavigationPage = (page, evt) ->
    Brew.util.navigation.PageManager.loadPage(page, evt.params)

  loadDetailPage = (page, evt) ->
    page.view = page.view.replace /_TYPE_/g, evt.params.type

    page.view = (page.view.split('/').map (word) ->
      return word unless word.indexOf('Page') > -1
      word[0].toUpperCase() + word[1..-1]
    ).join '/'

    Brew.util.navigation.PageManager.loadPage(page, evt.params)

  registerNavigationPage = (page) ->
    router.register page.hash, lang.hitch(@, loadNavigationPage, page)

  registerDetailPage = (page) ->
    router.register page.hash, lang.hitch(@, loadDetailPage, page)

  registerAllPages = ->
    pageList = Brew.util.navigation.PageList.getPages()
    registerNavigationPage page for page in pageList.navigation
    registerDetailPage page for page in pageList.detail


  pageManager = declare "Brew.util.navigation.PageManager", null,
    pageContainer: null
    pageCls: "brew-page"

    baseViewPath: 'Brew/content/'

    startup: (pageContainer) ->
      @pageContainer = pageContainer
      registerAllPages()
      router.startup()

    loadPage: (page, params) ->
      return if not LocalProvider.isAuthenticated() unless page.noAuth
      pageClass = @baseViewPath + page.view
      require [pageClass], lang.hitch(this, @_switchPage, params)

    _switchPage: (params, Page) ->
      page = new Page(params)
      @pageContainer.destroyDescendants()
      @pageContainer.addChild page

      # I'm not exactely sure why we need to do this, but sometimes 
      # a page will not render correctely unless we call resize on 
      # all its children directely. Can we get rid of this somehow?
      for child in page.getChildren()
        do (child) ->
          child.resize?()

  lang.getObject "util.navigation.PageManager", true, Brew
  Brew.util.navigation.PageManager = new pageManager()
  Brew.util.navigation.PageManager
