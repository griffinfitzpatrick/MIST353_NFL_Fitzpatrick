import streamlit as st
from fetch_data import fetch_data

def get_teams_by_conference_division_ui():
    
    st.header("Get Teams by Conference and Division")

    #check using dropdowns for optionality of conference and division inputs
    #conference = st.selectbox("Select Conference:", ["", "AFC", "NFC"])
    #division = st.selectbox("Select Division:", ["", "East", "North", "South", "West"])

    conference = st.text_input("Enter conference (AFC or NFC):")
    division = st.text_input("Enter division (East, North, South, West):")

    if st.button("Fetch Teams"):
        input_params = {}
        if conference.strip():
            input_params["conference"] = conference
        if division.strip():
            input_params["division"] = division
        #define fetch_data function and call it with input_params
        df = fetch_data("get_teams_by_conference_division/", input_params)

        if df is not None and not df.empty:
            subheader = f"Teams in same conference ({conference}), division ({division}):"
            st.dataframe(df, use_container_width=True, hide_index=True)
        else:
            st.info(f"No teams found in the same conference and division as {team_name}..Please check the team name and try again.")