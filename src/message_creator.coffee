hostStates =
  0: "Up and running. Nothing to worry about."
  1: "Host down! Host down! Host down! .. Panic"
  2: 'Not reachable, I really do not have any idea where it might be gone.'

serviceStates =
  0: "Ok, working as expected."
  1: "Warn, I guess someone should take a look at it!"
  2: "Critical, we are in troubles Sir! Fix it!"
  3: "Unknown, actually I don't know how it's behaving. Check for yourself."

acknowledgeMessages = [
  "Finally, someone feels reponsible for error: '%PROBLEM%'. %USER% " +
  "took care of it. The message she left: '%MESSAGE%.",
  "What a boy! '%USER%' is bothered by '%PROBLEM%' and takes care of it. I was "  +
  "asked to relay the following message for you: '%MESSAGE%'"
]

problemMessage = "Houston, we've had a problem."
recoverMessage = "Problem solved. As you are!"

class MessageCreator

  _random: (messages) ->
    selected = Math.floor(Math.random() * messages.length)
    return messages[selected]

  _createHostStateChangedMessage: (notification) ->
    return "'#{notification.hostname()}': #{hostStates[notification.hostState()]}"

  _createServiceStateChangedMessage: (notification) ->
    return "'#{notification.serviceDescription()}' on '#{notification.hostname()}': " +
    "#{serviceStates[notification.serviceState()]}"

  _problemDescription: (notification) ->
    if notification.isHostNotification()
      return @_createHostStateChangedMessage(notification)
    else
      return @_createServiceStateChangedMessage(notification)

  _addStateChangedMessage: (messages, notification) ->
    if notification.isHostNotification()
      messages.push @_createHostStateChangedMessage(notification)
      messages.push "#{notification.hostActionUrl()}" if notification.hostActionUrl()
    else if notification.isServiceNotification()
      messages.push @_createServiceStateChangedMessage(notification)
      messages.push "#{notification.serviceActionUrl()}" if notification.serviceActionUrl()
    else
      messages.push "It's not a host and it's also not a service. So, what could it possibly be." +
                    "I really don't know and I have to tell ya' I really don't care!"

  messages: (notification) ->
    messages = []

    if notification.isProblem()
      messages.push problemMessage
      @_addStateChangedMessage(messages, notification)
    else if notification.isRecovery()
      messages.push recoverMessage
      @_addStateChangedMessage(messages, notification)
    else if notification.isAcknowledgement()
      template = @_random(acknowledgeMessages)
      messages.push template  \
                    .replace(/%MESSAGE%/, notification.comment()) \
                    .replace(/%USER%/, notification.author()) \
                    .replace(/%PROBLEM%/, @_problemDescription(notification))
    else
      messages.push 'Unknown Icinga notification type.'

    return messages

module.exports = MessageCreator
