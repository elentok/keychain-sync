expect = (require 'chai').expect
keychainSync = require '../lib/keychain-sync'

if process.platform == 'darwin'
  describe "acceptance tests", ->
    it "can save passwords", ->
      password = 'abc'
      keychainSync.setPassword('keychainSync', 'test', password)
      actual = keychainSync.getPassword('keychainSync', 'test')
      expect(actual).to.equal password
