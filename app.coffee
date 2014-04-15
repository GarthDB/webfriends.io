express = require("express")
http = require("http")
path = require("path")
app = express()
compress = require('compression')()
logger = require('morgan')
favicon = require('static-favicon')
errorhander = require('errorhandler')
methodOverride = require('method-override')
stylus = require("stylus")

# all environments
app.set "port", process.env.PORT or 3001
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"
app.use compress
app.use favicon(__dirname + '/public/favicon.ico')
app.use logger("dev")
# app.use express.json()
# app.use express.urlencoded()
app.use methodOverride()
app.use stylus.middleware(__dirname + '/public')
app.use express.static(path.join(__dirname, "public"))

# development only
app.use errorhander()  if "development" is app.get("env")

require('./routes')(app)

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

module.exports = app
