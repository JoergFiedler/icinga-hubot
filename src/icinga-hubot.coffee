# Description
#   A hubot script that takes notification messages from Icinga and post them to any IRC channel
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Joerg Fiedler[@<org>]

IcingaNotification = require './icinga_notification'
MessageCreator = require './message_creator'
messageCreator = new MessageCreator()

module.exports = (robot, messageCreator) ->
  robot.router.post '/hubot/icinga-hubot/notify', (req, res) ->
    icingaNotification = new IcingaNotification(req.body)

    res.statusCode = 201
    res.end()

    envelope = {}
    envelope.room = icingaNotification.ircChannel()

    robot.send envelope, messageCreator.message(icingaNotification)

  robot.respond /hello/, (msg) ->
    msg.reply "hello!"

  robot.hear /orly/, ->
    msg.send "yarly"
