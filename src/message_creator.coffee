class MessageCreator

  _createHostStateChangedMessage: (notification) ->
    return "'#{notification.hostname}' changed it's state
                to '#{notification.hostState}'
                was '#{notification.lastHostState}'"

  _createServiceStateChangedMessage: (notification) ->
    return "#{notification.serviceDescription} on '#{notification.hostname} changed it's state'
                    to '#{notification.lastServiceState}'
                    was '#{notification.serviceState}'"

  message: (notification) ->
    message = ''
    if notification.hostStateChanged()
      message += @_createHostStateChangedMessage(notification)
    if notification.serviceStateChanged()
      message += @_createServiceStateChangedMessage(notification)
    if not message
      message += "I don't have any idea how to interpret the stuff Icinga is sending."

    return message

module.exports = MessageCreator
