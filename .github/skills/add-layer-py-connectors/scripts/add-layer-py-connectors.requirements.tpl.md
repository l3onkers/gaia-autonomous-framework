# Python Connectors Dependency Bundle

Status: Active

Use this owned asset when a workflow must add the dependency-manifest content required by the governed Python connectors layer.

## File: `requirements.txt`
```text
# -------------------------------------------------------
# ---------------------- Database Connectors -----------
# -------------------------------------------------------
pandas==2.2.3
sqlalchemy==1.4.54
sqlalchemy-redshift==0.8.14
psycopg2-binary==2.9.11
pyodbc==5.3.0

# -------------------------------------------------------
# ---------------------- SFTP --------------------------
# -------------------------------------------------------
paramiko==4.0.0
```