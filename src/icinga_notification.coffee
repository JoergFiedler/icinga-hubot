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
    return @icingaData[icingaVariables.hostStateId]

  lastHostState: ->
    return @icingaData[icingaVariables.hostLastStateId]

  serviceState: ->
    return @icingaData[icingaVariables.serviceStateId]

  lastServiceState: ->
    return @icingaData[icingaVariables.serviceLastStateId]

  hostStateChanged: ->
    return !!@icingaData &&
    (@icingaData[icingaVariables.hostStateId] != @icingaData[icingaVariables.hostLastStateId])

  serviceStateChanged: ->
    return !!@icingaData &&
    (@icingaData[icingaVariables.serviceStateId] != @icingaData[icingaVariables.serviceLastStateId])

  serviceIsStillFailing: ->
    @icingaData[icingaVariables.serviceStateId] != 0 &&
    (@icingaData[icingaVariables.serviceStateId] == @icingaData[icingaVariables.serviceLastStateId])

  hostIsStillFailing: ->
    @icingaData[icingaVariables.hostStateId] != 0 &&
    (@icingaData[icingaVariables.hostStateId] == @icingaData[icingaVariables.hostStateId])

module.exports = IcingaNotification
