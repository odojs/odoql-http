request = require 'superagent'

module.exports = (exe, params) ->
  getparams = exe.build params.__params
  (cb) ->
    getparams (err, params) ->
      return cb err if err?
      request
        .get params
        .buffer()
        .end (err, res) ->
          return cb err if err?
          return cb new Error res.text unless res.ok
          cb null, res.text