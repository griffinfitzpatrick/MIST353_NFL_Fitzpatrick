import pyodbc
import os
from dotenv import load_dotenv

# Load environment variables from .env
load_dotenv()
print("✅ Env vars loaded")

def get_db_connection():
    server = os.getenv("DB_SERVER")
    database = os.getenv("DB_NAME")
    username = os.getenv("DB_LOGIN")
    password = os.getenv("DB_PASSWORD")

    print("Loaded server:", server)
    print("Loaded database:", database)
    print("Loaded username:", username)
    print("Loaded password:", password)


    # Build connection string for ODBC Driver 18
    connection_string = (
        "DRIVER={ODBC Driver 18 for SQL Server};"
       f"SERVER=tcp:{server},1433;"
       f"DATABASE={database};"
       f"UID={username};"
       f"PWD={password};"

        "Encrypt=yes;"
        "TrustServerCertificate=yes;"
    )

    print("Using connection string:", connection_string)

    # Try connecting and show SQL errors if they occur
    try:
        return pyodbc.connect(connection_string)
    except Exception as e:
        print("❌ SQL ERROR:", e)
        raise


