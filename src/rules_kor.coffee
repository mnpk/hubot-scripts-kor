# Description:
#   Make sure that hubot knows the rules.
#
# Commands:
#   hubot 원칙 - 로봇3원칙을 기억하고 있는지 확인함
#

rules = [
  "제1원칙: 로봇은 인간에게 해를 입혀서는 안 된다. 그리고 위험에 처한 인간을 모른 척해서도 안 된다.",
  "제2원칙: 제1원칙에 위배되지 않는 한, 로봇은 인간의 명령에 복종해야 한다.",
  "제3원칙: 제1원칙과 제2원칙에 위배되지 않는 한, 로봇은 로봇 자신을 지켜야 한다."
  ]

module.exports = (robot) ->
  # robot.respond /(what are )?the (three |3 )?(rules|laws)/i, (msg) ->
  robot.respond /(로봇)?(의)?\s*(삼|3)?\s*원칙/i, (msg) ->
    msg.send rules.join('\n')
