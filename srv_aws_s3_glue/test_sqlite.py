
#############################################################
# test sqlite jupyter glue aws
#############################################################

# https://medium.com/dataexplorations/sqlalchemy-orm-a-more-pythonic-way-of-interacting-with-your-database-935b57fd2d4d
# https://www.plus2net.com/python/sqlite-insert-sqlalchemy.php

#!pip3 install --upgrade pip
#!pip3 install --user boto3
#!pip install --user sqlalchemy


import sqlalchemy
from flask.ext.sqlalchemy import exc
exceptions = exc.sa_exc

ev_con = "sqlite:///test.db"
my_conn = sqlalchemy.create_engine(ev_con)

q="CREATE TABLE IF NOT EXISTS student (id BIGSERIAL PRIMARY KEY,name text, note number)"
r_set=my_conn.execute(q)

q="INSERT INTO student values(1,'Name', 65)"
try:
  r_set=my_conn.execute(q)
except exceptions.SQLAlchemyError as e:
  error=str(e.__dict__['orig'])
  print(error)
else:
  print("No of records added  : ",r_set.rowcount)
  print("Id of last record added : ",r_set.lastrowid)

q="SELECT * FROM STUDENT"
r_set=my_conn.execute(q)
for row in r_set:
  print(row)