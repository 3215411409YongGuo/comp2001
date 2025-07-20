from pydantic import BaseModel

class CommentCreate(BaseModel):
    trail_id: int
    user_id: int
    content: str