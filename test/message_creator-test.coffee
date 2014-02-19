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

  describe 'messages()', ->
    describe 'isProblem', ->
      beforeEach ->
        @icingaNotification.isProblem = ->
          return true

      it 'message should contain problem message', ->
        expect(@messageCreator.messages(@icingaNotification)).to.match(/Houston/)

      it 'message should contains the hostname if it is a host notification', ->
        @icingaNotification.isHostNotification = ->
          return true
        expect(@messageCreator.messages(@icingaNotification)).to.match(/any hostname/)

      it 'message should contains the service name if it is a service notification', ->
        @icingaNotification.isServiceNotification = ->
          return true
        expect(@messageCreator.messages(@icingaNotification)).to.match(/service description/)

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
