# Staaarst from a sbsase MySQL image
FROM mysql:8.1.0

# Add a database
ENV MYSQL_DATABASE flask_db

# Set the MYSQL_DATA_DIR environment variable to our new data directory
ENV MYSQL_DATA_DIR /var/lib/mysql-data/mysql

# Add the content of the sql-scripts/ directory to your image
# All scripssts in docker-entrypoint-initdb.d/ are automatically
# executed during container startup
COPY ./sql-scripts/ /docker-entrypoint-initdb.d/
