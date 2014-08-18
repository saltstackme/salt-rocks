'''
Tools for accessing github
'''
# Import python libs
import sys
from github3 import GitHub, models
import logging

# Import salt libs
import salt.utils

log = logging.getLogger(__name__)

def __virtual__():
    return 'github'


def _authenticate(user=None, password=None, token=None):
    if not user:
        user = __salt__['config.option']('github.user')
    if not password:
        password = __salt__['config.option']('github.password')
    if not token:
        token = __salt__['config.option']('github.token')

    '''
    If we are provided a token, use that, otherwise use user and password
    '''
    if token:
        gh = GitHub(token=token)
    else:
        gh = GitHub(user, password)

    return gh

def keys(user=None, password=None, token=None):
    '''
    Returns a list of ssh pub keys and ID's 
    associated with the account.
    '''
    gh = _authenticate(user, password, token)
    
    keys = {}
    for key in gh.iter_keys():
#    for key in gh.user().iter_keys():
#        key.refresh()
        keys[key.id] = { 'key': key.key, 'title': key.title }

    return keys

def add_key(keypath, title=None, user=None, password=None, token=None):
    '''
    Adds an SSH pub key to the authenticated user.
    The key title will be the minion ID if it is 
    not provided.
    '''

    gh = _authenticate(user, password, token)

    if not title:
        title = __grains__['id']

    log.debug("Attempting to add key with title %s" % title)

    for key in gh.iter_keys():
        if key.title == title:
            log.debug("A key with title '%s' already exists." % title)
            return 'exists'

    key_file = open(keypath, 'r').read()

    try:
        key = gh.create_key(title, key_file)
        if key:
            log.info("Key %s created" % title)
            return 'added'
        else:
            log.error("Key addition for %s failed!" % title)
            return 'failed'
    except models.GitHubError:
        log.error("Key addition for %s failed" % title)
        return 'failed'
