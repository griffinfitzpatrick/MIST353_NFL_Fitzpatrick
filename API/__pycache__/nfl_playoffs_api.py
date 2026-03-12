from fastapi import FastAPI
from get_teams_by_conference import get_teams_by_conference_division
app = FastAPI()

@app.get("/teams")
def read_teams(conference: str = None, division: str = None):
    teams = get_teams_by_conference_division(conference, division)
    return {"teams": teams}