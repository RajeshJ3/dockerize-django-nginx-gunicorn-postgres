# Dockerize your Django, NGINX, Gunicorn, PostgreSQL project

Hey developers, welcome! This repo is a Docker boiler plate for a Django Project

## What you end up with 🥳

- Django project running at ports 80, 443, 8000
  - NGINX production server listening at POST 80, 443
  - Gunicorn development server listening at POST 8000
- Persistent Postgres volume
- Hot reloading Server

## Prerequisites 😰

- Docker and docker-compose installed
- Basic understanding of Docker
- Cloudflare Account (for SSL)
- Internet connectivity

---

## Let's Go 🏃‍♂️

- Clone the project

```bash
git clone https://github.com/rajeshj3/dockerize-django-nginx-gunicorn-postgres
cd dockerize-django-nginx-gunicorn-postgres
```

**Note:** At this step you can change the django project. Just delete existing django directories and files and create new django project. Don't forget to install requirements.txt dependencies first.

- Configuring Environment

  - Create **core/.env** environment file, eg.

    ```.env
    SECRET_KEY=django-insecure-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    DEBUG=False
    DB_NAME=postgres
    DB_USER=postgres
    DB_PASSWORD=postgres
    DB_HOST=db
    DB_PORT=5432
    ```

  - Configure For **SSL**

    Create directory **nginx/ssl** and add 3 files

    ```bash
    touch ssl/cert.pem
    touch ssl/key.pem
    touch ssl/cloudflare.crt
    ```

    You'll find thes files in your cloudflare dashboard

    **Note:** If you don't want your server to server over SSL, Remove the second server block from **nginx/nginx.conf** ie.

    ```.conf
    server {
        listen 443 ssl http2;

        ssl_certificate         /etc/ssl/cert.pem;
        ssl_certificate_key     /etc/ssl/key.pem;
        ssl_client_certificate  /etc/ssl/cloudflare.crt;
        ssl_verify_client on;

        location / {
            proxy_pass http://app;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_redirect off;
        }
        location /static/ {
            alias /usr/src/app/static/;
        }
    }
    ```

    And, also remove **COPY ssl/** commands from **nginx/Dockerfile**, ie.

    ```Dockerfile
    COPY ssl/cert.pem /etc/ssl/cert.pem
    COPY ssl/key.pem /etc/ssl/key.pem
    COPY ssl/cloudflare.crt /etc/ssl/cloudflare.crt
    ```

- Build Images

```bash
docker-compose --build
```

- Run the containers

```bash
docker-compose up
```

Awesome 🥳🥳 Our server is now running at POSTs 80, 443, 8000

Also, Our server supports ⚡ hot reloading ⚡ So you can start developing your django project now.

**Production Note:** The same ommands will run in the production. Jsut, make sure your containers are always running in the background.

_Note:_ 443 might not work 🚫 if server is not located at the domain you've created SSL for.

---

## Running custom commands 🖥️

TO run custom commands, there are 2 options

- Accessing container shell
- docker-compose run django_project

Here, we are following the first approach

- Accessing container shell

```bash
docker exec -it django_project
```

**Note:** Make sure you are in _/usr/src/app/_

Run any commands here, eg

```bash
python manage.py collectstatic --no-imput
```

---

## Accessing PostgreSQL Database 🧱

- Accessing psql shell

```bash
docker exec -it django_project_db psql -U postgres
```

**Note:** _postgres_ is default user.
Run any postgres commands here, eg

```psql
# \l
```

## Deleting everything 🗑️

- Delete containers

```bash
docker-compose down
```

- Deleting Images

```bash
docker rmi xxxxxxxxxx xxxxxxxxxx xxxxxxxxxx
```

**Note:** At place of _xxxxxxxxxx_ place IMAGE IDs of our containers

- Deleting Volumes

```bash
docker volume prune -f
```

---

Thank you 😇

Cheers
