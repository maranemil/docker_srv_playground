#!/usr/bin/env bash

# Start Gunicorn processes
echo --: Starting application build
echo --: Creating migration
python3 manage.py makemigrations
echo ------: makemigrations complete
echo --: Running migration
python3 manage.py migrate
echo ------: migrate complete
echo --: Running collectstatic
python3 manage.py collectstatic <<<yes
echo ------: collectstatic complete
echo --: Starting Gunicorn.
gunicorn koober.wsgi:application \
    --bind 0.0.0.0:9010 \
    --workers 3