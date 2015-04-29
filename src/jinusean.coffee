# Description:
#   지누션밤~
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   mnpk <mnncat@gmail.com>

module.exports = (robot) ->
    robot.hear /오늘\s*밤은\s*무슨\s*밤/, (msg) ->
        msg.send "지누션밤~:sunglasses:"
