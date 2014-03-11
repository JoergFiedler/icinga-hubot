# Description
#   A hubot script that takes notification messages from Icinga and post them to any IRC channel
#
# Author:
#   Joerg Fiedler

logLevel = process.env.HUBOT_LOG_LEVEL
IcingaNotification = require './icinga_notification'
MessageCreator = require './message_creator'
messageCreator = new MessageCreator()

module.exports = (robot) ->
  robot.router.post '/hubot/icinga-hubot/notify', (req, res) ->
    if logLevel && logLevel.match(/debug/i)
      console.log(req.body)

    icingaNotification = new IcingaNotification(req.body)

    res.statusCode = 201
    res.end()

    envelope = {}
    envelope.room = icingaNotification.ircChannel()

    messages = messageCreator.messages(icingaNotification)
    robot.send envelope, messages.join(' ')
