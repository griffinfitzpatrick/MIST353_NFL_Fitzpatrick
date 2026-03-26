import os
from dotenv import load_dotenv

load_dotenv(dotenv_path=r"D:\GITHUB\MIST353_NFL_Fitzpatrick\API\.env")

print("DB_SERVER =", os.getenv("DB_SERVER"))
