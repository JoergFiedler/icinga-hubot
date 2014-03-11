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
      hostNotesUrl: ->
        return ''
      serviceNotesUrl: ->
        return ''

  describe 'messages()', ->
    describe 'is a problem', ->
      beforeEach ->
        @icingaNotification.isProblem = ->
          return true

      it 'message should contain problem message', ->
        expect(@messageCreator.messages(@icingaNotification)).to.match(/Houston/)

      describe 'is a host notification', ->
        beforeEach ->
          @icingaNotification.isHostNotification = ->
            return true
          @icingaNotification.hostNotesUrl = ->
            return 'any_host_notes_url'

        it 'message contains the hostname if it is a host notification', ->
          expect(@messageCreator.messages(@icingaNotification)).to.match(/any hostname/)

        it 'message contains host service url', ->
          expect(@messageCreator.messages(@icingaNotification)).to.match(/any_host_notes_url/)

      describe 'is a service notification', ->
        beforeEach ->
          @icingaNotification.isServiceNotification = ->
            return true
          @icingaNotification.serviceNotesUrl = ->
            return 'any_service_notes_url'

        it 'message contains the service name if it is a service notification', ->
          expect(@messageCreator.messages(@icingaNotification)).to.match(/service description/)

        it 'message contains the service notes url', ->
          expect(@messageCreator.messages(@icingaNotification)).to.match(/any_service_notes_url/)

    describe 'isRecovery', ->
      beforeEach ->
        @icingaNotification.isRecovery = ->
          return true

      it 'message should contain problem message', ->
        expect(@messageCreator.messages(@icingaNotification)).to.match(/Problem solved/)

      it 'message should contains the hostname if it is a host notification', ->
        @icingaNotification.isHostNotification = ->
          return true
        expect(@messageCreator.messages(@icingaNotification)).to.match(/any hostname/)

      it 'message should contains the service name if it is a service notification', ->
        @icingaNotification.isServiceNotification = ->
          return true
        expect(@messageCreator.messages(@icingaNotification)).to.match(/service description/)
