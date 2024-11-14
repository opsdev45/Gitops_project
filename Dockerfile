FROM python:3.9-slim
WORKDIR /app

COPY ./app/requirements.txt .

RUN pip install -r requirements.txt \
    && rm requirements.txt

COPY ./app/ .

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "wsgi:app"]

