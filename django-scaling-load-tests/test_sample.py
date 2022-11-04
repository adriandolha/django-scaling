import gevent
from locust import FastHttpUser, task, between
import os

API_URL = os.getenv('API_URL', 'http://127.0.0.1:32003')
HELLO_URL = f'{API_URL}/hello/'


class TestSample(FastHttpUser):
    wait_time = between(0, 0)

    def on_start(self):
        """ on_start is called when a Locust start before any task is scheduled """
        self.client.verify = False
        print('Starting tests...')

    @task(3)
    def hello(self):
        def concurrent_request(url):
            self.client.get(url)

        pool = gevent.pool.Pool()
        for i in range(10):
            pool.spawn(concurrent_request, HELLO_URL)
        pool.join()
