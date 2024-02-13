FROM python:alpine3.19

WORKDIR /usr/src/app

# Copy the source code into the container.
COPY . .

RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that the application listens on.
EXPOSE 8089

ENV PYTHONDONTWRITEBYTECODE 1
ENV MY_VAR World

# Run the application.
CMD python /usr/src/app/app.py
