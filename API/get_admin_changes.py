from fastapi import APIRouter
from pydantic import BaseModel
from get_db_connection import get_db_connection

router = APIRouter()

class AdminChangesRequest(BaseModel):
    nfl_admin_id: int

@router.post("/get_admin_changes/")
def get_admin_changes(req: AdminChangesRequest):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    try:
        cursor.execute("EXEC procGetAllChangesMadeBySpecifiedAdmin %s", (req.nfl_admin_id,))
        rows = cursor.fetchall()
        return rows

    except Exception as e:
        return {"error": str(e)}

    finally:
        cursor.close()
        conn.close()