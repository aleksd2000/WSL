# https://www.linuxbabe.com/mail-server/debian-10-buster-iredmail-email-server
# Step 4: Setting up Mail Server on Debian 10 with iRedMail#

wget https://github.com/iredmail/iRedMail/archive/1.5.1.tar.gz
tar xvf 1.5.1.tar.gz
cd iRedMail-1.5.1/
chmod +x iRedMail.sh
sudo bash iRedMail.sh


sudo apt install certbot
sudo certbot certonly --webroot --agree-tos --email certbot@aleksd2000.cc -d mail1.ukhosts.cc -w /var/www/html/hosts/default


# https://mail.your-domain.com/iredadmin/

sudo nano /etc/nginx/templates/ssl.tmpl

#Find the following 2 lines.

# ssl_certificate /etc/ssl/certs/iRedMail.crt;
# ssl_certificate_key /etc/ssl/private/iRedMail.key;

#Replace them with:

# ssl_certificate /etc/letsencrypt/live/mail.your-domain.com/fullchain.pem;
# ssl_certificate_key /etc/letsencrypt/live/mail.your-domain.com/privkey.pem;

#Installing TLS Certificate in Postfix and Dovecot

sudo nano /etc/postfix/main.cf

#Find the following 3 lines. (line 95, 96, 97).

smtpd_tls_key_file = /etc/ssl/private/iRedMail.key
smtpd_tls_cert_file = /etc/ssl/certs/iRedMail.crt
smtpd_tls_CAfile = /etc/ssl/certs/iRedMail.crt

#Replace them with:

smtpd_tls_key_file = /etc/letsencrypt/live/mail.your-domain.com/privkey.pem
smtpd_tls_cert_file = /etc/letsencrypt/live/mail.your-domain.com/cert.pem
smtpd_tls_CAfile = /etc/letsencrypt/live/mail.your-domain.com/chain.pem

sudo systemctl reload postfix

#Next, edit the main configuration file of Dovecot.

sudo nano /etc/dovecot/dovecot.conf

#Fine the following 2 lines. (line 47, 48)

ssl_cert = </etc/ssl/certs/iRedMail.crt
ssl_key = </etc/ssl/private/iRedMail.key

#Replace them with:

ssl_cert = </etc/letsencrypt/live/mail.your-domain.com/fullchain.pem
ssl_key = </etc/letsencrypt/live/mail.your-domain.com/privkey.pem

sudo systemctl reload dovecot

https://mail.your-domain.com/mail/

sudo systemctl daemon-reload
sudo systemctl restart clamav-daemon

telnet gmail-smtp-in.l.google.com 25


