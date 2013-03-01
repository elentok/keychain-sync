Keychain-Sync
==============

Access the mac keychain synchronously

Usage
-----

First, add 'keychain-sync' to your package.json dependencies,
or run:

```bash

npm install keychain-sync

```

Then use the following code:

```coffee

keychainSync = require 'keychain-sync'

keychainSync.setPassword('myAccount', 'myService', '12345')

keychainSync.getPassword('myAccount', 'myService')
# returns '12345'

keychainSync.getPassword('myAccount', 'wrongService')
# returns null

```
