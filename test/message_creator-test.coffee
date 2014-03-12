chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

MessageCreator = require '../src/message_creator'

describe 'MessageCreator', ->
  beforeEach ->
    @messageCreator = new MessageCreator()
    @icingaNotification =
      hostname: ->
        return 'any hostname'
      hostState: ->
        return 1
      serviceState: ->
        return 2
      serviceDescription: ->
        return 'service description'
      isHostNotification: ->
        return false
      isServiceNotification: ->
        return false
      isProblem: ->
        return false
      isRecovery: ->
        return false
      hostActionUrl: ->
        return ''
      serviceActionUrl: ->
        return ''
      comment: ->
        return 'comment'
      author: ->
        return 'author'
      isAcknowledgement: ->
        return false
      isDowntimeStart: ->
        return false
      isDowntimeCancelled: ->
        return false

  describe 'messages()', ->
    describe 'is a problem', ->
      beforeEach ->
        @icingaNotification.isProblem = ->
          return true

      it 'message should contain problem message', ->
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/Houston/)

      describe 'is a host notification', ->
        beforeEach ->
          @icingaNotification.isHostNotification = ->
            return true
          @icingaNotification.hostActionUrl = ->
            return 'any_host_notes_url'

        it 'message contains the hostname if it is a host notification', ->
          expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/any hostname/)

      describe 'is a service notification', ->
        beforeEach ->
          @icingaNotification.isServiceNotification = ->
            return true
          @icingaNotification.serviceActionUrl = ->
            return 'any_service_notes_url'

        it 'message contains the service name if it is a service notification', ->
          expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/service description/)

        it 'message contains the service notes url', ->
          expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/any_service_notes_url/)

        it 'message does not contain the service notes url, if it is not provided by icinga', ->
          @icingaNotification.serviceActionUrl = ->
            return undefined
          expect(@messageCreator.messages(@icingaNotification).join(' ')).to.not.match(/undefined/)

    describe 'isRecovery', ->
      beforeEach ->
        @icingaNotification.isRecovery = ->
          return true

      it 'message should contain problem message', ->
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/Problem solved/)

      it 'message should contains the hostname if it is a host notification', ->
        @icingaNotification.isHostNotification = ->
          return true
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/any hostname/)

      it 'message should contains the service name if it is a service notification', ->
        @icingaNotification.isServiceNotification = ->
          return true
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/service description/)

    describe 'isAcknowledgement', ->
      beforeEach ->
        @icingaNotification.isAcknowledgement = ->
          return true

      it 'message should contains the user who takes care of a problem', ->
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/author/)

      it 'message should contain the problem which is taken care of', ->
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/Critical/)

      it 'message should contains the message the user left behind', ->
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/comment/)

    describe 'isDowntimeStart', ->
      it 'message contains downtime start string if it is a downtime start icinga notification', ->
        @icingaNotification.isDowntimeStart = ->
          return true
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/Downtime started/)

      it 'message does not contain downtime start string if it is not a downtime start icinga notification', ->
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.not.match(/Downtime started/)

    describe 'isDowntimeCancelled', ->
      it 'message contains downtime cancelled string if it is a downtime cancelled icinga notification', ->
        @icingaNotification.isDowntimeCancelled = ->
          return true
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.match(/Downtime cancelled/)

      it 'message does not contain downtime cancelled string if it is not a downtime cancelled icinga notification', ->
        expect(@messageCreator.messages(@icingaNotification).join(' ')).to.not.match(/Downtime cancelled/)
