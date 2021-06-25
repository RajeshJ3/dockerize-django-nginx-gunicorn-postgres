FROM python:3

ENV PYTHONUNBUFFERED=1

# project directory
WORKDIR /usr/src/app

# update pip
RUN pip install --upgrade pip

# copy everything to project directory 
COPY . /usr/src/app

# install dependencies
RUN pip install -r requirements.txt