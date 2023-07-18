# Use the httpd base image
FROM httpd:latest

# Copy the HTML file to the appropriate location
COPY index.html /usr/local/apache2/htdocs/

# Expose port 80 (default HTTP port)
EXPOSE 80