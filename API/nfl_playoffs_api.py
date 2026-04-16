from fastapi import FastAPI
from API.get_teams_by_fan_id import get_teams_by_fan_id
from get_teams_by_conference_division import get_teams_by_conference_division
from get_teams_in_same_conference_division_as_specified_team import get_teams_in_same_conference_division_as_specified_team
from validate_user import validate_user
from get_teams_for_specified_fan import router as fan_teams_router

app.include_router(fan_teams_router)

app = FastAPI()

@app.get("/get_teams_by_conference_division/")
def get_teams_by_conference_division_api(conference: str = None, division: str = None):
    return get_teams_by_conference_division(conference, division)

@app.get("/get_teams_in_same_conference_division_as_specififed_team/")
def get_teams_in_same_conference_division_as_specified_team_api(team_name: str):
    return get_teams_in_same_conference_division_as_specified_team(team_name=team_name)

@app.get("/validate_user/")
def validate_user_api(email: str, password_hash: str):
    return validate_user(email=email, password_hash=password_hash)

@app.get("/get_teams_by_fan_id/")
def get_teams_by_fan_id_api(fan_id: int):
    return get_teams_by_fan_id(fan_id=fan_id)