# Import necessary modules for the Flask web application
from flask import Flask, render_template, request
import pickle
import pandas as pd

# A Flask web application instance
app = Flask(__name__)

# Load the trained model and other data
pipe = pickle.load(open("XGB_pipeline.pkl", "rb"))

teams = [
    "Afghanistan",
    "Australia",
    "Bangladesh",
    "England",
    "India",
    "Ireland",
    "Kenya",
    "Netherlands",
    "New Zealand",
    "Pakistan",
    "Scotland",
    "South Africa",
    "Sri Lanka",
    "West Indies",
    "Zimbabwe",
]

cities = [
    "Abu Dhabi",
    "Adelaide",
    "Ahmedabad",
    "Antigua",
    "Auckland",
    "Bangalore",
    "Barbados",
    "Birmingham",
    "Bloemfontein",
    "Bridgetown",
    "Brisbane",
    "Bristol",
    "Bulawayo",
    "Canberra",
    "Cape Town",
    "Cardiff",
    "Chandigarh",
    "Chattogram",
    "Chester-le-Street",
    "Chennai",
    "Chittagong",
    "Christchurch",
    "Colombo",
    "Cuttack",
    "Dambulla",
    "Darwin",
    "Delhi",
    "Dhaka",
    "Dominica",
    "Dubai",
    "Dunedin",
    "Durban",
    "East London",
    "Fatullah",
    "Faisalabad",
    "Gqeberha",
    "Grenada",
    "Guyana",
    "Guwahati",
    "Harare",
    "Hamilton",
    "Hambantota",
    "Hobart",
    "Hyderabad",
    "Jaipur",
    "Jamaica",
    "Johannesburg",
    "Kandy",
    "Karachi",
    "Kochi",
    "Kolkata",
    "Kuala Lumpur",
    "Lahore",
    "Leeds",
    "London",
    "Manchester",
    "Melbourne",
    "Mirpur",
    "Mount Maunganui",
    "Mumbai",
    "Nagpur",
    "Napier",
    "Nelson",
    "Nottingham",
    "Paarl",
    "Pallekele",
    "Perth",
    "Port Elizabeth",
    "Potchefstroom",
    "Pune",
    "Rangiri",
    "Ranchi",
    "Rawalpindi",
    "Sharjah",
    "Southampton",
    "St Kitts",
    "St Lucia",
    "St Vincent",
    "Sydney",
    "Trinidad",
    "Visakhapatnam",
    "Wellington",
]


toss_decision_from_winner = ["bat", "field"]

venue = [
    "Abu Dhabi",
    "AMI Stadium",
    "Antigua",
    "Arun Jaitley Stadium, Delhi",
    "Barabati Stadium",
    "Basin Reserve",
    "Bay Oval",
    "Beausejour Stadium, Gros Islet",
    "Bellerive Oval",
    "Bharat Ratna Shri Atal Bihari Vajpayee Ekana Cricket Stadium, Lucknow",
    "Brabourne Stadium",
    "Buffalo Park",
    "Chester-le-Street",
    "County Ground",
    "Dubai International Cricket Stadium",
    "Dr. Y.S. Rajasekhara Reddy ACA-VDCA Cricket Stadium",
    "Dubai",
    "East London",
    "Eden Gardens",
    "Eden Park",
    "Edgbaston",
    "Feroz Shah Kotla",
    "Gaddafi Stadium",
    "Green Park",
    "Guyana",
    "Hagley Oval",
    "Harare Sports Club",
    "Headingley",
    "Himachal Pradesh Cricket Association Stadium",
    "JSCA International Stadium Complex",
    "Kanpur",
    "Kensington Oval, Bridgetown",
    "Khan Shaheb Osman Ali Stadium",
    "Kinrara Academy Oval",
    "Kingsmead",
    "Lord's",
    "MA Chidambaram Stadium, Chepauk",
    "Maharashtra Cricket Association Stadium",
    "Mahinda Rajapaksa International Cricket Stadium, Sooriyawewa",
    "Mangaung Oval",
    "McLean Park",
    "Mount Maunganui",
    "Nagpur",
    "Narendra Modi Stadium, Ahmedabad",
    "National Cricket Stadium, St George's",
    "National Stadium",
    "Nehru Stadium",
    "New Wanderers Stadium",
    "Newlands",
    "Old Trafford",
    "Pallekele International Cricket Stadium",
    "Punjab Cricket Association Stadium, Mohali",
    "Queens Sports Club",
    "R Premadasa Stadium",
    "R.Premadasa Stadium",
    "Rajiv Gandhi International Stadium, Uppal",
    "Riverside Ground",
    "Sardar Patel Stadium, Motera",
    "Saxton Oval",
    "Seddon Park",
    "Senwes Park",
    "Shaheed Chandu Stadium",
    "Sharjah Cricket Association Stadium",
    "Sharjah Cricket Stadium",
    "Shere Bangla National Stadium",
    "Sheikh Zayed Stadium",
    "Sinhalese Sports Club Ground",
    "Sir Vivian Richards Stadium, North Sound",
    "St George's Park",
    "SuperSport Park",
    "University Oval",
    "Vidarbha Cricket Association Stadium, Jamtha",
    "Wankhede Stadium",
    "Warner Park, Basseterre",
    "Westpac Stadium",
    "Western Australia Cricket Association Ground",
    "Windsor Park, Roseau",
    "Zahur Ahmed Chowdhury Stadium",
]


@app.route("/")
def frontpage():
    # Renders the frontpage.html template
    return render_template("frontpage.html")


# Handles both GET and POST requests for the index page
@app.route("/index", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        pass

    # Renders the index.html template with provided data
    return render_template(
        "index.html",
        teams=teams,
        cities=cities,
        toss_decisions=toss_decision_from_winner,
        venues=venue,
    )


@app.route("/predict", methods=["POST"])
def predict():
    # Handles POST requests for the predict page
    if request.method == "POST":
        # Retrieves form data from the request
        batting_team = request.form["batting_team"]
        bowling_team = request.form["bowling_team"]
        toss_winner = request.form["toss_winner"]
        toss_decision = request.form["toss_decision"]
        venue = request.form["venue"]
        city = request.form["city"]
        current_score = float(request.form["current_score"])
        overs = float(request.form["overs"])
        wickets = float(request.form["wickets"])
        last_five = float(request.form["last_five"])

        # Calculates additional parameters based on form data
        balls_left = 300 - (overs * 6)
        wickets_left = 10 - wickets
        crr = current_score / overs

        # Creates a DataFrame with the form data
        input_df = pd.DataFrame(
            {
                "batting_team": [batting_team],
                "bowling_team": [bowling_team],
                "toss_winner": [toss_winner],
                "toss_decision_from_winner": [toss_decision],
                "city": [city],
                "venue": [venue],
                "current_score": [current_score],
                "balls_left": [balls_left],
                "wickets_left": [wickets],
                "current_run_rate": [crr],
                "last_five": [last_five],
            }
        )

        # Uses a pre-trained model (pipe) to predict the score
        result = pipe.predict(input_df)

        # Renders the result.html template with the predicted score
        return render_template("result.html", predicted_score=int(result[0]))


if __name__ == "__main__":
    # Runs the Flask app in debug mode
    app.run(debug=True)
