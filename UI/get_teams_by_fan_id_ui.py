import streamlit as st
from API.get_teams_by_fan_id import get_teams_by_fan_id

def get_teams_by_fan_id_ui():
    st.header("Fan's Favorite Teams")

    input_parameters = {}
    