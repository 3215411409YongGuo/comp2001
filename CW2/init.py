from flask import Flask
from .db import db

def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mssql+pyodbc://username:password@dist-6-505.uopnet.plymouth.ac.uk/CW2?driver=ODBC+Driver+17+for+SQL+Server'
    db.init_app(app)
    return app