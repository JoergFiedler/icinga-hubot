chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

IcingaNotification = require '../src/icinga_notification'

describe 'IcingaNotification', ->
  describe 'ircChannel()', ->
    it 'returns the irc channel', ->
      icingaData =
        ICINGA_CONTACTADDRESS0: 'ircChannel'

      expect(new IcingaNotification(icingaData).ircChannel()).to.equal('ircChannel')

  describe 'hostname()', ->
    it 'returns the hostname', ->
      icingaData =
        ICINGA_HOSTDISPLAYNAME: 'hostname'

      expect(new IcingaNotification(icingaData).hostname()).to.equal('hostname')

  describe 'isProblem()', ->
    it 'returns "true" if the notification type is "PROBLEM"', ->
      icingaData =
        ICINGA_NOTIFICATIONTYPE: 'PROBLEM'

      expect(new IcingaNotification(icingaData).isProblem()).to.equal(true)

    it 'returns "false" if the notification type is not "PROBLEM', ->
      icingaData =
        ICINGA_NOTIFICATIONTYPE: ''

      expect(new IcingaNotification(icingaData).isProblem()).to.equal(false)

  describe 'isAcknowledgement()', ->
    it 'returns "true" if the notification type is "ACKNOWLEDGMENT"', ->
      icingaData =
        ICINGA_NOTIFICATIONTYPE: 'ACKNOWLEDGEMENT'

      expect(new IcingaNotification(icingaData).isAcknowledgement()).to.equal(true)

    it 'returns "false" if the notification type is not "ACKNOWLEDGEMENT', ->
      icingaData =
        ICINGA_NOTIFICATIONTYPE: ''

      expect(new IcingaNotification(icingaData).isAcknowledgement()).to.equal(false)

  describe 'isRecovery()', ->
    it 'returns "true" if the notification type is "RECOVERY', ->
      icingaData =
        ICINGA_NOTIFICATIONTYPE: 'RECOVERY'

      expect(new IcingaNotification(icingaData).isRecovery()).to.equal(true)

    it 'returns "false" if the notification type is not "RECOVERY"', ->
      icingaData =
        ICINGA_NOTIFICATIONTYPE: ''

      expect(new IcingaNotification(icingaData).isRecovery()).to.equal(false)

  describe 'isServiceNotification()', ->
    it 'returns "true" if service problem id is set', ->
      icingaData =
        ICINGA_SERVICEPROBLEMID: 1
      expect(new IcingaNotification(icingaData).isServiceNotification()).to.equal(true)

    it 'returns "true" if last service problem id is set', ->
      icingaData =
        ICINGA_LASTSERVICEPROBLEMID: '1'
      expect(new IcingaNotification(icingaData).isServiceNotification()).to.equal(true)

    it 'returns "false" if neither last service problem id or last service problem id is set', ->
      icingaData =
        ICINGA_ANY: 'any'

      expect(new IcingaNotification(icingaData).isServiceNotification()).to.equal(false)

  describe 'isHostNotification()', ->
    it 'returns "false" if service problem id is set', ->
      icingaData =
        ICINGA_SERVICEPROBLEMID: 1
      expect(new IcingaNotification(icingaData).isHostNotification()).to.equal(false)

    it 'returns "false" if last service problem id is set', ->
      icingaData =
        ICINGA_LASTSERVICEPROBLEMID: '1'
      expect(new IcingaNotification(icingaData).isHostNotification()).to.equal(false)

    it 'returns "true" if neither last service problem id or last service problem id is set', ->
      icingaData =
        ICINGA_ANY: 'any'

      expect(new IcingaNotification(icingaData).isHostNotification()).to.equal(true)
