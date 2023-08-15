# Start from a base MySQL image
FROM mysql:8.1.0

# Add a database
ENV MYSQL_DATABASE flask_db

# Add the content of the sql-scripts/ directory to your image
# All scripts in docker-entrypoint-initdb.d/ are automatically
# executed during container startup
COPY ./sql-scripts/ /docker-entrypoint-initdb.d/
COPY custom-init.sh /usr/local/bin/

# Set permissions and set the entrypoint to our custom script
RUN chmod +x /usr/local/bin/custom-init.sh
ENTRYPOINT ["custom-init.sh"]
