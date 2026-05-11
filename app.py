from flask import Flask, render_template, request, jsonify, session, redirect
import uuid
import x
import time
from flask_session import Session
from werkzeug.security import generate_password_hash  
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
        #USERS DATA
        user_id = uuid.uuid4().hex
        user_name = x.validate_user_name(request.json.get("user_name", ""))
        user_last_name = x.validate_user_last_name(request.json.get("user_last_name", ""))
        user_address = x.validate_user_address(request.json.get("user_address", ""))
        user_phone = x.validate_user_phone(request.json.get("user_phone", ""))
        user_email = x.validate_email(request.json.get("user_email", ""))
        user_password = x.validate_user_password(request.json.get("user_password", ""))
        
        #CAR DATA
        car_id= uuid.uuid4().hex
        car_plate = request.json.get("car_plate", "")
        car_user_fk = user_id
        #PAYMENT_GATEWAY DATA
        payment_id = uuid.uuid4().hex
        payment_name = request.json.get("payment_name", "")
        user_payment_fk = user_id
        #USER_MEMBERSHIP DATA
        user_memberships_id = request.json.get("user_membership_id", "")
        membership_user_fk = user_id
        membership_fk = request.json.get("membership_fk", "")
        start_date = int(time.time())
        
        membership_fk = request.json.get("membership_fk", "")
       

        #USERS DATA
        user_hashed_password = generate_password_hash(user_password)
        created_at = int(time.time())
        
        user_verification_key = uuid.uuid4().hex
      
    
        db, cursor = x.db()

        q = "INSERT INTO users VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) "
        cursor.execute(q, (user_id, user_name, user_last_name,user_address, user_phone,user_email,  user_hashed_password, created_at ,None,user_verification_key,  None ))
        
        
        q = "INSERT INTO cars VALUES(%s, %s, %s, %s, %s, %s) "
        cursor.execute(q, (car_id, car_plate, car_user_fk, created_at, None, None))
       
        q = "INSERT INTO payment_gateway VALUES(%s, %s, %s, %s, %s) "
        cursor.execute(q, (payment_id, payment_name, user_payment_fk, created_at, None))
        
        q = "INSERT INTO user_memberships VALUES(%s, %s, %s, %s, %s, %s, %s, %s) "
        cursor.execute(q, (user_memberships_id, membership_user_fk, membership_fk, start_date, None, "active", created_at, None))
        
        
        db.commit()
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

##################################################### 
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
        
        # ic(access_token)
        ic(user)
            
        if not user:
            return jsonify({"status": "error", "message": "User doesn't exist"}), 400

        if not check_password_hash(user["user_password"], user_password):
            return jsonify({"status": "error", "message": "Invalid credentials"}), 400
        access_token = create_access_token(identity=str(user["user_email"]))
       
        
        
        user.pop("user_password")
        session["user"] = user
        html = render_template ("email_login_warning.html", ip = request.remote_addr)
        x.send_email(user_email, html)
        
        return jsonify({"status":"ok", "message":"Login successful", "user":user, "access_token": access_token}), 200
    
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

################# 
@app.get("/api-profile")
@jwt_required()
def profile():

    current_user = get_jwt_identity()

    return jsonify({
        "status": "ok",
        "user": current_user
    }), 200

############# Mine oplysninger
@app.get("/api-my-info")
@jwt_required()
def get_my_info():
    try:
        user_email = get_jwt_identity()

        db, cursor = x.db()

        q = """
        SELECT 
            user_id,
            user_name,
            user_last_name
            user_email,
            user_address,
            user_phone
            user
        FROM users
        LEFT JOIN cars
        ON cars.user_id_fk = users.user_id
        WHERE user_email = %s
        LIMIT 1
        """

        cursor.execute(q, (user_email,))
        user = cursor.fetchone()

        if not user:
            return jsonify({
                "status": "error",
                "message": "User not found"
            }), 404

        return jsonify({
            "status": "ok",
            "user": user
        }), 200

    except Exception as ex:
        ic(ex)
        return jsonify({
            "status": "error",
            "message": "System under maintenance"
        }), 500

    finally:
        if "cursor" in locals(): cursor.close()
        if "db" in locals(): db.close()














######### forgot password 
# @app.post("/api-forgot-password")
# def forgot_password()