request = require 'superagent'

module.exports =
  params:
    http: (exe, params) ->
      getsource = exe.build params.__s
      (cb) ->
        getsource (err, source) ->
          return cb err if err?
          #timer = new Date().getTime()
          request
            .get source
            .buffer()
            .end (err, res) ->
              #timer = new Date().getTime() - timer
              #console.log "#{timer}ms #{source}"
              return cb err if err?
              return cb new Error res.text unless res.ok
              cb null, res.text