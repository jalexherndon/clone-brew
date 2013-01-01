define 'Brew/util/navigation/PageManager', [
  'dojo/_base/declare',
  'dojo/router',
  'dojo/topic',
  'dojo/_base/lang',
  'dojo/query'
], (declare, router, topic, lang, query) ->

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
      pageClass = @baseViewPath + page.view

      require [pageClass], (Page) =>
        @pageContainer.destroyDescendants()

        page = new Page(params)
        @pageContainer.addChild page

        for child in page.getChildren()
          do (child) ->
            child.resize?()

  lang.getObject "util.navigation.PageManager", true, Brew
  Brew.util.navigation.PageManager = new pageManager()
  Brew.util.navigation.PageManager
