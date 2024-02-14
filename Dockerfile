FROM 521503820723.dkr.ecr.us-east-1.amazonaws.com/httpd

# Copy the HTML file to the appropriate location
COPY . /usr/local/apache2/htdocs/

EXPOSE 80
