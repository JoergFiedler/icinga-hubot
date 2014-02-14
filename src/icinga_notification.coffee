icingaVariables =
  ircChannel: 'ICINGA_CONTACTADDRESS0'
  hostname: 'ICINGA_HOSTDISPLAYNAME'
  hostOutput: 'ICINGA_HOSTOUTPUT'
  hostStateId: 'ICINGA_HOSTSTATEID'
  hostLastStateId: 'ICINGA_LASTHOSTSTATEID'
  serviceOutput: 'ICINGA_SERVICEOUTPUT'
  serviceDescription: 'ICINGA_SERVICEDESC'
  serviceDescriptionLong: 'ICINGA__SERVICEDESCRIPTION'
  serviceStateId: 'ICINGA_SERVICESTATEID'
  serviceLastStateId: 'ICINGA_LASTSERVICESTATEID'

hostStates =
  0: "Up. Nothing to worry about. Everything is working fine."
  1: "Down! Down! Down! .. Panic"
  2: 'Not reachable, I really do not haven any glue where it might be gone.'

serviceStates =
  0: "Ok, providing it's service as expected."
  1: "Warn, someone should take a look at it, I guess!"
  2: "Critical, we are in troubles now. Fix it!"
  3: "Unknown, actually I don't know how it's behaving. Check for yourself."

class IcingaNotification
  constructor: (icingaData) ->
    @icingaData = icingaData

  ircChannel: ->
    return @icingaData[icingaVariables.ircChannel]

  hostname: ->
    return @icingaData[icingaVariables.hostname]

  serviceDescription: ->
    return @icingaData[icingaVariables.serviceDescription]

  hostState: ->
    return hostStates[@icingaData[icingaVariables.hostStateId]]

  lastHostState: ->
    return hostStates[@icingaData[icingaVariables.hostLastStateId]]

  serviceState: ->
    return serviceStates[@icingaData[icingaVariables.serviceStateId]]

  lastServiceState: ->
    return serviceStates[@icingaData[icingaVariables.serviceLastStateId]]

  hostStateChanged: ->
    return !!@icingaData &&
    (@icingaData[icingaVariables.hostStateId] != @icingaData[icingaVariables.hostLastStateId])

  serviceStateChanged: ->
    return !!@icingaData &&
    (@icingaData[icingaVariables.serviceStateId] != @icingaData[icingaVariables.serviceLastStateId])

module.exports = IcingaNotification
