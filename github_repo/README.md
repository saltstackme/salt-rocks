# How To Use github_repo formula

- Create private key files under `your_forumula/files/{{ github_user.rsa_key }}`
  - Or under a different path indicated with `rsa_key_path`
- Define key:value pairs on one of these places
  - in `github_repo/files/map.jinja`
  - in pillar `your_env/pillar/rocks.sls` (can be any pillar file for the environment)
    - create a key named `github_repo` example below.

## map.jinja example (github_repo/files/map.jinja)
```
{% set github_repo = salt['grains.filter_by']({
    'Linux': {
        'username': 'my_user', 
        'fullname': 'github user',
        'mail': 'test@test.com',
        'group': 'my_group',
        'uid': 1001,
        'gid': 1001
        'url': 'git@github.com:rackerlabs/salt-rocks.git',
        'rev': 'master',
        'target': '/home/my_user/salt-rocks',
        'private': false,
        'rsa_key': 'my_pullkey.rsa_id',
        'rsa_key_path': 'my_formula/files'
    }
}, grain='kernel', merge=salt['pillar.get']('github_repo')) %}
```

## pillar example (pillar/rocks.sls)
```
github_repo:
    username: my_user
    fullname: github user
    mail: test@test.com
    group: my_group
    uid: 1001
    gid: 1001
    url: git@github.com:rackerlabs/salt-rocks.git
    rev: master
    target: /home/my_user/salt-rocks
    private: false
    rsa_key: my_pullkey.rsa_id
    rsa_key_path: my_formula/files
```

## ToDo
Add multiple repo support