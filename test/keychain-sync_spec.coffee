chai = require 'chai'
expect = chai.expect
chai.use require('sinon-chai')
sinon = require 'sinon'

execSync =
  stdout: sinon.stub()

sandbox = require 'sandboxed-module'
keychainSync = sandbox.require '../lib/keychain-sync',
  requires:
    execSync: execSync

describe "keychainSync", ->
  describe "#getPassword", ->
    describe "when the password exists", ->
      it "returns the password", ->
        execSync.stdout.returns "keychain: ...\nbla bla\npassword: 12345"
        password = keychainSync.getPassword('myAccount', 'myService')
        expect(password).to.equal '12345'
        expectedCmd = "/usr/bin/security find-generic-password -a myAccount -s myService -g"
        expect(execSync.stdout).to.have.been.calledWith(expectedCmd)

    describe "when it doesn't exist", ->
      it "returns null", ->
        execSync.stdout.returns "security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain."
        password = keychainSync.getPassword('myAccount', 'myService')
        expect(password).to.equal null

  describe "#setPassword", ->
    it "saves the password", ->
      keychainSync.setPassword('myAccount', 'myService', 'myPassword')
      expectedCmd = "/usr/bin/security add-generic-password -a myAccount -s myService -w myPassword"
      expect(execSync.stdout).to.have.been.calledWith(expectedCmd)

