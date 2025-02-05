FROM ubuntu/apache2:2.4-24.10_edge
COPY ApacheHomepage.html /var/www/html/index.html
ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
