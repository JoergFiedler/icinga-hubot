# Description
#   A hubot script that takes notification messages from Icinga and post them to any IRC channel
#
# Author:
#   Joerg Fiedler

IcingaNotification = require './icinga_notification'
MessageCreator = require './message_creator'
messageCreator = new MessageCreator()

module.exports = (robot) ->
  robot.router.post '/hubot/icinga-hubot/notify', (req, res) ->
    icingaNotification = new IcingaNotification(req.body)

    res.statusCode = 201
    res.end()

    envelope = {}
    envelope.room = icingaNotification.ircChannel()

    messages = messageCreator.messages(icingaNotification)
    for message in messages
      robot.send envelope, message
