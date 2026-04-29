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


##############################
@app.get("/")
def index():
    return jsonify({"status":"ok", "message":"Connected"})
##############################
@app.post("/signup")
def signup():
    try:
        user_id = str(uuid.uuid4())
        user_name = x.validate_user_name(request.json.get("user_name", ""))
        user_last_name = x.validate_user_last_name(request.json.get("user_last_name", ""))
        user_address = x.validate_user_address(request.json.get("user_address", ""))
        user_phone = x.validate_user_phone(request.json.get("user_phone", ""))
        user_email = x.validate_email(request.json.get("user_email", ""))
        user_payment_gateway_fk = x.validate_id(request.json.get("user_payment_gateway_fk", ""))
        user_password = x.validate_user_password(request.json.get("user_password", ""))
        user_password_hashed = generate_password_hash(user_password)
        user_created_at = int(time.time())

         
        
        db, cursor = x.db()
        q = "INSERT INTO users VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s) "
        cursor.execute(q, (user_id, user_name, user_last_name, user_email, user_hashed_password, created_at, user_address, user_phone, user_payment_gateway_fk))
        db.commit()
    except Exception as ex:
       
        if "company_exception user_email" in str(ex):
            error_message = "email invalid"
            return jsonify({"status": "error", "message": error_message}), 400
        
        if "company_exception user_password" in str(ex):
            error_message = f"user password {x.USER_PASSWORD_MIN} to {x.USER_PASSWORD_MAX} characters"
            return jsonify({"status": "error", "message": error_message}), 400
        
        if "company_exception user_role" in str(ex):
            error_message = f"user role {x.USER_ROLE_MIN} to {x.USER_ROLE_MAX} characters"
            return jsonify({"status": "error", "message": error_message}), 400
        
        if "Duplicate entry" in str(ex) and "user_email" in str(ex):
            error_message = "You already have an account with this email, please or use another email"
            return jsonify({"status": "error", "message": error_message}), 400
        # Worst case
        error_message = "System under maintenance"
        return jsonify({"status": "error", "message": str(ex)}), 500
    finally:
        if "cursor" in locals(): cursor.close()
        if "db" in locals(): db.close()
##############################
@app.get("/signup")
def show_signup():
    return render_template("page_signup.html")
##############################