chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

MessageCreator = require '../src/message_creator'

describe 'MessageCreator', ->
  beforeEach ->
    @messageCreator = new MessageCreator()

  describe 'messages()', ->

    describe 'host state has changed', ->

      beforeEach ->
        @notification =
          hostname: ->
            return 'hostname'

        it 'returns the hostname', ->
          icingaNotification =
            hostname: ->
              return 'any hostname'
            hostStateChanged: ->
              return true
            hostState: ->
              return 0

          expect(@messageCreator.messages(icingaNotification)).to.have.length(1)
