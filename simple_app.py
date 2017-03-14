import os
import sys
import logging

from flask import *

log_level = getattr(logging, os.environ.get('APP_LOG_LEVEL', 'DEBUG'))
logging.basicConfig(stream=sys.stdout, level=log_level)

log = logging.getLogger('simple_app')
app = Flask(__name__)

@app.route("/", methods=['GET','POST'])
def home():
    if request.method == 'POST':
        result = "{}\n{}".format(request.headers, request.stream.read())
        log.debug(result)
        return result

    log.debug('GET request received... OK')
    return "OK"


if __name__ == '__main__':
    app.run(port=8080)

