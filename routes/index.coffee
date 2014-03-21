mongo = require('mongodb')
package_vars = require('../package.json')
db = require('monk')(package_vars.dbconfig.host+'/'+package_vars.dbconfig.dbname)
episodes = db.get('episodecollection');
marked = require('marked')
moment = require('moment')

# GET home page.

exports.schedule = (req, res) ->
  episodes.find {}, {sort: {'publish_date': 1}}, (err, docs)->
    res.render "schedule",
      title: 'Episode Schedule |  Web Friends HQ'
      episodes: docs
      marked: marked
      moment: moment

exports.index = (req, res) ->
  episodes.find {'publish_date':{'$lt':new Date()},'audio_url':{'$exists':true}}, {sort: {'publish_date': -1}}, (err, docs)->
    res.render "index",
      title: 'Web Friends HQ'
      episodes: docs
      marked: marked
      moment: moment
