execSync = require 'execSync'

module.exports =
  getPassword: (account, service) ->
    cmd = "/usr/bin/security find-generic-password -a #{account} -s #{service} -w"
    pass = execSync.stdout(cmd).trim()
    if pass.length == 0 then null else pass

  _findPassword: (output) ->
    match = /^password: (.*)$/m.exec(output)
    if match? then match[1] else null
  
  setPassword: (account, service, password) ->
    cmd = "/usr/bin/security add-generic-password -a #{account} -s #{service} -w #{password}"
    execSync.stdout(cmd)



