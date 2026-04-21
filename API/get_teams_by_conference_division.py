from get_db_connection import get_db_connection
import pymssql

def get_teams_by_conference_division(
        conference: str = None,
        division: str = None
    ):
    # Validate input parameters
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)
    #cursor.execute("{call procGetTeamsByConferenceDivision(?, ?)}", (conference, division))
    cursor.callproc("procGetTeamsByConferenceDivision", (conference, division)) #2 or more params and no params
    #cursor.execute("exec procGetTeamsByConferenceDivision @Conference=%s, @Division=%s", (conference, division))
    rows = cursor.fetchall()
    conn.close()

    #Convert the rows to a list of dictionaries
    results = [
        {
            "TeamName": row["TeamName"],
            "Conference": row["Conference"],
            "Division": row["Division"],
            "TeamColors": row["TeamColors"] 
        }
        for row in rows
    ]

    return {"data": results}