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

  describe 'hostStateChanged()', ->
    it 'returns "false" if no data is given', ->
      expect(new IcingaNotification().hostStateChanged()).to.equal(false)

    it 'returns "true" if state and last state do not match', ->
      icingaData =
        ICINGA_HOSTPROBLEMID: 1

      expect(new IcingaNotification(icingaData).hostStateChanged()).to.equal(true)

    it 'returns "false" if state and last state do match', ->
      icingaData =
        ICINGA_LASTHOSTPROBLEMID: 1
        ICINGA_HOSTPROBLEMID: 1

      expect(new IcingaNotification(icingaData).hostStateChanged()).to.equal(false)

  describe 'serviceStateChanged()', ->
    it 'returns "false" if no data is given', ->
      expect(new IcingaNotification().serviceStateChanged()).to.equal(false)

    it 'returns "true" if state and last state do not match', ->
      icingaData =
        ICINGA_LASTSERVICEPROBLEMID: 1

      expect(new IcingaNotification(icingaData).serviceStateChanged()).to.equal(true)

    it 'returns "false" if state and last state do match', ->
      icingaData =
        ICINGA_LASTSERVICEPROBLEMID: 1
        ICINGA_SERVICEPROBLEMID: 1

      expect(new IcingaNotification(icingaData).serviceStateChanged()).to.equal(false)
