# Description
#   A Hubot script that greets us when this script loaded.
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   mnpk <mnncat@gmail.com>
#
module.exports = (robot) ->
  say_hello = -> robot.messageRoom 'dev7', 'hubot, 기동됨'
  setTimeout say_hello, 5000
