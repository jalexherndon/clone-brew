describe 'service', () ->
  beforeEach(module('clonebrews'))

  describe 'version', () ->
    it 'should return current version', inject (version) ->
      expect(version).toEqual('0.1')
