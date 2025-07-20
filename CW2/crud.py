from sqlalchemy.testing import db

from .models import Comment

def create_comment(comment_data: dict):
    new_comment = Comment(**comment_data)
    db.session.add(new_comment)
    db.session.commit()
    return new_comment