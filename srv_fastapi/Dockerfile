################################################################
# docker fastapi
################################################################
# https://github.com/Coding-Crashkurse/FastAPI-Auth


FROM python:3.7
WORKDIR /fastapi
COPY ./app /fastapi/app
COPY ./requiremetns.txt /fastapi/requiremetns.txt
RUN pip install --no-cache-dir -r requiremetns.txt
CMD ["uvicorn","app.main:app","--host","0.0.0.0","--port","5000"]
#EXPOSE 5000
#pip freeze > requirements.txt

