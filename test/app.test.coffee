request = require "supertest"
app = require "#{__dirname}/../app"

describe 'pages', ->
  it 'should have a home page', (done) ->
    request app
      .get '/'
      .expect 200, done
  it 'should have a schedule page', (done) ->
    request(app)
      .get('/schedule')
      .expect(200, done)
  it 'should have a 404', (done) ->
    request(app)
      .get('/garth')
      .expect(404, done)
