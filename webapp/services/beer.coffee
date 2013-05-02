angular.module('clonebrews').service 'BeerService', [
  '$log',
  '$q',
  '$resource',

  ($log, $q, $resource) ->
    @numberOfPages = null

    Beer = $resource '/beers/:id', {withBreweries: 'y'}

    # These are the no label images and will be overriden by beers that have real labels
    Beer.prototype.labels =
      icon: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAAAAAA7VNdtAAAB1ElEQVRIx+3W/W+aQBgH8P7/f8sU7pU3qxJqu42Ke0mVlJW7g7YumZ3p1oV0DbgHdXNLdzRkidkP/YZcLuY+eZ4HhXiwap2DZ/LPpCrLCpbqfv5mdBx9fKj3jaQq5kly+TlL0rc9x7LsXrxQiVqWelItJ33b8fquwwl31hl4jju6rrSkOK1PUUwtgokFW5sQG1b/i5bkLhyA4xguzIBYGNeSp1oSU8YYxZuQzR4+4jTRkhn+e6jQEsEeH0dw+Xda8jVAdSMEeiJ1j9CTaxFElf6OlQlBhHPv1WQycjkAO5y+8w2+0Hwv35c3izNiuv4oTJRMw8PD/tH4TOZhl2nItxOz0zGwObmWZJxJMQyEuIrIxeVpV1cl7SIINqI8ZREQP1Aqj3gKRFdl9oJNs/f0J5F+IOWWcC2xbqo5a0tWOyJ+I6yR8PZV+F4a288s/21jvE2VuEMGQZ+0IVfE6NY//haN3U/9wdDDbaqsHoqiyNZ3bP2IDXwgY9pI6qzHl7MLJdX5OSwfYpnrG9sQZoSZVErK7ZI1PftbYvopzL5LJobGEwTRk1jshIiPCXpiFng5Wl7vVzx4kaPGWW4DZJrGHzFNdHTXQMpPL4eP8npRPf9V2C/5Aa9P+H3lOgF8AAAAAElFTkSuQmCC'
      medium: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAAAAAB5Gfe6AAAE6UlEQVR42u3bYU/iSBjA8f3+X+SS3T2U0pYWMAE0SOzCrpzccYJKi+O5y1246wYXI9neTKcalar74nKx7f9JbKdTTHh+nT6d1vomKni8AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABejptZv9s9mFwXC+Dm6u9v6+hm+fX6r06j5rpufVd8X1+Fq3UhAK79jluvfZjs12sNt9aIo9447jVqDe/PAgBc9Z26TNku23JhWnUt4FZctdy5zD3A96M4/5plmq5rWaatR4BtObFD62veARZNdagbjmVZti0Xpt40LS3hnOQd4NSuy1CDX4cEkJsSwNL9o7wDnJhy8D8ZVv4BJs8CmO5p3gEC57n8jd1l3gG+7RlypFdtVQRsS475JExZEk3Tmed/HhDYFdOWsz/bdty6U3XjcGq9vZptGjsFmAhd7xhyBFTd5tCfTn9tNZxqteo0hrPp7GA79wD/zOdzUa9U6nt7vU/jme+fT1rNZnO3NxxOgwsv7wDrY6dUKm2ZZvngs5j+3L6QAL+8HQSns8/77yYzkXuAmVHWtb7cFcFpeU9IgKP3h2Lmi+5WEQCOSvI6ZxiPAc79ogAMS0ZztVo1jQIDtOSqBQAAAAAAAAAAAAAAAAAAUDSAtly1CwtwVDKdbrfrFPZ5wPG2aW5vbxf3gUjY3lJRXIBocfih1+sV9xRIQhfBk/et+KnwTx8lwEXnbYEA4sugPx2MZr4/O/k0UavfD6dBwQD8c5m4TF0kq8AvEsCuH/gbIQ4KA1BxR/rA34tAHLuVogCYRvM3XzyIi2DUNorx1+GoaZim4bQ6D6Ptqu5GEQA6MlOzUn4cqje+V8g9wBen/EQY9h9FAIi+7O+mR+f/zp/X5QEAAIDXE6EnI/yx3tcOMJIhVCNQrdGjtz9TO/MFoL60pzIceSnfP7UzilZBP6V3vRhkEEAMZYbqve/52PP6YvVwb2pnIhP+aO8rrwHi9hiHGmJjWKe+FZ83gEHRAbzLu1znA7U9XqcAxJ/0ztZ3xcGL6+My3hgvswtwJk/0dZLrQmfmDZ8EiHclAF5/Fa36d82sAohA/iS5ypo4HI1kTos0gMHtrlH8MTlYgiiIu+NmZgHWMquVzlUeyqQzDWBxu0unGu/daGYQILqU5/DLAGpbDNIA4u4Mj4AoUmm9CLAc67N9AyDzNSCuff2XAMK42vWfADhbRVkG0Gk8DyDr49linVYDhiLM9DxA5bpMAOQBltf5IJ4Z3ANYy9Tu2+hURXIVuMzwRCgcq/onG2caYBxf1JIbpGgpU+yrG0J59MPB7aVvHOq2uo2Q8wD1iyriXrHMGIA+gdUdnq4Bt9Oa4N7doI5QeJuh/nnwMmnr/aOsAkT6KqBL/UBEmwCRGDxKf6wH/GKYYQAeiQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAfxv/AtUfVKQ7GT+1AAAAAElFTkSuQmCC'
      large: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJYAAACWCAAAAAAZai4+AAAEA0lEQVR42u3aD2+bOBQA8H3/LzJp26UJMQQClcgfpVFZ2MqVO1bSJpC6ly13yh1TOqqicc82qdqGttPGZja9JzUYk8S/2s+OU/osr2U8QxaykIUsZCELWchCFrKQhSxkIQtZyEIWspCFLGQhC1nI+vVZ1wt3PD6cXtWBdX3576csv958vPpnZHUNwzAH9HN2maSZRNZVNDLM7uvpgdm1jK7Fw7ROJlbXcv6Wxrp0dRMgWkuDB6KawmW0Dfa4v5TE+nzMVV2VEMNQVaKJ3tJUnet6H+Ww1jbrFktXVVXT4IGIU6IKn34qh3WmmRBs+EQAC06BpYr6QA7rlMDwPRiqLNb0URYxzuSwYv0xlTLYyGF9GiowVh2NJZemwqgVQWACEKKvZK1bsdYmGqzsmqYbpt4xeOjdybCrEWVf2nJ6ta9Ab3UM24/m8z96lt7pdHTLX8wXh01JrP9WqxU1221zOJy8DRdRdD7t2bY9mPj+PL5w5LCyE73RaOwR0jp8T+e/9S+A9fsLLz5bvD94OV1QSayF0hLzrTWm8VlrSIF1/OqILiI63pPHOm7ACqAo91nnkVyW31DsNE1tpXasHhx6yEIWspCFLGQhq66sPhz6NWPBfksfj8d6zfZbJ01Cms1m3baBSX+PRd1Y+fro9WQyqdsgFiFS/vRVj3/zef4GWBejF9JZfIGI5l4A3xMXp2+n7PDuaB7XghWdAwdAtDjEkXzWIIqjnaCHklltIxCddCtiemK05bKIYv8Z0TtxEQd9ReZfbHIbvlcrem90N/oGq7bksUbQPmm37ger5Z+Zklgf9NYDoWh/yWPlHw4G5TH6BhXeT0TWT8dKHIjky2q/jhVAUFaIWSm4d2eitPJHsNhbOazdwCl519LKPE9jt6Q2W3uVsagP7bJ7XavQcVya3r1aWll4ky+t/arcotv+SARvZ2BK78/9GJZXT5azvBGsPHYeZiUs/kxnlt0kncNnw4afhJuqWTNIoKwQrEV7jv8gi18qWI6b5ql7U6yWRWP4KQQwA/wggJbWZSxveyngT4OOjfOYV/NixawM2kqFAH7torKMtd5eEgB+dadYGStfQm48zWLn1Ctj8erKeyvPWWNPsjahyKId1nfKLZ7p7lOshOe2+wBrlubVs8SbP86C2TBbZ2W55dPkO6xbTLApWNAZsC7FfCW7xcqgwdtiAaDFTFxWvpwmIct2KMwEK+TTvfj4zjfQsMs2EdBTibddFMJElNnHKaxb7IUseC3dVMISicF2BSK3totjfGsHISKhzm6wf4ZYFmVxPaiWlYuZKKabR/NdVk69e6hQDNnar5yFe3lkIQtZyEIWspCFLGQhC1nIQhaykIUsZCELWchC1s/H+h8bNdboEzNADQAAAABJRU5ErkJggg=='

    Beer.prototype.getBreweryDisplayString = ->
      name = []
      for brewery in @breweries
        name.push brewery.name

      name.join ', '

    Beer.prototype.getStats = ->
      stats = {}
      for stat in ['abv','ibu','srm']
        if @[stat]?
          stats[stat] = @[stat].name || @[stat]

      stats

    @query = (opts={}) ->
      defer = $q.defer()

      Beer.query opts, (results) ->
        defer.resolve results
      , (results) ->
        $log.error 'BeerService.query error', results
        defer.reject results

      defer.promise

    @get = (id) ->
      defer = $q.defer()

      Beer.get {id}, (results) ->
        defer.resolve results 
      , (results) ->
        $log.error 'BeerService.get error', results
        defer.reject results

      defer.promise

    @save = (data) ->
      defer = $q.defer()
      beer = new Beer data

      beer.$save (results) ->
        defer.resolve results
      , (results) ->
        $log.error 'BeerService.save error', results
        defer.reject results

      defer.promise
]