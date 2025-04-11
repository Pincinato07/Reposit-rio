from flask import Flask, render_template, request, jsonify
from flask_socketio import SocketIO

app = Flask(__name__)
socketio = SocketIO(app)

# Store the latest temperature and humidity values
latest_data = {"temperature": 0.0, "humidity": 0.0, "simulate": False}
simulated_values = {"temperature": 25.0, "humidity": 50.0}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/update', methods=['POST'])
def update():
    global latest_data
    data = request.get_json()
    latest_data["temperature"] = data.get("temperature", latest_data["temperature"])
    latest_data["humidity"] = data.get("humidity", latest_data["humidity"])

    # Emit the updated data to all connected clients
    socketio.emit('update_data', latest_data)

    # Send back the simulated values
    response = {
        "temperature": simulated_values["temperature"],
        "humidity": simulated_values["humidity"],
        "simulate": latest_data["simulate"]
    }
    return jsonify(response)

@app.route('/set_simulation', methods=['POST'])
def set_simulation():
    global latest_data, simulated_values
    data = request.get_json()
    simulated_values["temperature"] = float(data.get("temperature", simulated_values["temperature"]))
    simulated_values["humidity"] = float(data.get("humidity", simulated_values["humidity"]))
    latest_data["simulate"] = data.get("simulate", False)

    # Emit the updated data to all connected clients
    socketio.emit('update_data', latest_data)
    return jsonify({"status": "success"})

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=5000, debug=True)