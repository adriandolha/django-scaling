FROM python:3.8

RUN useradd demo

WORKDIR /home/demo
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY requirements.txt requirements.txt

COPY . .
#RUN pip install /home/demo/

RUN chown -R demo:demo /home/demo
USER demo

ENV DJANGO_SETTINGS_MODULE=django_scaling.settings
ENV UWSGI_WSGI_FILE=django_scaling/wsgi.py
ENV UWSGI_HTTP=0.0.0.0:8000 UWSGI_MASTER=1 UWSGI_HTTP_AUTO_CHUNKED=1 UWSGI_HTTP_KEEPALIVE=1 UWSGI_LAZY_APPS=1 UWSGI_WSGI_ENV_BEHAVIOR=holy
# Number of uWSGI workers and threads per worker (customize as needed):
ENV UWSGI_WORKERS=4 UWSGI_THREADS=2

EXPOSE 8000
#CMD python manage.py runserver
CMD ["uwsgi", "--show-config"]