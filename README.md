# Dockerized API sandbox

https://getsandbox.com/

# Run

The Sandbox image will export the API on port 8080.
Sandbox also expects a 'main.js' file which describes the [Sandbox API](https://getsandbox.com/docs/sandbox-api).
Sandbox is installed at /usr/local/sandbox in the container and will look in that location for the main.js file.

The following command will start a sandbox container, expose port 8080, and mount a 'main.js' file from the current working directory into the sandbox working directory.

    docker run -d --name sandbox -p 8080:8080 -v $PWD/main.js:/usr/local/sandbox/main.js svickers/sandbox:1.0
