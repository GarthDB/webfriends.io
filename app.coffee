express = require("express")
path = require("path")

app = express()

# all environments
app.set "port", process.env.PORT or 3001
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"
app.use require('compression')()
app.use require('static-favicon')(__dirname + '/public/favicon.ico')
app.use require('morgan')("dev") #logger
app.use require('method-override')()
app.use require("stylus").middleware({src: __dirname + '/public', dest: __dirname + '/public', compress: true})
app.use express.static(path.join(__dirname, "public"))

# development only
app.use require('errorhandler')()  if "development" is app.get("env")

app.use('/', require('./routes'))

require("http").createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

module.exports = app
