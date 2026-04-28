from get_db_connection import get_db_connection
from datetime import datetime
import pmysql

def schedule_game(
        home_team_id: int,
        away_team_id: int,
        game_round: int,
        game_date: str,
        game_time: str,
        stadium_id: int,
        nfl_admin_id: int
    ):
    
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute( "exec procScheduleGame %s, %s, %s, %s, %s, %s, %s", (home_team_id, away_team_id, game_round, game_date, game_time, stadium_id, nfl_admin_id) )
        conn.commit()
        return {"status_message": "Game scheduled successfully."}
    except exception as e:
        conn.rollback()
        if ("Unique key constraint" in str(e)):
            return {"status_message": "A game is already scheduled for the given date and time."}
        else:
            return {"status_message": f"An error occurred while scheduling the game: {e}"}
    finally:
        cursor.close()
        conn.close()

        