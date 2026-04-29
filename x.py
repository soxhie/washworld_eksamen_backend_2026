from flask import request, make_response
import mysql.connector
import re 
from datetime import datetime
from functools import wraps
import os
import uuid
from werkzeug.utils import secure_filename
from icecream import ic
ic.configureOutput(prefix=f"_____ | ", includeContext=True)

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

##############################
def db():
    try:
        db = mysql.connector.connect(
            host = "mariadb",
            user = "root",  
            password = "password",
            database = "washworld"
        )
        cursor = db.cursor(dictionary=True)
        return db, cursor
    except Exception as e:
        print(e, flush=True)
        raise Exception("Database under maintenance", 500)
    
##############################
def no_cache(view):
    @wraps(view)
    def no_cache_view(*args, **kwargs):
        response = make_response(view(*args, **kwargs))
        response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "0"
        return response
    return no_cache_view
#################
def format_epoch_date(epoch_value):
    return datetime.fromtimestamp(epoch_value).strftime("%Y-%m-%d")
##############################
USER_NAME_MIN = 2
USER_NAME_MAX = 20
REGEX_USER_NAME = f"^.{{{USER_NAME_MIN},{USER_NAME_MAX}}}$"
def validate_user_name( user_name ):
    user_name = user_name.strip()
    if not re.match(REGEX_USER_NAME, user_name):
        raise Exception("company_exception user_name")
    return user_name


##############################
USER_LAST_NAME_MIN = 2
USER_LAST_NAME_MAX = 20
REGEX_USER_LAST_NAME = f"^.{{{USER_LAST_NAME_MIN},{USER_LAST_NAME_MAX}}}$"
def validate_user_last_name(user_last_name):
    user_last_name = user_last_name.strip()
    if not re.match(REGEX_USER_LAST_NAME, user_last_name):
        raise Exception("company_exception user_last_name")
    return user_last_name


##############################
REGEX_EMAIL = "^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$"
def validate_email( email ):
    email = email.strip()
    if not re.match(REGEX_EMAIL, email): 
        raise Exception("company_exception email")
    return email
##############################
REGEX_USER_ADRESS = "/^(\d{1,}) [a-zA-Z0-9\s]+(\,)? [a-zA-Z]+(\,)? [A-Z]{2} [0-9]{5,6}$/"
def validate_user_adress(user_adress):
    user_adress = user_adress.strip()
    if not re.match(REGEX_USER_ADRESS, user_adress):
        raise Exception("company_exception user_adress")
    return user_adress
##############################
REGEX_USER_PHONE = "^(\+45)?\s?(\d{2}\s?){4}$"
def validate_user_phone(user_phone):
    user_phone = user_phone.strip()
    if not re.match(REGEX_USER_PHONE, user_phone):
        raise Exception("company_exception user_phone")
    return user_phone
##############################
USER_PASSWORD_MIN = 8
USER_PASSWORD_MAX = 50

REGEX_USER_PASSWORD = f"^(?=.*[a-z])(?=.*[A-Z])(?=.*[\d\W]).{{8,}}$"
def validate_user_password( password ):
    user_password = password.strip()
    if not re.match(REGEX_USER_PASSWORD, user_password):
        raise Exception("company_exception user_password")
    return user_password

##############################
REGEX_ID = "^[a-f0-9]{32}$"
def validate_id(id):
    id = id.strip()
    if not re.match(REGEX_ID, id):
        raise Exception("company_exception id")
    return id
##############################
USER_ROLE_MIN = 2
USER_ROLE_MAX = 20
REGEX_USER_ROLE = f"^.{{{USER_ROLE_MIN},{USER_ROLE_MAX}}}$"
def validate_user_role():
    user_role = request.form.get("user_role", "").strip()
    if not re.match(REGEX_USER_ROLE, user_role):
        raise Exception("company_exception user_role")
    return user_role
##############################
# You know that the PK is a uuid4
# uuid4 follows certain patterns
#  TODO: replace game_pk and user_pk in the forms 

##############################
# 0 to 9 letters a to f
REGEX_UUID4 = "^[0-9a-f]{32}$"
def validate_uuid4(uuid4):
    uuid = uuid4.strip()
    if not re.match(REGEX_UUID4, uuid):
        raise Exception("company_exception uuid4 invalid")
    return uuid

##############################
REGEX_PARANOID = "^[0-9a-f]{64}$"
def validate_uuid4_paranoia(uuid4):
    uuid = uuid4.strip()
    if not re.match(REGEX_PARANOID, uuid):
        raise Exception("company_exception paranoia")
    return uuid


