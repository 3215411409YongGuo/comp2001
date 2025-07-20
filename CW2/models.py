from .db import db

class Comment(db.Model):
    __tablename__ = 'Comments'
    id = db.Column(db.Integer, primary_key=True)
    trail_id = db.Column(db.Integer)
    user_id = db.Column(db.Integer)
    content = db.Column(db.String(200))
    is_archived = db.Column(db.Boolean, default=False)