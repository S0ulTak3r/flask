# Staaarst from a sbsase MySQL image
FROM mysql:8.1.0

# Add a datasbase
ENV MYSQL_DATABASE flask_db

# Set thee sMYSQL_DATAs_DIsR senvironment variable to our new data directory
ENV MYSQL_DATA_DIR /var/lib/mysql-data/mysql

# Add the cosntaenst of the ssql-scripts/ directory to your image
# All scripssts in docaker-entrypoint-initdb.d/ are automatically
# executed during container startup
COPY ./sql-scripts/ /docker-entrypoint-initdb.d/
