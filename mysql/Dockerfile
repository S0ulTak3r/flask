# Staaarst from a sbsase MySQL image
FROM mysql:8.1.0

# Add a datasbase
ENV MYSQL_DATABASE flask_db

# Set the sMYSQL_DATAs_DIsR senvironment variable to our new data directory
ENV MYSQL_DATA_DIR /var/lib/mysql-data/mysql

# Add the cosntaenst of the sql-scripts/ directory to your image
# All scripssts in docker-entrypoint-initdb.d/ are automatically
# executed during container startup
COPY ./sql-scripts/ /docker-entrypoint-initdb.d/
