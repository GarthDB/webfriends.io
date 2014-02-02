mongo = require('mongodb')
package_vars = require('../package.json')
db = require('monk')(package_vars.dbconfig.host+'/'+package_vars.dbconfig.dbname)
episodes = db.get('episodecollection');

# GET home page.

exports.index = (req, res) ->
  episodes.find {}, (err, docs)->
    res.render "index",
      episodes: docs