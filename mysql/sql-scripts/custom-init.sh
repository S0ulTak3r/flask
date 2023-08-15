#!/bin/bash

# Check if the data directory has only the lost+found directory
if [ "$(ls -A /var/lib/mysql)" == "lost+found" ]; then
    # Remove the lost+found directory
    rm -r /var/lib/mysql/lost+found
    # Initialize the data directory
    mysqld --initialize-insecure
fi

# Start the MySQL server using the default entrypoint
exec docker-entrypoint.sh mysqld
