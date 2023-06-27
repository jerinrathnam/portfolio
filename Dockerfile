# Use the official Apache base image
FROM httpd

# Copy the HTML file to the Apache document root directory
COPY . /usr/local/apache2/htdocs/

# Copy custom Apache configuration file
COPY apache.conf /usr/local/apache2/conf/httpd.conf

# Expose the default Apache port
EXPOSE 80

# Start the Apache server
CMD ["httpd", "-D", "FOREGROUND"]
