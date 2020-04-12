from flask import Flask,request,jsonify, make_response
import hashlib
import uuid
import jwt
from pymongo import MongoClient
import json
import datetime
from functools import wraps
from app import getuser,getusers,create_user,sub_login
app=Flask(__name__)
#db=SQLAlchemy(app)
app.config["SECRET_KEY"]="ionixxtechnologiesprivatekey@sachinandram"
#app.config['SQLALCHEMY_DATABASE_URI']="sqlite:////mnt/c/Users/antho/Documents/api/userhub.db"
def apps(name,password):
    try:
        client = MongoClient("localhost",27017)
        db=client.Auth
    except:
        return False
    if db.users.count_documents({"app-name":name}) != 0:
        return False
    temp=password+str(app.config['SECRET_KEY'])
    pwd=hashlib.sha256(temp.encode())
    pid=str(uuid.uuid4())
    credentials={"_id":pid,"secret-key":app.config['SECRET_KEY'],"app-name":name,"password":str(pwd.hexdigest()),"admin":False}
    db.users.insert_one(credentials)
    app_admin={"_id":pid,"name":name,"password":str(pwd.hexdigest()),"admin":True}
    dbc=db[name]
    dbc.insert_one(dict(app_admin))
    return pid
def token_required(f):
    @wraps(f)
    def decorated(*args,**kwargs):
        token=None
        if 'x-access-token' in request.headers:
            token=request.headers['x-access-token']
        if not token:
            return jsonify({"message":"token-required","access":"denied"})
        try:
            data=jwt.decode(token,app.config['SECRET_KEY'])
        except:
            return jsonify({"message":"Invalid token"})
        try:
            client = MongoClient("localhost",27017)
            db=client.Auth
        except:
            return jsonify({"message":"Database denied connection","error":401})
        k=db.users.find({"app-name":data['id']})
        if db.users.count_documents({"app-name":data['id']})==0:
            return jsonify({"message":"User dosent exists","status":0})
        current_user=k[0]
        return f(current_user,*args,**kwargs)
    return decorated
        
@app.route('/app',methods=['GET'])
@token_required
def getapps(current_user):
    if not current_user['admin']:
        return jsonify({"message":"access-denied"})
    try:
        client = MongoClient("localhost",27017)
        db=client.Auth
    except:
        return jsonify({"message":"Database denied connection","error":401})
    k=db.users.find()
    l=[]
    for i in k:
        dic={"name":i["app-name"],"client_id":i["_id"],"secret_key":i["secret-key"]}
        l.append(dic)
    dictt={}
    dictt["apps"]=l
    return dictt

@app.route('/app/<app_name>',methods=['GET'])
@token_required
def getapp(current_user,app_name):
    if not current_user['admin']:
        return jsonify({"message":"access-denied"})
    try:
        client = MongoClient("localhost",27017)
        db=client.Auth
    except:
        return jsonify({"message":"Database denied connection","error":401})
    k=db.users.find({"app-name":app_name})
    if db.users.count_documents({"app-name":app_name})==1:
        k=k[0]
        return jsonify({"name":k["app-name"],"client_id":k["_id"],"secret_key":k["secret-key"]})
    else:
        return jsonify({"message":"User dosent exists"})

@app.route('/app',methods=['POST'])
@token_required
def create_app(current_user):
    if not current_user['admin']:
        return jsonify({"message":"access-denied"})
    data=request.get_json()
    new_user=apps(data['name'],data['password'])
    if new_user != False:
        return jsonify({"message":"User created","id":data["name"]})
    else:
        return jsonify({"message":"Database denied connection/User already exists","Error":"401"})

@app.route('/app/<app_name>',methods=['DELETE'])
@token_required
def delete_app(current_user,app_name):
    if not current_user['admin']:
        return jsonify({"message":"access-denied"})
    try:
        client = MongoClient("localhost",27017)
        db=client.Auth
    except:
        return jsonify({"message":"Database denied connection","error":401})
    db.users.delete_one({"app-name":app_name})    
    db[app_name].drop()
    return jsonify({"message":"user deleted","status":1})

@app.route('/login')
def login(): 
    auth=request.authorization
    if not auth or not auth.username or not auth.password:
        return make_response('Could not verify',401,{'WWW-Authenticate':'Basic realm="Login required"'})
    try:
        client = MongoClient("localhost",27017)
        db=client.Auth
    except:
        return jsonify({"message":"Database denied connection","error":401})
    k=db.users.find({"app-name":auth.username})
    print(db.users.count_documents({"app-name":auth.username}))
    if db.users.count_documents({"app-name":auth.username})==1:
        k=k[0]
        temp=auth.password+str(app.config['SECRET_KEY'])
        hash_val=hashlib.sha256(temp.encode())
        if str(hash_val.hexdigest())==k["password"]:
            token=jwt.encode({'id':k['app-name'],'exp':datetime.datetime.utcnow()+datetime.timedelta(minutes=15)},app.config['SECRET_KEY'])
            print("Token :",token)
            return jsonify({"token":token.decode('UTF-8')})
        else:
            return make_response('Could not verify',401,{'WWW-Authenticate':'Basic realm="Login required"'})
    else:
        return make_response('Could not verify',401,{'WWW-Authenticate':'Basic realm="Login required"'})
@app.route('/<app_name>/register',methods=['POST'])
@token_required
def make_user(current_user,app_name):
    data=request.get_json()
    new_user=create_user(app_name,data['name'],data['password'])
    if new_user != False:
        return jsonify({"message":"User created","id":new_user})
    else:
        return jsonify({"message":"Database denied connection/User already exists","Error":"401"})
@app.route('/<app_name>/users',methods=['GET'])
@token_required
def get(current_user,app_name):
    if current_user['admin']:
        return jsonify({"message":"access-denied"})
    res=getusers(app_name)
    if res==False:
        return jsonify({"message":"Database denied connection","error":401})
    result={}
    result["users"]=res
    print(result)
    return result
@app.route('/<app_name>/users/<user_name>',methods=['GET'])
@token_required
def gets(current_user,app_name,user_name):
    if current_user['admin']:
        return jsonify({"message":"access-denied"})
    res=getuser(app_name,user_name)
    if res==False:
        return jsonify({"message":"User dosent exists","error":401})
    return res
@app.route('/<app_name>/login',methods=['POST'])
def user_login(app_name):
    data=request.get_json()
    if not data['username'] and not data['password']:
        return jsonify({"message":"Credential needed","error":404})
    k=sub_login(app_name,data['username'],data['password'])
    return k
if __name__ == "__main__":
    app.run(debug=True)