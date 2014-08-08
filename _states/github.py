'''
Manage github things
'''

def __virtual__():
    if 'github.keys' in __salt__:
        return 'github'
   
    return None

def add_key(name, 
            keypath, 
            user=None,
            password=None,
            token=None):


    ret = {'name': name,
           'changes': {},
           'result': True,
           'comment': 'Key {0} is already present'.format(name)}

    key_name = __salt__['github.add_key'](keypath, name, user, password, token)
    if key_name:
        ret['comment'] = 'Key {0} successfully added'.format(name)
        return ret
    return ret
