import firebase_admin
from firebase_admin import credentials
from firebase_admin import auth
from firebase_admin import firestore


cred = credentials.Certificate("C:\Projects\my_meals\model\credentials.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

def getAllUsers():
    return list(auth.list_users().iterate_all())

def getAllMeals():
    return db.collection(u'meals').get()
