from fastapi import APIRouter
from get_db_connection import get_db_connection

router = APIRouter()

@router.get("/get_teams_for_specified_fan/")
def get_teams_for_specified_fan(nfl_fan_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("(call procGetTeamsForSpecifiedFan(?))", (nfl_fan_id,))
    rows = cursor.fetchall()
    conn.close()

    results = [
        {
            "TeamName": row.TeamName,
            "Conference": row.Conference,
            "Division": row.Division,
            "TeamColors": row.TeamColors
        }
        for row in rows
    ]

    return {"data": results}
