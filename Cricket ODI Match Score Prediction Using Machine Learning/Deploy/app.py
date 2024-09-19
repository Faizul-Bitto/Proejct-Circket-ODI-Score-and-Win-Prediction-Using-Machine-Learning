# from flask import Flask, request, jsonify
# import pickle
# import pandas as pd
# from flask_cors import CORS

# app = Flask(__name__)
# CORS(app)

# # Loading the trained model
# with open("XGB_pipeline.pkl", "rb") as f:
#     pipe = pickle.load(f)

# # Extracting known categories from the pipeline for each feature
# preprocessor = pipe.named_steps["preprocessor"]
# categorical_transformer = preprocessor.transformers_[1][
#     1
# ]  # Getting the OneHotEncoder for categorical features
# categories = categorical_transformer.categories_


# TEAMS = categories[0].tolist()
# CITIES = categories[4].tolist()
# TOSS_DECISION_FROM_WINNER = categories[3].tolist()
# VENUES = categories[5].tolist()


# @app.route("/")
# def home():
#     return "Cricket Score Predictor API"


# @app.route("/teams", methods=["GET"])
# def get_teams():
#     return jsonify(TEAMS)


# @app.route("/cities", methods=["GET"])
# def get_cities():
#     return jsonify(CITIES)


# @app.route("/venues", methods=["GET"])
# def get_venues():
#     return jsonify(VENUES)


# @app.route("/toss_decisions", methods=["GET"])
# def get_toss_decisions():
#     return jsonify(TOSS_DECISION_FROM_WINNER)


# @app.route("/predict", methods=["POST"])
# def predict():
#     data = request.get_json()

#     # Input validation
#     required_fields = [
#         "batting_team",
#         "bowling_team",
#         "toss_winner",
#         "toss_decision",
#         "venue",
#         "city",
#         "current_score",
#         "overs",
#         "wickets",
#         "last_five",
#     ]
#     for field in required_fields:
#         if field not in data:
#             return (
#                 jsonify({"error": f"Missing required field: {field}"}),
#                 400,
#             )  # Bad Request

#     batting_team = data["batting_team"]
#     bowling_team = data["bowling_team"]
#     toss_winner = data["toss_winner"]
#     toss_decision = data["toss_decision"]
#     venue = data["venue"]
#     city = data["city"]
#     current_score = float(data["current_score"])
#     overs = float(data["overs"])
#     wickets = float(data["wickets"])
#     last_five = float(data["last_five"])

#     balls_left = 300 - (overs * 6)
#     wickets_left = 10 - wickets
#     crr = current_score / overs

#     input_df = pd.DataFrame(
#         {
#             "batting_team": [batting_team],
#             "bowling_team": [bowling_team],
#             "toss_winner": [toss_winner],
#             "toss_decision_from_winner": [toss_decision],
#             "city": [city],
#             "venue": [venue],
#             "current_score": [current_score],
#             "balls_left": [balls_left],
#             "wickets_left": [wickets],
#             "current_run_rate": [crr],
#             "last_five": [last_five],
#         }
#     )

#     result = pipe.predict(input_df)

#     return jsonify({"predicted_score": int(result[0])})


# # Add a new route for win prediction
# @app.route("/predict_win", methods=["POST"])
# def predict_win():
#     data = request.get_json()

#     # Input validation
#     required_fields = [
#         "batting_team",
#         "bowling_team",
#         "toss_winner",
#         "toss_decision",
#         "venue",
#         "city",
#         "first_innings_total",
#         "current_score",
#         "overs",
#         "wickets",
#         "last_five",
#     ]

#     for field in required_fields:
#         if field not in data:
#             return (
#                 jsonify({"error": f"Missing required field: {field}"}),
#                 400,
#             )  # Bad Request

#     batting_team = data["batting_team"]
#     bowling_team = data["bowling_team"]
#     toss_winner = data["toss_winner"]
#     toss_decision = data["toss_decision"]
#     venue = data["venue"]
#     city = data["city"]
#     current_score = float(data["current_score"])
#     overs = float(data["overs"])
#     wickets = float(data["wickets"])
#     last_five = float(data["last_five"])

#     balls_left = 300 - (overs * 6)
#     wickets_left = 10 - wickets
#     crr = current_score / overs

#     # Calculate the target score for the chasing team
#     target_score = int(data["first_innings_total"])

#     # Make predictions for the chasing team's score
#     input_df = pd.DataFrame(
#         {
#             "batting_team": [batting_team],
#             "bowling_team": [bowling_team],
#             "toss_winner": [toss_winner],
#             "toss_decision_from_winner": [toss_decision],
#             "city": [city],
#             "venue": [venue],
#             "current_score": [current_score],
#             "balls_left": [balls_left],
#             "wickets_left": [wickets],
#             "current_run_rate": [crr],
#             "last_five": [last_five],
#         }
#     )
#     predicted_score = int(pipe.predict(input_df)[0])

#     # Determine the win outcome
#     if predicted_score > target_score:
#         win_outcome = "win"
#     elif predicted_score < target_score:
#         win_outcome = "lose"
#     else:
#         win_outcome = "draw"

#     return jsonify({"predicted_score": predicted_score, "win_outcome": win_outcome})


# if __name__ == "__main__":
#     app.run(debug=True)


from flask import Flask, request, jsonify
import pickle
import pandas as pd
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Loading the trained model
with open("XGB_pipeline.pkl", "rb") as f:
    pipe = pickle.load(f)

# Extracting known categories from the pipeline for each feature
preprocessor = pipe.named_steps["preprocessor"]
categorical_transformer = preprocessor.transformers_[1][
    1
]  # Getting the OneHotEncoder for categorical features
categories = categorical_transformer.categories_

TEAMS = categories[0].tolist()
CITIES = categories[4].tolist()
TOSS_DECISION_FROM_WINNER = categories[3].tolist()
VENUES = categories[5].tolist()


@app.route("/")
def home():
    return "Cricket Score Predictor API"


@app.route("/teams", methods=["GET"])
def get_teams():
    return jsonify(TEAMS)


@app.route("/cities", methods=["GET"])
def get_cities():
    return jsonify(CITIES)


@app.route("/venues", methods=["GET"])
def get_venues():
    return jsonify(VENUES)


@app.route("/toss_decisions", methods=["GET"])
def get_toss_decisions():
    return jsonify(TOSS_DECISION_FROM_WINNER)


@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()

    # Input validation
    required_fields = [
        "batting_team",
        "bowling_team",
        "toss_winner",
        "toss_decision",
        "venue",
        "city",
        "current_score",
        "overs",
        "wickets",
        "last_five",
    ]
    for field in required_fields:
        if field not in data:
            return (
                jsonify({"error": f"Missing required field: {field}"}),
                400,
            )  # Bad Request

    batting_team = data["batting_team"]
    bowling_team = data["bowling_team"]
    toss_winner = data["toss_winner"]
    toss_decision = data["toss_decision"]
    venue = data["venue"]
    city = data["city"]
    current_score = float(data["current_score"])
    overs = float(data["overs"])
    wickets = float(data["wickets"])
    last_five = float(data["last_five"])

    balls_left = 300 - (overs * 6)
    wickets_left = 10 - wickets
    crr = current_score / overs

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

    result = pipe.predict(input_df)

    return jsonify({"predicted_score": int(result[0])})


@app.route("/predict_win", methods=["POST"])
def predict_win():
    data = request.get_json()

    # Input validation
    required_fields = [
        "batting_team",
        "bowling_team",
        "toss_winner",
        "toss_decision",
        "venue",
        "city",
        "first_innings_total",
        "current_score",
        "overs",
        "wickets",
        "last_five",
    ]
    for field in required_fields:
        if field not in data:
            return (
                jsonify({"error": f"Missing required field: {field}"}),
                400,
            )  # Bad Request

    batting_team = data["batting_team"]
    bowling_team = data["bowling_team"]
    toss_winner = data["toss_winner"]
    toss_decision = data["toss_decision"]
    venue = data["venue"]
    city = data["city"]
    current_score = float(data["current_score"])
    overs = float(data["overs"])
    wickets = float(data["wickets"])
    last_five = float(data["last_five"])
    first_innings_total = int(data["first_innings_total"])

    balls_left = 300 - (overs * 6)
    wickets_left = 10 - wickets
    crr = current_score / overs

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

    predicted_score = int(pipe.predict(input_df)[0])

    if predicted_score > first_innings_total:
        win_outcome = "win"
    elif predicted_score < first_innings_total:
        win_outcome = "lose"
    else:
        win_outcome = "draw"

    return jsonify({"predicted_score": predicted_score, "win_outcome": win_outcome})


if __name__ == "__main__":
    app.run(debug=True)
