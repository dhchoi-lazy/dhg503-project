from sqlalchemy import create_engine
from dotenv import load_dotenv
from os.path import join, dirname
from dotenv import load_dotenv
import os


dotenv_path = join(dirname(dirname(dirname(__file__))), ".env")
load_dotenv(dotenv_path)


def connect_db():
    DB_CONNECTION_STRING = os.getenv("DB_CONNECTION_STRING")
    engine = create_engine(DB_CONNECTION_STRING)
    return engine
