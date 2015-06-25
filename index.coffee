request = require 'superagent'

module.exports =
  params:
    http: (exe, params) ->
      getsource = exe.build params.__s
      (cb) ->
        getsource (err, source) ->
          return cb err if err?

          # Superagent encodes parameters in a url passed to get() (https://github.com/visionmedia/superagent/issues/686)
          # Workaround is to pass query string to query(), which doesn't get encoded
          # Query string starts at the first '?', and ends at the end of the string or first '#' (http://tools.ietf.org/html/rfc3986#section-3.4)
          parts = source.split '?', 2
          url = parts[0]
          query = if parts[1]? then parts[1] else ''  # Empty string ignored in query()
          query = query.split('#')[0]  # Not removed in query()

          request
            .get url
            .query query
            .end (err, res) ->
              return cb err if err?
              return cb new Error res.text unless res.ok
              cb null, res.text