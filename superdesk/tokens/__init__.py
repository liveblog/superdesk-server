
import superdesk

from superdesk.io.reuters_token import get_token

superdesk.DOMAIN.update({
    'tokens': {
        'schema': {
            'provider': {'type': 'string'},
            'token': {'type': 'string'}
        },
        'resource_methods': [],
        'item_methods': [],
        'extra_response_fields': ['token']
    }
})