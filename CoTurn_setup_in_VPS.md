# CoTurn

## Run this command in your VPS Terminal

```bash
sudo apt-get -y update
sudo apt-get install coturn
```

### Opent the `coturn` file by `sudo nano /etc/default/coturn` command and set it: `TURNSERVER_ENABLED=1`

#### Then config the `turnserver.conf` file. Open it by `sudo nano /etc/turnserver.conf` and set this config and change your Public IP address

```conf
external-ip=<Public IP>/10.0.0.5 # Set your Public IP address here.
listening-ip=0.0.0.0
listening-port=3478
relay-ip=10.0.0.5

lt-cred-mech
user=testuser:testpass # This is the Turn `User & Password`

realm=turnserver.example
server-name=turnserver.example

log-file=/var/log/turnserver.log
simple-log
fingerprint

min-port=49152
max-port=65535

no-multicast-peers
no-cli

# Allow only UDP relays
no-tcp-relay
```

#### Run the Turn server by this command

```bash
sudo systemctl restart coturn
sudo systemctl status coturn
```

You will see:

```bash
coturn.service - coTURN STUN/TURN Server
     Loaded: loaded (/lib/systemd/system/coturn.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2025-04-21 04:21:21 UTC; 23ms ago
       Docs: man:coturn(1)
             man:turnadmin(1)
             man:turnserver(1)
   Main PID: 66855 (turnserver)
      Tasks: 7 (limit: 4687)
     Memory: 11.0M
        CPU: 42ms
     CGroup: /system.slice/coturn.service
             └─66855 /usr/bin/turnserver -c /etc/turnserver.conf

Apr 21 04:21:21 free-radius systemd[1]: Starting coTURN STUN/TURN Server...
Apr 21 04:21:21 free-radius systemd[1]: Started coTURN STUN/TURN Server.
```

#### If the response is not look like that, Ask on AI with the error

### Now how you will implement that

```js
    const peer = new Peer(localPeerId, {
      host: '<PeerJS Server IP>',   // Your Peerjs server IP or domain
      port: 9000,                   // Your PeerJS server port
      path: '/myapp',               // Custom path if you used one
      // secure: false,  Set to true if you use HTTPS + WSS

      config: {
        iceServers: [
          { url: 'stun:stun.l.google.com:19302' },
          { url: 'stun:<YOUR PUBLIC IP>:3478' }, //    Set your public IP
          {
            url: 'turn:<YOUR PUBLIC IP>:3478',  //    Set your public IP
            username: 'testuser',               //    Set your Username that is seted in Turn Server.
            credential: 'testpass'              //    Set you password that is seted in Turn Server.
          }]
      }
    });
```
