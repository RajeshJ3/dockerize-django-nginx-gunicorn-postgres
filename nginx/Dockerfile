FROM nginx:stable-alpine


RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d

COPY ssl/cert.pem /etc/ssl/cert.pem
COPY ssl/key.pem /etc/ssl/key.pem
COPY ssl/cloudflare.crt /etc/ssl/cloudflare.crt