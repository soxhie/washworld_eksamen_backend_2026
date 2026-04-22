from flask import Flask, render_template, request, jsonify, session, redirect
import uuid
import x
import time
from flask_session import Session
from werkzeug.security import generate_password_hash  # since I don't have a create user, I won't use these,
from werkzeug.security import check_password_hash 
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity


from flask_cors import CORS
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from icecream import ic
ic.configureOutput(prefix=f"_____ | ", includeContext=True)

app = Flask(__name__)
CORS(app)  # allows everything
app.config['SESSION_TYPE'] = 'filesystem'
Session(app)
app.config["JWT_SECRET_KEY"] = "passwordpasswordpasswordpassword"
jwt = JWTManager(app)