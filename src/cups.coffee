# Description:
#   cups
#
# Commands:
#   None
#

cups = [
  "다들 이렇게 불러보세요. 쿱스 쿱스 쿱스",
  "쿱스 쿱스 쿱스",
  "쿱스 쿱스"
]

module.exports = (robot) ->
  robot.hear /쿱스/, (msg) ->
    text = msg.random cups
    msg.send msg.random cups
