hostStates =
  0: "Up. Nothing to worry about. As you are!"
  1: "Host down! Host down! Host down! .. Panic"
  2: 'Not reachable, I really do not haven any glue where it might be gone.'

serviceStates =
  0: "Ok, providing it's service as expected."
  1: "Warn, someone should take a look at it, I guess!"
  2: "Critical, we are in troubles Sir! Fix it!"
  3: "Unknown, actually I don't know how it's behaving. Check for yourself."

class MessageCreator

  _createHostStateChangedMessage: (notification) ->
    return "'#{notification.hostname()}' - #{hostStates[notification.hostState()]}"

  _createServiceStateChangedMessage: (notification) ->
    return "#{notification.serviceDescription()} on '#{notification.hostname()}' - #{serviceStates[notification.serviceState()]}"

  _createStillFailingMessage: (info) ->
    return "#{info} Really guys. At least one of you should take care of it."

  messages: (notification) ->
    messages = []
    if notification.hostStateChanged()
      messages.push(@_createHostStateChangedMessage(notification))
    else if notification.serviceStateChanged()
      messages.push(@_createServiceStateChangedMessage(notification))
    else if notification.hostIsStillFailing()
      messages.push(@_createStillFailingMessage(
        "'#{notification.hostname()}' still has problems."))
    else if notification.serviceIsStillFailing()
      messages.push(@_createStillFailingMessage(
        "'#{notification.serviceDescription()}' on '#{notification.hostname()}' still has problems."))

    if not messages or messages.length == 0
      messages.push("Can't make any sense out of the stuff Icinga is sending.")

    return messages

module.exports = MessageCreator
