# Description:
#   sigh
#
# Commands:
#   None
#

sigh = [
  "ㅎ ㅏ ...",
  "후 ...",
  "ㅇ ㅔ ㅎ ㅕ ..."
]

module.exports = (robot) ->
  robot.hear /한숨/, (msg) ->
      text = msg.random sigh
      msg.send msg.random sigh
