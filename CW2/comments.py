from flask import Blueprint, request
from ..auth import verify_user
from ..crud import create_comment

bp = Blueprint('comments', __name__)

@bp.route('/comments', methods=['POST'])
def add_comment():
    data = request.json
    if not verify_user(data['email'], data['password']):
        return {"error": "Authentication failed"}, 403
    return create_comment(data)