from fastapi import FastAPI
from get_teams_by_conference_division import get_teams_by_conference_division
from get_teams_in_same_conference_division_as_specified_team import get_teams_in_same_conference_division_as_specified_team


app = FastAPI()

@app.get("/teams_by_conference_division")
def get_teams_by_conference_division_api(conference: str = None, division: str = None):
    return get_teams_by_conference_division(conference, division)

@app.get("/teams_in_same_conference_division")
def get_teams_in_same_conference_division_api(team_id: str):
    return get_teams_in_same_conference_division_as_specified_team(team_id)

