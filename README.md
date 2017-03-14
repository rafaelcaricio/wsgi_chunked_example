# WSGI Transfer Encoding chunked example
This repo shows a possible way to handle `Transfer-Enconding: chunked` for WSGI apps.

## What is the problem?
TODO.

## How to run?
TODO.

Running the app directly:

    $ python simple_app.py

The app will be available at [http://localhost:8080/](http://localhost:8080/). This is nice to know that the app itself is working as expected.

Then you can try running locally with uWSGI:

    $ uwsgi uwsgi_local.yaml

We have a different uwsgi configuration because in the local one we use an HTTP socket. The docker uwsgi configuration will create a raw socket that will be called by the NGINX.

The local uWSGI configuration will also create the socket in a different location, in this case at `/tmp/pod_shared/simple_server.sock`.

## How to call?
Using `curl`:

    $ curl -XPOST -d"data=present"  http://127.0.0.1/

To reproduce the problem execute:

    $ curl -XPOST -d"data=present" -H"Transfer-Encoding: chunked" http://127.0.0.1/

You will see no data in the body of the request coming from the Flask request object.

Call the local unix socket version under uWSGI using the local configuration:

    $ curl -XPOST -d"data=present" --unix-socket /tmp/pod_shared/simple_server.sock --url https://131.0.0.1/

You can also reproduce the problem with the uWSGI unix socket:

    $ curl -XPOST -d"name=foobar" -H"Transfer-Encoding: chunked" --unix-socket /tmp/pod_shared/simple_server.sock --url http://localhost:8080/

