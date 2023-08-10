from flask import Flask, request, jsonify
from collabfilter import getTop5movieForAuser

app = Flask(__name__)

@app.route('/getTop5mealForAuser', methods=['GET'])
def getTop5mealForAuser():
    
    userId = request.args.get('userId')
    print('we got the userId: ', userId)
    
    if userId is None:
        return jsonify({'error': 'userId is required'})
    
    meals = getTop5movieForAuser(userId)

    # convert document to dictionary
    meals = [meal.to_dict() for meal in meals]
    print(meals)
    return jsonify(meals)

if __name__ == '__main__':
    app.run(debug=True, port=5000)
