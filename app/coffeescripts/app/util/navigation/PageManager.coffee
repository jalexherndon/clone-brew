define 'Brew/util/navigation/PageManager', [
  'dojo/_base/declare',
  'dojo/topic',
  'dojo/_base/lang',
  'dojo/query'
], (declare, topic, lang, query) ->

  pageManager = declare "Brew.util.navigation.PageManager", null,
    contentContainer: null
    pageCls: "brew-page"

    startup: (contentContainer) ->
      @contentContainer = contentContainer
      topic.subscribe Brew.util.Messages.HASH_CHANGE, lang.hitch this, @_loadPage

    _loadPage: (hash) ->
      Brew.util.navigation.PageMapping.getPage hash, (page, left) =>
        @contentContainer.removeAllChildren()
        @contentContainer.addChild page
        @contentContainer.addChild left, "left"  if left

  lang.getObject "util.navigation.PageManager", true, Brew
  Brew.util.navigation.PageManager = new pageManager()
  Brew.util.navigation.PageManager
