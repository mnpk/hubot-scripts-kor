# Description
#   투표
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot 투표시작 item1, item2, item3, ...
#   hubot N번에 한 표
#   hubot item1에 한 표
#   hubot 투표현황
#   hubot 투표마감
#
# Notes:
#   None
#
# Author:
#   antonishen(https://github.com/joshingly/hubot-voting)
#   korean version by mnpk<mnncat@gmail.com>

module.exports = (robot) ->
  robot.voting = {}

  robot.respond /투표\s*시작 (.+)$/, (msg) ->

    if robot.voting.votes?
      msg.send "투표가 이미 진행중입니다"
      sendChoices (msg)
    else
      robot.voting.votes = {}
      createChoices msg.match[1]

      msg.send "투표가 시작되었습니다."
      sendChoices(msg)

  robot.respond /투표\s*(마감|종료|끝)$/, (msg) ->
    if robot.voting.votes?
      console.log robot.voting.votes

      results = tallyVotes()

      response = "투표를 종료합니다. 결과는..."
      for choice, index in robot.voting.choices
        response += "\n#{choice}: #{results[index]}"

      msg.send response

      delete robot.voting.votes
      delete robot.voting.choices
    else
      msg.send "종료할 투표가 없습니다."


  robot.respond /투표(현황)?$/i, (msg) ->
    results = tallyVotes()
    sendChoices(msg, results)

  robot.respond /(((?![ 번에]).)*)\s*[번에]*\s*[한투]\s*표$/, (msg) ->

    choice = null

    re = /\d{1,2}$/i
    if re.test(msg.match[1])
      choice = parseInt msg.match[1], 10
    else
      choice = robot.voting.choices.indexOf msg.match[1]

    console.log choice

    sender = robot.brain.usersForFuzzyName(msg.message.user['name'])[0].name

    if validChoice choice
      robot.voting.votes[sender] = choice
      msg.send "#{sender} 님이 #{robot.voting.choices[choice]}에 투표하셨습니다."
    else
      msg.send "#{sender}: 잘못된 투표입니다."

  createChoices = (rawChoices) ->
    robot.voting.choices = rawChoices.split(/, /)

  sendChoices = (msg, results = null) ->

    if robot.voting.choices?
      response = ""
      for choice, index in robot.voting.choices
        response += "#{index}: #{choice}"
        if results?
          response += " -- 총 투표: #{results[index]}"
        response += "\n" unless index == robot.voting.choices.length - 1
    else
      msg.send "진행 중인 투표가 없습니다."

    msg.send response

  validChoice = (choice) ->
    numChoices = robot.voting.choices.length - 1
    0 <= choice <= numChoices

  tallyVotes = () ->
    results = (0 for choice in robot.voting.choices)

    voters = Object.keys robot.voting.votes
    for voter in voters
      choice = robot.voting.votes[voter]
      results[choice] += 1

    results
