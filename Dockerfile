FROM python:3.9-alpine
WORKDIR /app/
COPY app/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY app .

RUN python manage.py migrate
EXPOSE 8000
ENTRYPOINT ["python", "mysite/manage.py"]
CMD ["runserver", "0.0.0.0:8000"]
