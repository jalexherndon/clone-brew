describe 'filter', () ->
  beforeEach module('clonebrews')

  describe 'interpolate', () ->
    beforeEach module ($provide) ->
      $provide.value('version', 'TEST_VER')
      return

    it 'should replace VERSION', inject (interpolateFilter) ->
      expect(interpolateFilter('before %VERSION% after')).toEqual 'before TEST_VER after'
