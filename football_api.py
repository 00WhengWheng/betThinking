import os
from dotenv import load_dotenv
import requests
from datetime import datetime, timedelta
import random

# Load the API key from .env file
load_dotenv()
API_KEY = os.getenv("API_KEY")

BASE_URL = "https://api.football-data.org/v2"

def get_data(endpoint, params=None):
    headers = {"X-Auth-Token": API_KEY}
    try:
        response = requests.get(f"{BASE_URL}/{endpoint}", headers=headers, params=params)
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        print(f"API request failed: {e}")
        return None

def get_competitions():
    return get_data("competitions") or {"competitions": []}

def get_matches(competition_id):
    return get_data(f"competitions/{competition_id}/matches") or {"matches": []}

def get_team(team_id):
    return get_data(f"teams/{team_id}") or {}

def get_fake_todays_matches():
    teams = ["Manchester United", "Liverpool", "Chelsea", "Arsenal", "Manchester City", 
             "Tottenham", "Leicester City", "Everton", "West Ham", "Aston Villa"]

    matches = []
    today = datetime.now().date()

    for i in range(5):  # Generate 5 fake matches
        home_team = random.choice(teams)
        away_team = random.choice([t for t in teams if t != home_team])

        kickoff_time = datetime.now().replace(hour=random.randint(12, 21), minute=random.choice([0, 30]))

        match = {
            "id": i + 1,
            "homeTeam": {"name": home_team},
            "awayTeam": {"name": away_team},
            "utcDate": kickoff_time.isoformat(),
            "status": random.choice(["SCHEDULED", "LIVE", "IN_PLAY", "PAUSED", "FINISHED"]),
            "score": {
                "fullTime": {
                    "homeTeam": random.randint(0, 5),
                    "awayTeam": random.randint(0, 5)
                }
            }
        }
        matches.append(match)

    return {"matches": matches}