# Description:
#   Add reminders
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot <날짜형식>에 <action>(가라고|하라고|라고) 알려줘
#
# Author:
#   mnpk<mnncat@gmail.com>

sugar = require('sugar')

class Reminders
  constructor: (@robot) ->
    @cache = []
    @current_timeout = null

    @robot.brain.on 'loaded', =>
      if @robot.brain.data.reminders
        @cache = @robot.brain.data.reminders
        @queue()

  add: (reminder) ->
    @cache.push reminder
    @cache.sort (a, b) -> a.due - b.due
    @robot.brain.data.reminders = @cache
    @queue()

  removeFirst: ->
    reminder = @cache.shift()
    @robot.brain.data.reminders = @cache
    return reminder

  queue: ->
    clearTimeout @current_timeout if @current_timeout
    if @cache.length > 0
      now = new Date().getTime()
      @removeFirst() until @cache.length is 0 or @cache[0].due > now
      if @cache.length > 0
        trigger = =>
          reminder = @removeFirst()
          @robot.send reminder.for, reminder.for.name + '님, ' + reminder.action + ' 하실 시간이 되었습니다.'
          @queue()
        @current_timeout = setTimeout trigger, @cache[0].due - now

class Reminder
  constructor: (@for, @time, @action) ->
    @time.replace(/^\s+|\s+$/g, '')

    periods =
      weeks:
        value: 0
        regex: "weeks?"
      days:
        value: 0
        regex: "days?"
      hours:
        value: 0
        regex: "hours?|hrs?"
      minutes:
        value: 0
        regex: "minutes?|mins?"
      seconds:
        value: 0
        regex: "seconds?|secs?"

    for period of periods
      pattern = new RegExp('^.*?([\\d\\.]+)\\s*(?:(?:' + periods[period].regex + ')).*$', 'i')
      matches = pattern.exec(@time)
      periods[period].value = parseInt(matches[1]) if matches

    @due = new Date().getTime()
    @due += ((periods.weeks.value * 604800) + (periods.days.value * 86400) + (periods.hours.value * 3600) + (periods.minutes.value * 60) + periods.seconds.value) * 1000

  dueDate: ->
    dueDate = new Date @due
    dueDate.toLocaleString()

module.exports = (robot) ->

  reminders = new Reminders robot

  robot.respond /(((?!(에)).)*)\s*에\s*(((?!(\s*(가라고|이라고|하라고|라고))).)*)\s*(가라고|이라고|하라고|라고)\s*알려줘/i, (msg) ->
    time = msg.match[1]
    action = msg.match[4]
    console.log(time, action)
    # Compute the actual time using magic.
    Date.setLocale 'ko'
    parsedDate = Date.create time
    if parsedDate.isValid() and parsedDate.isFuture()
      # We got a valid date, so let's pass it on in the format that we normally expect
      strTime = (parsedDate.secondsFromNow() + 1) + ' seconds'
      reminder = new Reminder msg.message.user, strTime, action
      reminders.add reminder
      msg.send '네, ' + time + ', ' + action + ', 기억하겠습니다.'
    else
      msg.send '날짜 형식(' + time + ')을 파싱할 수 없습니다. http://sugarjs.com/dates 를 참고하세요.'
