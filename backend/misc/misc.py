import hashlib
import uuid

async def read_json(request, keys):

    def format_error(arr):
        error = "The keys are missing: "
        start = True
        for err in arr:
            if start:   start = False
            else:       error = error + ", "
            error = error + err
        return error 

    inputs_json = await request.json()
    values = []
    error_keys = []
    for key in keys:
        try:
            values.append(inputs_json[key])
        except (KeyError, TypeError):
            error_keys.append(key)
            values.append(None)
    if error_keys == []:
        return (*values, None)
    else:
        return (*values, format_error(error_keys))

def format_success_msg(dict):
    dict["success"] = True
    return dict

def format_error_msg(error):
    dict = {}
    dict["error"] = error
    dict["success"] = False
    return dict 

def removeBsonID(obj):
    obj.pop("_id")
    return obj

def generate_unique_6_digit():
    unique_id = str(uuid.uuid4())
    hash_object = hashlib.sha256(unique_id.encode())
    hex_dig = hash_object.hexdigest()
    return int(hex_dig, 16) % 900000 + 100000