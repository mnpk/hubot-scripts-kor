path = require 'path'
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage
# Load assertion methods to this scope
chai = require 'chai'
blanket = require 'blanket'
# nock = require 'nock'
{ expect } = chai


describe 'hubot', ->
  robot = null
  user = null
  adapter = null
  before ->
    matchesBlanket = (path) -> path.match /node_modules\/blanket/
    runningTestCoverage = Object.keys(require.cache).filter(matchesBlanket).length > 0
    if runningTestCoverage
      require('require-dir')("#{__dirname}/../src", {recurse: true, duplicates: true})

  beforeEach (done)->
    robot = new Robot null, 'mock-adapter', yes, 'hubot'
    robot.adapter.on 'connected', ->
      # Project script
      process.env.HUBOT_AUTH_ADMIN = "1"
      hubotScripts = path.resolve 'node_modules', 'hubot', 'src', 'scripts'
      robot.loadFile hubotScripts, 'auth.coffee'
      # load files to test
      # require("../index") robot
      robot.loadFile path.resolve('.', 'src'), 'diagnostics.coffee'
      robot.loadFile path.resolve('.', 'src'), 'dice.coffee'
      # create user
      user = robot.brain.userForId '1', {
        name: 'mocha',
        root: '#mocha'
      }
      adapter = robot.adapter
      do done
    do robot.run

  afterEach ->
    do robot.server.close
    do robot.shutdown

  describe 'diagnostics', ->
    it 'should send 퐁 on 핑', (done)->
      adapter.on 'send', (env, str)->
        expect(str[0]).to.equal '퐁'
        do done
      adapter.receive new TextMessage user, 'hubot 핑'

  describe '주사위', ->
    it 'should reply "왜죠?" on "주사위 0"', (done)->
      adapter.on 'reply', (env, str)->
        expect(str[0]).to.equal "왜죠?"
        do done
      adapter.receive new TextMessage user, "주사위 0"

    it 'should send result withn 1 - 6 on "주사위"', (done)->
      adapter.on 'send', (env, str)->
        pattern = /mocha님이 주사위를 굴려 (\d)[이가] 나왔습니다. \(1 - 6\)/
        expect(str[0]).match(pattern)
        expect(str[0].match(pattern)[1]).to.be.within(1, 6)
        do done
      adapter.receive new TextMessage user, "주사위"
