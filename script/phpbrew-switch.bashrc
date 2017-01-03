alias phpbrew-switch-7='phpbrew switch-off && sudo a2dismod php5 && sudo a2enmod php7.0 && sudo service apache2 restart'
alias phpbrew-switch-5='phpbrew switch php-5.5.22 && sudo a2dismod php7.0 && sudo a2enmod php5 && sudo service apache2 restart'
