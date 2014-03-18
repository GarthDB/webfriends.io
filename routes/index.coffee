mongo = require('mongodb')
package_vars = require('../package.json')
db = require('monk')(package_vars.dbconfig.host+'/'+package_vars.dbconfig.dbname)
episodes = db.get('episodecollection');
marked = require('marked')
moment = require('moment')

# GET home page.

exports.temp = (req, res) ->
  res.render "temp"

exports.index = (req, res) ->
  episodes.find {}, (err, docs)->
    res.render "index",
      title: 'Web Friends HQ'
      episodes: docs
      marked: marked
      moment: moment
