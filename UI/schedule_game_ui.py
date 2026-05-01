import streamlit as st
from fetch_data import post_data
from datetime import date, time

def schedule_game_ui():
    st.header("Schedule a Game")

    # Require logged-in admin
    if "user_id" not in st.session_state:
        st.error("You must be logged in as an Admin to schedule a game.")
        return

    nfl_admin_id = st.session_state["user_id"]

    # Fetch teams and stadiums
    parameters = {}
    teams_df = post_data("get_all_teams/", parameters)
    stadiums_df = post_data("get_all_stadiums/", parameters)

    game_rounds = ["Wildcard", "Divisional", "Conference", "Super Bowl"]

    # Dropdown options
    team_options = dict(zip(teams_df["TeamName"], teams_df["TeamID"]))
    stadium_options = dict(zip(stadiums_df["StadiumName"], stadiums_df["StadiumID"]))

    home_team = st.selectbox("Select Home Team", options=team_options.keys())
    away_team = st.selectbox("Select Away Team", options=team_options.keys())
    stadium_name = st.selectbox("Select Stadium", options=stadium_options.keys())
    game_round = st.selectbox("Select Game Round", options=game_rounds)

    game_date = st.date_input("Select Game Date", value=date.today())
    game_time = st.time_input("Select Game Time", value=time(13, 0))

    if st.button("Schedule Game"):
        if home_team == away_team:
            st.error("Home Team and Away Team cannot be the same.")
            return
        
        input_params = {
            "home_team_id": team_options[home_team],
            "away_team_id": team_options[away_team],
            "game_round": game_round,
            "game_date": game_date.isoformat(),
            "game_time": game_time.isoformat(),
            "stadium_id": stadium_options[stadium_name],
            "nfl_admin_id": nfl_admin_id
        }
        response = post_data("schedule_game/", input_params)
        st.info(response.get("status_message", "No response message received."))