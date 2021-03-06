TPC-H Database generator for PostgreSQL 
==========================

This repository contains SQL scripts to populate a Postgres database with TPC-H benchmark data and schema. It builds on the official TPC-H
benchmark available at http://tpc.org/tpch/default5.asp (version 3.0). 


Preparing dbgen
------------------------
Prepare the Makefile - create a copy from makefile.suite
```bash
cd dbgen/
cp makefile.suite Makefile
nano Makefile
```

Modify it so that it contains this settings(around line 110)
```bash
CC=gcc
DATABASE=ORACLE
MACHINE=LINUX
WORKLOAD=TPCH
```

Compile it using *make*.
```bash
make
```

Generating data
---------------
Generate the data using the dbgen tool. Use scale factor flag *-s* to generate 1/10/100 GB of raw data
```bash
./dbgen -s 1
```

Dbgen creates multiple .tbl files in Oracle-like CSV format, one for each table
```bash
ls *.tbl
```

Convert them to a CSV format compatible with PostgreSQL, delete TBL files and move CSV files to */tmp/dss-data* (for scripts)
```bash
for i in `ls *.tbl`; do sed 's/|$//' $i > ${i/tbl/csv}; echo $i; rm $i; done;
mkdir /tmp/dss-data
for i in `ls *.csv`; do mv $i /tmp/dss-data; echo $i; done;
```

Loading the data to the database
---------------

Create database and run SQL scripts to load data (create tables, load data, create indexes)
```bash
/usr/local/pgsql/bin/createdb tpch
/usr/local/pgsql/bin/psql tpch -f dss/tpch-load.sql
/usr/local/pgsql/bin/psql tpch -f dss/tpch-pkeys.sql
/usr/local/pgsql/bin/psql tpch -f dss/tpch-fkey.sql
/usr/local/pgsql/bin/psql tpch -f dss/tpch-index.sql
```
