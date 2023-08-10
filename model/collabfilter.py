from index import getAllMeals, getAllUsers
import numpy as np
import tensorflow as tf
import os
from tensorflow import keras

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

users = getAllUsers()
meals = getAllMeals()


# build the rating matrix
n, m = len(users), len(meals)
matrix = [[0] * n  for _ in range(m)]

# create a matrix that has 1 if the user has rated the meal and 0 otherwise
meal_rated = np.zeros((m, n))

# map the id of the users to use it later
index_map = {}
for idx, user in enumerate(users):
    index_map[user.uid] = idx

# fill the matrix
for row, meal in enumerate(meals):
    meal = meal.to_dict()
    ratings = meal['ratings']

    if ratings is None:
        continue

    for rating in meal['ratings']:
        matrix[row][index_map[rating['userId']]] = rating['rating']
        meal_rated[row][index_map[rating['userId']]] = 1

def getMeanSkippingNan(arr):
    new_array = [val for val in arr if val is not None]
    return np.mean(new_array) if len(new_array) > 0 else 0

# seed the random number generator
np.random.seed(1224)

# create the meal feature vector
meal_feature_vector = np.random.rand(m, 10)
weight_vector_for_users = np.random.rand(n, 10)
constant_factor_b = np.random.rand(1, n)
user_ratings = np.array(matrix)
regularisation_factor = 0.01

def costFuncWithVectorization():
    cost = (tf.linalg.matmul(meal_feature_vector, tf.transpose(weight_vector_for_users)) + constant_factor_b - user_ratings) * meal_rated
    cost = 0.5 * tf.reduce_sum(cost**2) + (regularisation_factor/2) * (tf.reduce_sum(meal_feature_vector**2) + tf.reduce_sum(weight_vector_for_users**2))
    return cost

# check function to cross check the vectorized function
def costFunc():
    cost = 0
    for col in range(n):
        weight_for_user = weight_vector_for_users[col, :]
        constant_factor_for_user = constant_factor_b[0, col]

        for row in range(m):
            if user_ratings[row, col] is None:
                continue

            current_meal_feature_vector = meal_feature_vector[row, :]
            user_ratings_for_meal = user_ratings[row,col]
            cost += np.square(constant_factor_for_user + np.dot(weight_for_user, current_meal_feature_vector) - user_ratings_for_meal)

    cost /= 2
    cost += regularisation_factor * (np.sum(np.square(weight_vector_for_users)) + np.sum(np.square(meal_feature_vector)))

    return cost

meal_feature_vector = tf.Variable(meal_feature_vector, name='meal_feature_vector')
weight_vector_for_users = tf.Variable(weight_vector_for_users, name='weight_vector_for_users')
constant_factor_b = tf.Variable(constant_factor_b, name='constant_factor_b')
optimizer = tf.optimizers.Adam(learning_rate=0.001)

def gradientDecent():
    iterations = 1000
    for _ in range(iterations):
        with tf.GradientTape() as tape:
            cost = costFuncWithVectorization()
            
        gradients = tape.gradient(cost, [meal_feature_vector, weight_vector_for_users, constant_factor_b])
        optimizer.apply_gradients(zip(gradients, [meal_feature_vector, weight_vector_for_users, constant_factor_b]))


def getTop5movieForAuser(userId):
    # calculate the model parameters
    gradientDecent()

    # get the feature vector for the user
    user_feature_vector = weight_vector_for_users[index_map[userId], :]

    # calculate the predicted ratings
    predicted_ratings = np.dot(meal_feature_vector, user_feature_vector) + constant_factor_b[0, index_map[userId]]
    
    # sort the ratings
    predicted_ratings = np.array(predicted_ratings)
    predicted_ratings = predicted_ratings.reshape(-1)
    predicted_ratings = predicted_ratings.tolist()

    # print(predicted_ratings)    
    # get the top 5 movies
    top5 = []
    for i in range(5):
        max_index = predicted_ratings.index(max(predicted_ratings))
        top5.append(meals[max_index])
        predicted_ratings[max_index] = -1

    return top5


# print(getTop5movieForAuser('Xv5CTaJdgKd24cUitdbyFLWI6QC3'))































