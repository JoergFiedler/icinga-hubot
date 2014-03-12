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
  notificationType: 'ICINGA_NOTIFICATIONTYPE'
  hostNotesUrl: 'ICINGA_HOSTNOTESURL'
  serviceNotesUrl: 'ICINGA_SERVICENOTESURL'

class IcingaNotification
  constructor: (icingaData) ->
    @icingaData = icingaData

  ircChannel: ->
    return @icingaData[icingaVariables.ircChannel]

  hostname: ->
    return @icingaData[icingaVariables.hostname]

  serviceDescription: ->
    return @icingaData[icingaVariables.serviceDescription]

  isProblem: ->
    return @icingaData[icingaVariables.notificationType] == 'PROBLEM'

  isRecovery: ->
    return @icingaData[icingaVariables.notificationType] == 'RECOVERY'

  hostState: ->
    return @icingaData[icingaVariables.hostStateId]

  isServiceNotification: ->
    return !!@icingaData[icingaVariables.serviceProblemId] || !!@icingaData[icingaVariables.lastServiceProblemId]

  isHostNotification: ->
    return !@isServiceNotification()

  serviceState: ->
    return @icingaData[icingaVariables.serviceStateId]

  hostNotesUrl: ->
    return @icingaData[icingaVariables.hostNotesUrl]

  serviceNotesUrl: ->
    return @icingaData[icingaVariables.serviceNotesUrl]

  isAcknowledgement: ->
    return @icingaData[icingaVariables.notificationType] == 'ACKNOWLEDGEMENT'

module.exports = IcingaNotification
