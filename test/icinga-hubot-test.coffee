chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'icinga-hubot', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
      router:
        post: sinon.spy()
    @messageCreator =
      messages: sinon.stub()
    @messageCreator.messages.returns(['any message'])

    require('../src/icinga-hubot')(@robot, @messageCreator)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/hello/, sinon.match.any)

  it 'registers a hear listener', ->
    expect(@robot.hear).to.have.been.calledWith(/orly/, sinon.match.any)

  it 'listens to post requests on path "/hubot/icinga-hubot/notify"', ->
    expect(@robot.router.post).to.have.been.calledWith('/hubot/icinga-hubot/notify', sinon.match.any)

  describe 'on post request', ->

    beforeEach ->
      @request =
        body:
          ICINGA_CONTACTADDRESS0: 'any_contact_address'
      @response =
        end: sinon.spy()
      @robot.send = sinon.spy()
      @robot.router.post.lastCall.args[1](@request, @response)

    it 'sets status code 201 on response', ->
      expect(@response.statusCode).to.equal(201)

    it 'calls "end" on response', ->
      expect(@response.end).to.have.been.calledOnce

    it 'sets "envelope.room" using "ICINGA_CONTACTADDRESS0" from post', ->
      expectedEnvelope = room : 'any_contact_address'
      expect(@robot.send).to.have.been.calledWith(expectedEnvelope, sinon.match.any)

    it 'sends the messages created by message creator', ->
      expect(@robot.send).to.have.been.calledWith(sinon.match.any, 'any message')