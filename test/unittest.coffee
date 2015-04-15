path = require 'path'
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage
# Load assertion methods to this scope
chai = require 'chai'
# nock = require 'nock'
{ expect } = chai


describe 'hubot', ->
  robot = null
  user = null
  adapter = null
  beforeEach (done)->
    robot = new Robot null, 'mock-adapter', yes, 'hubot'
    robot.adapter.on 'connected', ->
      # Project script
      process.env.HUBOT_AUTH_ADMIN = "1"
      hubotScripts = path.resolve 'node_modules', 'hubot', 'src', 'scripts'
      robot.loadFile hubotScripts, 'auth.coffee'
      # load files to test
      # require("../index") robot
      robot.loadFile path.resolve('.', 'src'), 'diagnostics_kor.coffee'
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
    it 'ping', (done)->
      adapter.on 'send', (env, str)->
        expect(str[0]).to.equal '퐁'
        do done
      adapter.receive new TextMessage user, 'hubot 핑'

  describe '주사위', ->
    it '"주사위 0"은 예외처리', (done)->
      adapter.on 'reply', (env, str)->
        expect(str[0]).to.equal "왜죠?"
        do done
      adapter.receive new TextMessage user, "주사위 0"

    it '"주사위"는 1-6까지', (done)->
      adapter.on 'send', (env, str)->
        console.log str[0]
        pattern = /mocha님이 주사위를 굴려 (\d)[이가] 나왔습니다. \(1 - 6\)/
        expect(str[0]).match(pattern)
        expect(str[0].match(pattern)[1]).to.be.within(1, 6)
        do done
      adapter.receive new TextMessage user, "주사위"
