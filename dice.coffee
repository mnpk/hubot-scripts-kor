# Description:
#   주사위를 굴리자
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot 주사위 - 6면 주사위를 굴린다.
#   hubot 주사위 x - x면 주사위를 굴린다.
#
# Author:
#   mnpk

josa = ["이", "이", "가", "이", "가", "가", "이", "이", "이", "가"]

module.exports = (robot) ->
  robot.respond /주사위/, (msg) ->
    n = roll(6)
    msg.reply "#{msg.message.user.name}님이 주사위를 굴려 #{n}#{josa[n%10]} 나왔습니다. (1 - 6)"

  robot.respond /주사위 (\d+)/i, (msg) ->
    x = parseInt msg.match[1]
    if x < 1
      msg.reply "왜죠?"
    else
      n = roll(x)
      msg.reply "#{msg.message.user.name}님이 주사위를 굴려 #{n}#{josa[n%10]} 나왔습니다. (1 - #{x})"

roll = (sides) ->
  1 + Math.floor(Math.random() * sides)
