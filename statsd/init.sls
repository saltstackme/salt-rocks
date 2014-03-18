include:
    - nodejs

statsd-tgz:
    file.managed:
        - name: /tmp/v0.7.0.tar.gz
        - source: https://github.com/etsy/statsd/archive/v0.7.0.tar.gz
        - source_hash: sha256=a398f08eac233e5d58b11d22febd2afee7d27f89112d97fe0035eda77aee065e

statsd-dir:
    file.directory:
        - name: /opt/statsd

statsd-extract:
    cmd.wait:
        - name: tar --strip-components=1 -zxvf /tmp/v0.7.0.tar.gz
        - cwd: /opt/statsd
        - watch:
            - file: statsd-tgz
        - require:
            - file: statsd-dir

# configs
/opt/statsd/localConfig.js:
    file.managed:
        - source: salt://statsd/files/localConfig.js
        - require:
            - file: statsd-dir
            - cmd: statsd-extract

statsd-init:
    file.managed:
        - name: /etc/init.d/statsd
        - source: salt://statsd/files/statsd.init
        - mode: 0655
        - require:
            - file: statsd-dir
            - sls: nodejs

statsd_service:
    service:
        - name: statsd
        - running
        - require:
            - file: statsd-init
            - file: statsd-dir
