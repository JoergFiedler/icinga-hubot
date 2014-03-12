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
  "takes care of it and left a message: '%MESSAGE%.",
  "Follow the hero! '%USER%' got bothered by '%PROBLEM%' and takes care of it. I was " +
  "asked to relay the following message for you: '%MESSAGE%'"
]

problemMessage = "Houston, we've had a problem."
recoverMessage = "Problem solved. As you are!"

class MessageCreator

  _random: (messages) ->
    selected = Math.floor(Math.random() * messages.length)
    return messages[selected]

  _createDowntimeStartMessage: (notification) ->
    if notification.isHostNotification()
      return "Downtime started for host '#{notification.hostname()}'. " +
      "Seems to be a very good time to go for a cup of coffee."
    else
      return "Downtime started for service '#{notification.serviceDescription()}' on host " +
      "'#{notification.hostname()}'. Seems to be a very good time to go for a cup of coffee."

  _createDowntimeCancelledMessage: (notification) ->
    if notification.isHostNotification()
      return "Downtime cancelled for host '#{notification.hostname()}'. Back to work guys."
    else
      return "Downtime cancelled for service '#{notification.serviceDescription()}' on host " +
      "'#{notification.hostname()}'. Back to work guys"

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

  _addStateChangedMessage: (messages, notification, isProblem) ->
    if notification.isHostNotification()
      messages.push @_createHostStateChangedMessage(notification)
    else if notification.isServiceNotification()
      messages.push @_createServiceStateChangedMessage(notification)
      if isProblem && notification.serviceActionUrl()
        messages.push encodeURI("#{notification.serviceActionUrl()}&from=-1h&width=1024&height=800")
    else
      messages.push "It's not a host and it's also not a service. So, what could it possibly be." +
                    "I really don't know and I have to tell ya' I really don't care!"

  messages: (notification) ->
    messages = []

    if notification.isProblem()
      messages.push problemMessage
      @_addStateChangedMessage(messages, notification, true)
    else if notification.isRecovery()
      messages.push recoverMessage
      @_addStateChangedMessage(messages, notification, false)
    else if notification.isDowntimeStart()
      messages.push @_createDowntimeStartMessage(notification)
    else if notification.isDowntimeCancelled()
      messages.push @_createDowntimeCancelledMessage(notification)
    else if notification.isAcknowledgement()
      template = @_random(acknowledgeMessages)
      template = template.replace(/%MESSAGE%/, notification.comment())
      template = template.replace(/%USER%/, notification.author())
      template = template.replace(/%PROBLEM%/, @_problemDescription(notification))
      messages.push template
    else
      messages.push 'Unknown Icinga notification type.'

    return messages

module.exports = MessageCreator
