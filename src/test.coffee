# Hubot classes
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage
# Load assertion methods to this scope
chai = require 'chai'
nock = require 'nock'
{ expect } = chai

robot = new Robot null, 'mock-adapter', yes, 'TestHubot'

robot.adapter.on 'connected', ->
  # Project script
  robot.loadFile path.resolve('.'), 'cups.coffee'
  # Path to scripts bundled in hubot npm module
  hubotScripts = path.resolve 'node_modules', 'hubot', 'src', 'scripts'
  robot.loadFile hubotScripts, 'help.coffee'


do waitForHelp = ->
  if robot.helpCommands().length > 0
    do done
  else
    setTimeout waitForHelp, 100

describe 'help', ->
  it 'should have 3', (done)->
    expect(robot.helpCommands()).to.have.length 3
    do done
  it 'should parse help', (done)->
    adapter.on 'send', (envelope, strings)->
      try
        expect(strings[0]).to.equal """
        TestTestHubot help - Displays all of the help commands that TestHubot knows about.
        TestTestHubot help <query> - Displays all help commands that match <query>.
        TestTestHubot screenshot me <url> - Takes screenshot with Browser Stack.
        """
        do done
      catch e
        done e
    adapter.receive new TextMessage user, 'TestHubot help'
