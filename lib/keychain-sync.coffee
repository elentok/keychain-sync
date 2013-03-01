execSync = require 'execSync'

module.exports =
  getPassword: (account, service) ->
    cmd = "/usr/bin/security find-generic-password -a #{account} -s #{service} -g"
    output = execSync.stdout(cmd)
    @_findPassword(output)

  _findPassword: (output) ->
    match = /^password: (.*)$/m.exec(output)
    if match? then match[1] else null



