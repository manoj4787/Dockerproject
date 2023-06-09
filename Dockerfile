# Use the official httpd image as the base
FROM httpd:latest

# Copy the modified index.html file to the Apache document root
COPY index.html /usr/local/apache2/htdocs/

# Expose port 80 for HTTP traffic
EXPOSE 80