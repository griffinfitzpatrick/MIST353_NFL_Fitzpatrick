from get_db_connection import get_db_connection

def get_teams_in_same_conference_division_as_specified_team(
        team_name: str
):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("{call procGetTeamsInSameConferenceDivisionAsSpecifiedTeam(?)}", (team_name,))
    cursose.call()proc("procGetTeamsInSameConferenceDivisionAsSpecifiedTeam", (team_name,))
    #cursor
    rows = cursor.fetchall()
    conn.close()

    #covert pyodbc rows to list of dictionaries
    results = [
        {
            "TeamName": row[0],
            "Conference": row[1],
            "Division": row[2],
        }
        for row in rows
    ]

    return {"data": results}