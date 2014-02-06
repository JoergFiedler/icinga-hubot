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

module.exports = (robot) ->
  robot.router.post '/hubot/icinga-hubot/notify', (req, res) ->
    data = req.body

    res.statusCode = 201
    res.end()

    envelope = {}
    envelope.room = data.ICINGA_CONTACTADDRESS0

    robot.send envelope, JSON.stringify(data)

  robot.respond /hello/, (msg) ->
    msg.reply "hello!"

  robot.hear /orly/, ->
    msg.send "yarly"
