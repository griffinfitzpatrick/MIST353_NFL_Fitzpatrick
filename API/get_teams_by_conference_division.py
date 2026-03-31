from get_db_connection import get_db_connection

def get_teams_by_conference_division(conference: str = None, division: str = None):
    conn = get_db_connection()
    cursor = conn.cursor()

    # IMPORTANT: update this to the REAL stored procedure name
    cursor.execute("{call procGetTeamsByConferenceDivision(?, ?)}", (conference, division))

    rows = cursor.fetchall()
    conn.close()

    results = [
        {
            "TeamID": row.TeamID,
            "TeamName": row.TeamName,
            "Conference": row.Conference,
            "Division": row.Division,
            "TeamColors": row.TeamColors
        }
        for row in rows
    ]

    return {"data": results}

