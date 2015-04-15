# Description:
#   create trac links
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_TRAC_URL
#
# Commands:
#   #<Ticket Number> - Displays link to trac ticket
#
# Author:
#   mnpk

module.exports = (robot) ->
  robot.hear /\#([0-9]+)/i, (msg) ->
    msg.send process.env.HUBOT_TRAC_URL + '/ticket/' + msg.match[1]
