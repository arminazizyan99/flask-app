from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, from Docker container and Flask app!"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0',port=8080)

# comment for commit
# new comment