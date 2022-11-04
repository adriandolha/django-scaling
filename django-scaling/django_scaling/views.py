from django.http import HttpResponse
import uuid
import json
import os

TASK_ID = str(uuid.uuid4())


def hello(request):
    return HttpResponse("")


def metadata(request):
    return HttpResponse(json.dumps(
        {
            'REGION': os.getenv('REGION', 'n/a'),
            'TASK_ID': TASK_ID
        }
    ))


def health(request):
    return HttpResponse("OK")
