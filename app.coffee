express = require('express')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
exphbs = require('express-handlebars')
index = require('./routes/index')
dice = require('./routes/dice')

app = express()
env = process.env.NODE_ENV or 'development'
app.locals.ENV = env
app.locals.ENV_DEVELOPMENT = env == 'development'

# view engine setup
app.engine 'handlebars', exphbs(
  defaultLayout: 'main'
  partialsDir: ['views/partials/'])
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'handlebars'

# app.use(favicon(__dirname + '/public/img/favicon.ico'));

app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: true)
app.use cookieParser()

app.use express.static(path.join(__dirname, 'public'))
app.use '/', index
app.use '/dice', dice

#/ catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err
  return

#/ error handlers
# development error handler
# will print stacktrace
if app.get('env') == 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: err
      title: 'error'
    return

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message
    error: {}
    title: 'error'
  return

module.exports = app
