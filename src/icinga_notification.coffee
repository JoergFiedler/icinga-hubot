icingaVariables =
  ircChannel: 'ICINGA_CONTACTADDRESS0'
  hostname: 'ICINGA_HOSTDISPLAYNAME'
  hostOutput: 'ICINGA_HOSTOUTPUT'
  hostStateId: 'ICINGA_HOSTSTATEID'
  serviceOutput: 'ICINGA_SERVICEOUTPUT'
  serviceDescription: 'ICINGA_SERVICEDESC'
  serviceDescriptionLong: 'ICINGA__SERVICEDESCRIPTION'
  serviceStateId: 'ICINGA_SERVICESTATEID'
  serviceProblemId: 'ICINGA_SERVICEPROBLEMID'
  lastServiceProblemId: 'ICINGA_LASTSERVICEPROBLEMID'
  hostProblemId: 'ICINGA_HOSTPROBLEMID'
  lastHostProblemId: 'ICINGA_LASTHOSTPROBLEMID'

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
    (@icingaData[icingaVariables.hostProblemId] != @icingaData[icingaVariables.lastHostProblemId])

  serviceStateChanged: ->
    return !!@icingaData &&
    (@icingaData[icingaVariables.serviceProblemId] != @icingaData[icingaVariables.lastServiceProblemId])

module.exports = IcingaNotification
