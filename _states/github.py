'''
Manage github things
'''

def __virtual__():
    if 'github.keys' in __salt__:
        return 'github'
   
    return False

def add_key(name, 
            keypath, 
            user=None,
            password=None,
            token=None):

    ret = {'name': name,
           'changes': {},
           'result': True,
           'comment': 'Key {0} is already present'.format(name)}

    result = __salt__['github.add_key'](keypath, name, user, password, token)
    if result == 'added':
        ret['comment'] = 'Key {0} successfully added'.format(name)
        ret['changes'] = { name: 'added' }
    elif result == 'failed':
        ret['comment'] = 'Key {0} failed to add'.format(name)
        ret['result'] = False

    return ret
