# tunneler
Small node.js application to tunnel a port while having (very basic) authentication.

## Sample Scenario
In  the config section and in the source code the sample config tunnels a mongodb. On some host, we have a mongodb listening on port 27017 which is not exposed to the internet. Instead we have a tunneler listening on port 8099 with basic authentication. Locally, we have the other tunnel endpoint, which listens locally on port 27017 and creates a tunnel connection to our host on port 8099. Services:
- Local tunnel endpoint:
	- listens on port 27017
	- forwards connections to myhost.sample.com on port 8099
- Remote tunnel endpoint on myhost.sample.com:
	- listens on port 8099 for incoming tunnel connections
	- authenticates the connection, then pipes the socket to localhost on port 27017

## Configuration
You can configure with environment variables (see Dockerfile for examples) or running it with command line params as follows (Values for ports etc. taken from sample scenario, see above):
```bash
# long version
#   - host: connect incoming tunnels to this host
#   - port: connect incoming tunnels to this port
#   - tunnel: listen on this port for incoming tunnels
#   - secret: password for incoming tunnels
#   - is-server: run in server mode (listen for incoming tunnels)
node app.js --host=localhost --port=27017 --tunnel=8099 --secret='secret password' --is-server
# short version
node app.js -h localhost -p 27017 -t 8099 -s 'secret password' -i
```
Local tunnel endpoint (connects to tunnel server created above):
```bash
# long version
node app.js --host=myhost.sample.com --port=27017 --tunnel=8099 --secret='secret password'
# short version
node app.js -h myhost.sample.com -p 27017 -t 8099 -s 'secret password'
```
Alternatively you can create a file named `config.json` structured as follows (you can copy SMAPLE-config.json found in this directory):
```json
{
	"host": "localhost",
	"port": 27017,
	"tunnel": 8099,
	"is-server": false,
	"secret": "secret password"
}
```