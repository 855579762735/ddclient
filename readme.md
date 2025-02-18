A simple alpine based dockerfile for creating ddclient, just four files needed.
## Quick Setup
### Dockerfile
Just download the Dockerfile from this repo. You can save it in `/your/desired/Dockerfile/location`.
### ddclient.conf
Change into ( `cd` ) the directory of your choosing to get started with the setup. Then create and configure your ddclient.conf based on the [ddclient official documentation](https://ddclient.net/). Or download the sample configuration from the [official ddclient git](https://github.com/ddclient/ddclient/blob/main/ddclient.conf.in).
```
cd /your/desired/setup/location && touch ddclient.conf && nano ddclient.conf
```
### ddclient.cache
In order for ddclient to remember it's last update this file must be created;
```
cd /your/desired/setup/location && touch ddclient.cache
```
### docker-compose.yaml
```yaml
test:
    container_name: ddclient
    image: dockerfile/ddclient
    build: /your/desired/Dockerfile/location
    volumes:
      - '/your/desired/setup/location/ddclient.conf:/etc/ddclient/ddclient.conf:rw'
      - '/your/desired/setup/location/ddclient.cache:/var/cache/ddclient/ddclient.cache:rw'
```
