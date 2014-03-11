hostStates =
  0: "Up and running. Nothing to worry about."
  1: "Host down! Host down! Host down! .. Panic"
  2: 'Not reachable, I really do not have any idea where it might be gone.'

serviceStates =
  0: "Ok, working as expected."
  1: "Warn, I guess someone should take a look at it!"
  2: "Critical, we are in troubles Sir! Fix it!"
  3: "Unknown, actually I don't know how it's behaving. Check for yourself."

problemMessage = "Houston, we've had a problem."
recoverMessage = "Problem solved. As you are!"

class MessageCreator

  _createHostStateChangedMessage: (message, notification) ->
    return "#{message} '#{notification.hostname()}': #{hostStates[notification.hostState()]}"

  _createServiceStateChangedMessage: (message, notification) ->
    return "#{message} '#{notification.serviceDescription()}' on '#{notification.hostname()}': #{serviceStates[notification.serviceState()]}"

  messages: (notification) ->
    messages = []

    if notification.isProblem()
      statusMessage = problemMessage
    else if notification.isRecovery()
      statusMessage = recoverMessage
    else
      statusMessage = 'Unknown Icinga notification type.'

    if notification.isHostNotification()
      messages.push(@_createHostStateChangedMessage(statusMessage, notification))
      messages.push("#{notification.hostNotesUrl()}")
    else
      messages.push(@_createServiceStateChangedMessage(statusMessage, notification))
      messages.push("#{notification.serviceNotesUrl()}")

    return messages

module.exports = MessageCreator
