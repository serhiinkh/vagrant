server {
    listen 80;
    server_name example.app;
    rewrite ^([^.]*[^/])$ $1/ permanent;

    root /home/vagrant/www/awesome.app/laravel/public;
    index index.php index.html;
     
    # Important for VirtualBox
    sendfile off;

    if ($host ~* ^www\.(.*))
    {
        set $host_without_www $1;
        rewrite ^/(.*)$ $scheme://$host_without_www/$1 permanent;
    }

    # Check if file exists
    if (!-e $request_filename)
    {
        rewrite ^/(.*)$ /index.php?/$1 last;
        break;
    }

    error_page 404 /index.php;

    location ~* \.php {
        include fastcgi_params;
         
        fastcgi_pass unix:/var/run/php5-fpm.sock;
         
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_cache off;
        fastcgi_index index.php;
    }

    location ~ \..*/.*\.php$
    {
        # I'm pretty sure this stops people trying to traverse your site to get to other PHP files
        return 403;
    }
}