from pydantic import BaseModel
from fastapi import APIRouter

basic_router = APIRouter(tags=["basic"])


class Student(BaseModel):
    student_id: int
    age: int
    name: str


class LoginRequest(BaseModel):
    username: str
    password: str


@basic_router.get("/api/students/")
def read_student_query(student_id: int, age: int, name: str):
    return (
        f"Your student id is {student_id}, your age is {age}, and your name is {name}."
    )


@basic_router.get("/api/login")
def login_get(username: str, password: str):
    # Note: In a real app, never handle passwords via GET request
    # This is just for demonstration purposes
    return {"message": f"GET Login attempt for user: {username}", "success": True}


@basic_router.post("/api/login")
def login_post(login_data: LoginRequest):
    # In a real app, you would validate credentials here
    return {
        "message": f"POST Login attempt for user: {login_data.username}",
        "success": True,
    }
