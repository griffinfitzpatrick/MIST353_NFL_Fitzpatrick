import streamlit as st
from fetch_data import post_data
from datetime import date, time

def schedule_game_ui():
    st.header("Schedule a Game")

# Fetch teams for dropdowns
    parameters = {}
    teams_df = post_data("get_all_teams/", parameters)
    stadiums_df = post_data("get_all_stadiums/", parameters)

    game_rounds = ["Wildcard", "Divisional", "Conference", "Super Bowl"]

    #Create dropdowns for home team, away team, stadium, and game round
    team_options = dict(zip(teams_df["TeamName"], teams_df["TeamID"]))
    stadium_options = dict(zip(stadiums_df["StadiumName"], stadiums_df["StadiumID"]))

    home_team = st.selectbox("Select Home Team", options=team_options.keys())
    away_team = st.selectbox("Select Away Team", options=team_options.keys())
    stadium_name = st.selectbox("Select Stadium", options=stadium_options.keys())
    game_round = st.selectbox("Select Game Round", options=game_rounds)

    if st.button("Schedule Game"):
        if home_team == away_team:
            st.error("Home Team and Away Team cannot be the same.")
            return
        
        input_params = {
            "home_team_id": team_options[home_team],
            "away_team_id": team_options[away_team],
            "game_round": game_round,
            "game_date": date.today().isoformat(),  # Placeholder for game date
            "game_time": time(12, 0).isoformat(),  # Placeholder for game time
            "stadium_id": stadium_options[stadium_name],
            "nfl_admin_id": 1  # Placeholder for NFL Admin ID
        }
        response = post_data("schedule_game/", input_params)
        st.info(response.get("status_message", "No response message received."))