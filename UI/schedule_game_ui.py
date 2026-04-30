import streamlit as st
from fetch_data import fetch_data, post_data

def schedule_game_ui():
    print("Schedule a Game")
    home_team_id = int(input("Enter Home Team ID: "))
    away_team_id = int(input("Enter Away Team ID: "))
    game_round = int(input("Enter Game Round: "))
    game_date = input("Enter Game Date (YYYY-MM-DD): ")
    game_time = input("Enter Game Time (HH:MM:SS): ")
    stadium_id = int(input("Enter Stadium ID: "))
    nfl_admin_id = int(input("Enter NFL Admin ID: "))

    #Convert date and time strings

    if st.button("Schedule Game"):
        #Call the API to schedule the game
        result = fetch_data(
            "schedule_game/",
            {
                "home_team_id": home_team_id,
                "away_team_id": away_team_id,
                "game_round": game_round,
                "game_date": game_date.isoformat(),
                "game_time": game_time.isoformat(),
                "stadium_id": stadium_id,
                "nfl_admin_id": nfl_admin_id
            },
            method="POST"
    )
    st.write(result)
