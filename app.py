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
app.config["JWT_SECRET_KEY"] = "password"
jwt = JWTManager(app)


##############################
@app.get("/")
def index():
    return jsonify({"status":"ok", "message":"Connected"})
############################## all signup routes
@app.post("/api-signup")
def signup():
    try:
        
        user_id = uuid.uuid4().hex
        user_name = x.validate_user_name(request.json.get("user_name", ""))
        user_last_name = x.validate_user_last_name(request.json.get("user_last_name", ""))
        user_address = x.validate_user_address(request.json.get("user_address", ""))
        user_phone = x.validate_user_phone(request.json.get("user_phone", ""))
        user_email = x.validate_email(request.json.get("user_email", ""))
        user_password = x.validate_user_password(request.json.get("user_password", ""))
        user_hashed_password = generate_password_hash(user_password)
        user_created_at = int(time.time())
        user_verification_key = uuid.uuid4().hex
        # user_id = uuid.uuid4().hex
        # user_name = x.validate_user_name(request.form.get("user_name", ""))
        # user_last_name = x.validate_user_last_name(request.form.get("user_last_name", ""))
        # user_address = x.validate_user_address(request.form.get("user_address", ""))
        # user_phone = x.validate_user_phone(request.form.get("user_phone", ""))
        # user_email = x.validate_email(request.form.get("user_email", ""))
        # user_password = x.validate_user_password(request.form.get("user_password", ""))
        # user_hashed_password = generate_password_hash(user_password)
        # user_created_at = int(time.time())
        # user_verification_key = uuid.uuid4().hex
      
        db, cursor = x.db()

        q = "INSERT INTO users VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) "
        cursor.execute(q, (user_id, user_name, user_last_name,user_address, user_phone,user_email,  user_hashed_password, user_created_at ,None,user_verification_key,  None ))
        db.commit()
        # cursor.execute("SELECT DATABASE()")

        # ic("CONNECTED DATABASE:", cursor.fetchone())
        # cursor.execute("SELECT COUNT(*) FROM users")

        # ic("TOTAL USERS:", cursor.fetchone())
        
        # ic(cursor.rowcount)
        html= render_template("___sign_up_email.html", user_verification_key = user_verification_key)
        x.send_email(user_email, html)
        return jsonify({"status": "ok", "message": "Signup successful"})
        
    except Exception as ex:
        if "company_exception user_name" in str(ex):
            return jsonify({ "status":"error", "message":f"user first name {x.USER_NAME_MIN} to {x.USER_NAME_MAX} characters"}), 400
    
        if "company_exception user_last_name" in str(ex):
            return jsonify({ "status":"error", "message":f"user last name {x.USER_LAST_NAME_MIN} to {x.USER_LAST_NAME_MAX} characters"}), 400
    
        if "company_exception user_email" in str(ex):
            error_message = "email invalid"
            return jsonify({"status": "error", "message": error_message}), 400
        
        if "company_exception user_password" in str(ex):
            error_message = f"user password {x.USER_PASSWORD_MIN} to {x.USER_PASSWORD_MAX} characters"
            return jsonify({"status": "error", "message": error_message}), 400
        
       
        if "Duplicate entry" in str(ex) and "user_email" in str(ex):
            error_message = "Email already in use"
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



#################### 
@app.get("/sign-up-email") 
def signup_email():
 try:
     
    user_id = uuid.uuid4().hex
    user_name = x.validate_user_name(request.json.get("user_name", ""))
    user_verification_key = uuid.uuid4().hex
    user_verified_at= int(time.time())
    ic(user_verification_key)
    db, cursor = x.db()
    q = "INSERT INTO users (user_id, user_name, user_verification_key, user_verified_at) VALUES (%s, %s, %s, %s)"
    cursor.execute(q,(user_id, user_name, user_verification_key,  user_verified_at))
    db.commit()
    
    
    html = render_template("___sign_up_email.html", user_verification_key = user_verification_key )
    x.send_email(html)
    return "jjj"
 except Exception as ex:
    ic(ex)
    return str(ex), 500
 finally:
    if "cursor" in locals():cursor.close()
    if "db" in locals(): db.close()




##############################
@app.get("/verify/<key>")
def verify_account(key):
    try:
        key = x.validate_uuid4(key)
        db, cursor = x.db()
        user_verified_at = int(time.time())
        q = """
            UPDATE users
            SET user_verified_at = %s
            WHERE user_verification_key = %s AND user_verified_at = 0
        """
        cursor.execute(q, (user_verified_at, key))
        db.commit()
        if cursor.rowcount == 0:
            return "user already verified"

        return f"Welcome to the system, you are verified"
    except Exception as ex: 
        ic(ex)
        if "company_exception uuid4 invalid" in str(ex):
            return "Invalid key", 400

        return str(ex), 500
    finally:
        if "cursor" in locals(): cursor.close()
        if "db" in locals(): db.close()
        
        
######################## LOGIN
@app.get("/login")
def show_login():
    return render_template("page_login.html")

##################################################### not in class
@app.post("/api-login")
def login():
    try:
        user_email = x.validate_email(request.json.get("user_email", ""))
        ic(user_email)
        
        user_password = x.validate_user_password(request.json.get("user_password", ""))
        ic(user_password)
        # user_email = x.validate_email(request.form.get("user_email", ""))
        # ic(user_email)

        # user_password = x.validate_user_password(request.form.get("user_password", ""))
        # ic(user_password)
        
        db, cursor = x.db()
        q = "SELECT * FROM users WHERE user_email = %s LIMIT 1"
        #Receiving JSON in Views(https://flask.palletsprojects.com/en/stable/patterns/javascript/) 
        
        cursor.execute(q,(user_email,))
        user = cursor.fetchone()
        # access_token = create_access_token(identity=str(user["user_email"]))
        # ic(access_token)
        ic(user)
            
        if not user:
            return jsonify({"status":"error", "message":"User doesn't exist"}), 400
        if not check_password_hash(user["user_password"], user_password):
            return jsonify({"status":"error", "message":"Invalid credentials"}), 400
       
        
        
        user.pop("user_password")
        session["user"] = user
        html = render_template ("email_login_warning.html", ip = request.remote_addr)
        x.send_email(user_email, html)
        
        return jsonify({"status":"ok", "message":"Login successful", "user":user}), 200
    
    except Exception as ex:
        ic(ex)
        
        if "company_exception user_email" in str(ex):
            return jsonify({"status":"error","message":"Invalid email"}), 400
        
        if "company_exception user_password" in str(ex):
            return jsonify({"status":"error", "message":f"user password {x.USER_PASSWORD_MIN} to {x.USER_PASSWORD_MAX} characthers"}), 400
        
        return jsonify ({"status":"error", "message":"System under maintenance"}), 500
    
    finally:
        if "cursor" in locals():cursor.close()
        if "db" in locals(): db.close()

#########