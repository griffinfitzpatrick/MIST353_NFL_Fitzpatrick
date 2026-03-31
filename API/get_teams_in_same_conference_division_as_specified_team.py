from get_db_connection import get_db_connection

def get_teams_in_same_conference_division_as_specified_team(team_id: str):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("{call procGetTeamsInSameConferenceDivision(?)}", (team_id,))
    rows = cursor.fetchall()
    conn.close()

    results = [
        {
            "TeamID": row.TeamName,
            "Conference": row.Conference,
            "Division": row.Division,
            "TeamColors": row.TeamColors
        }
        for row in rows
    ]

    return {"data": results}
