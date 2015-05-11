request = require 'superagent'

module.exports = (exe, params) ->
  getdata = exe.build params.__source
  (cb) ->
    getdata (err, data) ->
      return cb err if err?
      request
        .get data
        .buffer()
        .end (err, res) ->
          return cb err if err?
          return cb new Error res.text unless res.ok
          cb null, res.text