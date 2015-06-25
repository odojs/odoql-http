# odoql-http
Web requests for OdoQL. Reqeusts use `GET`, and are powered by [superagent](https://github.com/visionmedia/superagent).

## Options
* `attempts=1` - retry on error or 4\*\*/5\*\* status code until `attempts` requests have been made.
