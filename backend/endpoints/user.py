from fastapi import APIRouter, Request
from database.database import find_one_collection, add_to_collection, update_to_collection, delete_from_collection
from misc.misc import read_json, format_error_msg, format_success_msg
import hashlib
import random
import string
import asyncio

router = APIRouter()

@router.post("/login")
async def getAuthRequest(request: Request):
    username, password_hashed, error = await read_json(request, ["username", "password"])
    if error:
        return format_error_msg(error)
    
    return getAuth(username, password_hashed)

def getAuth(username, password_hashed):
    res = find_one_collection({"username": username, "password": password_hashed}, "authentication")
    if res == None:
        return format_error_msg("Password doesnt match or no user found")
    else:
        return format_success_msg({"access": True})

@router.post("/signup")
async def signupRequest(request: Request):
    name, email, photo, description, dates, password, public_key, private_key, error = await read_json(request, 
        [
        "name", "email", "photo", "description", "dates", "password",
                "public key", "private key"
        ]
        )
    if error:
        return format_error_msg(error)
    res = await signup(name, email, photo, description, dates, password,
                public_key, private_key)
    return res

def signup(name, email, photo, description, dates, password,
                public_key, private_key):
    usr_jsn =  {"name": name,
                "email": email,
                "photo": photo,
                "description": description,
                "dates": dates,
                "password": password,
                "public key": public_key,
                "private key": private_key
                }
    
    res = find_one_collection({"email": email}, "users")

    if res == None:
        usr = add_to_collection(usr_jsn, "users")
        return format_success_msg({"access": True})
    else:
        return format_error_msg("Username exists in a collection, Please try a different one")
    
def generate_random_string(num):
    characters = string.ascii_letters + string.digits
    salt = ''.join(random.choices(characters, k=num))
    return salt

def generate_otp(num): 
    characters = string.digits
    salt = ''.join(random.choices(characters, k=num))
    return salt

def hash_pw(pw: str) -> str:
    sha256_hash = hashlib.sha256()
    sha256_hash.update(pw.encode('utf-8'))
    return sha256_hash.hexdigest()

@router.post("/check-username")
async def checkUsername(request: Request):
    username, error = await read_json(request, ["username"])
    if error:
        return format_error_msg(error)


    user = find_one_collection({"username": username}, "authentication")
    user2 = find_one_collection({"username": username}, "users")
    return {"exists": bool(user) or bool(user2)}
    
@router.post("/forgetPassword")
async def forgotPassword(request: Request):
    username, email, error = await read_json(request, ["username", "email" ])
    if error:
        return format_error_msg(error)
    try:

        # Error handling for no username / no email
        user_auth = find_one_collection({"username": username}, "authentication")
        if user_auth == None:
            return format_error_msg("No Username Found")

        user = find_one_collection({"username": username, "email": email}, "users")
        if user == None:
            return format_error_msg("Wrong Email Entered")
        
        otp = generate_otp(6)
        update_to_collection({"username": username}, {"forgotPasswordOTP": False, "otp": otp}, "authentication")
        send_otp_email(email, otp, username)
        return format_success_msg({"forgotPassword": True})

    except Exception as e:
        return format_error_msg(str(e))

@router.post("/forgetPasswordOTP")
async def forgotPasswordOTP(request: Request):
    username, otp, error = await read_json(request, ["username", "otp" ])
    if error:
        return format_error_msg(error)
    try:
        # Error handling for no username / no email
        user_auth = find_one_collection({"username": username}, "authentication")
        if user_auth == None:
            return format_error_msg("No Username Found")
        
        if (user_auth["otp"] == otp):
            update_to_collection({"username": username}, {"forgotPasswordOTP": True, "otp": ""}, "authentication")
            return format_success_msg({"forgotPassword": True})
        else:
            return format_error_msg("OTP is wrong")

    except Exception as e:
        return format_error_msg(str(e))

@router.post("/forgetPasswordChangePW")
async def forgotPassword(request: Request):
    username, password, error = await read_json(request, ["username", "password" ])
    if error:
        return format_error_msg(error)
    try:
        # Error handling for no username / no email
        user_auth = find_one_collection({"username": username}, "authentication")
        if user_auth == None:
            return format_error_msg("No Username Found")
        if (user_auth["forgotPasswordOTP"] == True):
            salt = user_auth["salt"]
            hashPw = hash_pw(password + salt)
            update_to_collection({"username": username}, {"password": hashPw, "forgotPasswordOTP": ""}, "authentication")
            return format_success_msg({"forgotPassword": True})
        else:
            return format_error_msg("No request is given")

    except Exception as e:
        return format_error_msg(str(e))

signup("1", "2", "3", "4", "5", "6", "7", "8")