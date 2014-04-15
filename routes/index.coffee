mongo = require('mongodb')
config = require('../config.json').dbconfig.production
db = require('monk')(config.host+'/'+config.dbname)
episodes = db.get('episodecollection');
marked = require('marked')
moment = require('moment')

# GET home page.
module.exports = (app) ->
  app.route("/")
    .get (req, res, next)->
      episodes.find {'publish_date':{'$lt':new Date()},'audio_url':{'$exists':true}}, {sort: {'publish_date': -1}}, (err, docs)->
        res.render "index",
          title: 'Web Friends HQ'
          episodes: docs
          marked: marked
          moment: moment
  app.route("/schedule")
    .get (req, res, next)->
      episodes.find {}, {sort: {'publish_date': 1}}, (err, docs)->
        res.render "schedule",
          title: 'Episode Schedule |  Web Friends HQ'
          episodes: docs
          marked: marked
          moment: moment
  app.route("/season/:season_id/episode/:episode_id")
    .get (req, res, next)->
      episodes.find {"season":parseInt(req.params.season_id),"episode":parseInt(req.params.episode_id)}, (err, docs)->
        res.render "index",
          title: "Episode"
          episodes: docs
          marked: marked
          moment: moment
