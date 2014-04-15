mongo = require('mongodb')
config = require('../config.json').dbconfig.production
db = require('monk')(config.host+'/'+config.dbname)
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

exports.episode = (req, res) ->
  episodes.find {"season":parseInt(req.params.season_id),"slug":req.params.episode_slug}, (err, docs)->
    console.log req.params.episode_slug
    console.log req.params.season_id
    console.log docs
    res.render "index",
      title: "Episode"
      episodes: docs
      marked: marked
      moment: moment
