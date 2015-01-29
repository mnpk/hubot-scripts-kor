# Description:
#   Hubot, be polite and say hello.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   안녕 - hubot이 인사 받아줌
#
# Author:
#   mnpk <mnncat@gmail.com>

hellos = [
  "안녕하세요, %",
  "%님, 안녕하세요!"
]
mornings = [
  "%님, 반가워요!",
  "좋은 아침입니다.",
  "반갑습니다.",
  "안녕하세요, %",
  "%님, 안녕하세요!"
]
byes = [
  "안녕히가세요, %님",
  "좋은 밤 보내세요!",
  "조심히 들어가세요!"
]

module.exports = (robot) ->
    robot.hear /안녕/, (msg) ->
        hello = msg.random hellos
        msg.send hello.replace "%", msg.message.user.name

    robot.hear /출근/, (msg) ->
        morning = msg.random mornings
        msg.send morning.replace "%", msg.message.user.name

    robot.hear /퇴근|업무\s*종료/, (msg) ->
        bye = msg.random byes
        msg.send bye.replace "%", msg.message.user.name
