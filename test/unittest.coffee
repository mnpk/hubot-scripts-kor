blanket = require 'blanket'
tbot = require 'tbot'
path = require 'path'

describe 'hubot', ->
  testbot = null
 
  before ->
    matchesBlanket = (path) -> path.match /node_modules\/blanket/
    runningTestCoverage = Object.keys(require.cache).filter(matchesBlanket).length > 0
    if runningTestCoverage
      require('require-dir')("#{__dirname}/../src", {recurse: true, duplicates: true})

  # create
  beforeEach (done)->
    testbot = new tbot done
    testbot.load './src/diagnostics.coffee'
    testbot.load './src/dice.coffee'
    testbot.load './src/jinusean.coffee'

  afterEach ->
    do testbot.clear


  describe 'diagnostics', ->
    it 'should send 퐁', ->
      testbot.send 'hubot 핑', (res)->
        assert.equal res, '퐁'

  describe '주사위', ->
    it 'should reply "왜죠?" on "주사위 0"', ->
      testbot.reply '주사위 0', (res)->
        assert.equal res, '왜죠?'

    it 'should send result withn 1 - 6 on "주사위"', ->
      testbot.send '주사위', (res)->
        pattern = /mocha님이 주사위를 굴려 (\d)[이가] 나왔습니다. \(1 - 6\)/
        assert res.match(pattern)
        assert res.match(pattern)[1] > 1
        assert res.match(pattern)[1] > 6

  describe 'jinusean', ->
    it 'should send 지누션밤', ->
      testbot.send '오늘밤은무슨밤', (res)->
        assert.equal res, '지누션밤~:sunglasses:'
      testbot.send '오늘 밤은 무슨 밤?', (res)->
        assert.equal res, '지누션밤~:sunglasses:'
