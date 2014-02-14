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
      hostStateChanged: ->
        return false
      serviceStateChanged: ->
        return false
      hostState: ->
        return 0
      serviceState: ->
        return 0
      serviceDescription: ->
        return 'service description'

  describe 'messages()', ->
    describe 'neither host or service state have changed', ->
      it 'create exaxtly one message', ->
        expect(@messageCreator.messages(@icingaNotification)).to.have.length(1)

    describe 'host state has changed', ->
      beforeEach ->
        @icingaNotification.hostStateChanged = ->
          return true

      it 'creates exactly one message', ->
        expect(@messageCreator.messages(@icingaNotification)).to.have.length(1)

      it 'creates a message that contains the hostname', ->
        expect(@messageCreator.messages(@icingaNotification)[0]).to.match(/hostname/)

    describe 'service state has changed', ->
      beforeEach ->
        @icingaNotification.serviceStateChanged = ->
          return true

      it 'creates exactly one message', ->
        expect(@messageCreator.messages(@icingaNotification)).to.have.length(1)

      it 'creates a message that contains the hostname', ->
        expect(@messageCreator.messages(@icingaNotification)[0]).to.match(/hostname/)

      it 'creates a message that contains the service dsscription', ->
        expect(@messageCreator.messages(@icingaNotification)[0]).to.match(/service description/)
