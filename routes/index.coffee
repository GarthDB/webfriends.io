mongo = require('mongodb')
config = require('../config.json').dbconfig.production
db = require('monk')(config.host+'/'+config.dbname)
episodes = db.get('episodecollection');
marked = require('marked')
moment = require('moment')

router = require('express').Router()

router.get '/', (req, res, next) ->
  episodes.find {'publish_date':{'$lt':new Date()},'audio_url':{'$exists':true}}, {sort: {'publish_date': -1}}, (err, docs)->
    res.render "index",
      title: 'Web Friends HQ'
      episodes: docs
      marked: marked
      moment: moment
router.get '/schedule', (req, res, next) ->
  episodes.find {}, {sort: {'publish_date': 1}}, (err, docs)->
    res.render "schedule",
      title: 'Episode Schedule |  Web Friends HQ'
      episodes: docs
      marked: marked
      moment: moment
router.get '/season/:season_id/episode/:episode_id', (req, res, next) ->
  episodes.find {"season":parseInt(req.params.season_id),"episode":parseInt(req.params.episode_id)}, (err, docs)->
    res.render "episode",
      title: docs[0].title
      episode: docs[0]
      marked: marked
      moment: moment
      url: 'http://webfriends.io'+req.path
router.get '/sitemap.xml', (req, res, next) ->
  episodes.find {'publish_date':{'$lt':new Date()},'audio_url':{'$exists':true}}, {sort: {'publish_date': -1}}, (err, docs)->
    console.log(docs)
    res.header 'Content-Type', 'text/xml'
    res.render "sitemap",
      episodes: docs
      moment: moment
module.exports = router
