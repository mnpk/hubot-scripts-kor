# Description:
#   hubot spying jira
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
  robot.router.post '/hubot/chat-jira-comment/:room', (req, res) ->
    room = req.params.room
    body = req.body
    if body.webhookEvent == 'jira:issue_updated' && body.comment
      issue = "#{body.issue.key} #{body.issue.fields.summary}"
      url = "#{process.env.HUBOT_JIRA_URL}/browse/#{body.issue.key}"
      robot.messageRoom room, "*#{issue}* _(#{url})_\n@#{body.comment.author.name}님의 댓글:\n```#{body.comment.body}```"
    res.send 'OK'

  robot.router.post '/hubot/chat-to/:room', (req, res) ->
    room = req.params.room
    body = req.body
    robot.messageRoom room, body.comment
    res.send 'OK'
