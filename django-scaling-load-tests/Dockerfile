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
ENV PYTHONUNBUFFERED=1
EXPOSE 8000 5557 5558
#CMD python manage.py runserver
CMD ["locust", "-f", "test_sample.py"]