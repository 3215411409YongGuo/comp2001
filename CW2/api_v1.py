from flask import Blueprint
from .endpoints import comments

api = Blueprint('api', __name__)
api.register_blueprint(comments.bp, url_prefix='/comments')