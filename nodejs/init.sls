node-js:
    pkgrepo.managed:
        - name: deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu precise main
        - keyserver: keyserver.ubuntu.com
        - keyid: C7917B12
    pkg.installed:
        - name: nodejs
        - refresh: True
