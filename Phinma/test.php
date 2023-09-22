<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Database configuration (adjust these settings)
$servername = "localhost";
$dbusername = "root";
$dbpassword = "";
$dbname = "dbgasapp";

// Create a connection to the database
$conn = new mysqli($servername, $dbusername, $dbpassword, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["action"])) {
    if ($_POST["action"] == "addRestaurant") {
        $name = $_POST["name"];
        $latitude = $_POST["latitude"];
        $longitude = $_POST["longitude"];
        $gasName = $_POST["gas_name"];
        $gasPrice = $_POST["gas_price"];

        // Insert gas station information
        $sql = "INSERT INTO gasstation (name, latitude, longitude) VALUES ('$name', $latitude, $longitude)";
        if ($conn->query($sql) === TRUE) {
            $gasstationId = $conn->insert_id;

            // Insert gas item for the gas station
            $sql = "INSERT INTO items (gasstation_id, gas_name, gas_price) VALUES ($gasstationId, '$gasName', $gasPrice)";
            if ($conn->query($sql) === TRUE) {
                echo json_encode(array("message" => "Gas item added successfully"));
            } else {
                echo json_encode(array("message" => "Failed to add gas item: " . $conn->error));
            }
        } else {
            echo json_encode(array("message" => "Failed to add gas station: " . $conn->error));
        }
    }
}

// Handle GET request to retrieve gas stations and gas items
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    $sql = "SELECT g.id, g.name, g.latitude, g.longitude, i.gas_name, i.gas_price FROM gasstation g
            LEFT JOIN items i ON g.id = i.gasstation_id";

    $result = $conn->query($sql);
    $gasstations = array();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $gasstationId = $row["id"];
            $gasstationName = $row["name"];
            $latitude = $row["latitude"];
            $longitude = $row["longitude"];
            $gasName = $row["gas_name"];
            $gasPrice = $row["gas_price"];

            // Create a gas station object
            $gasstation = array(
                "id" => $gasstationId,
                "name" => $gasstationName,
                "location" => array("latitude" => $latitude, "longitude" => $longitude),
                "menu" => array(
                    array("gas_name" => $gasName, "gas_price" => $gasPrice)
                )
            );

            // Group gas items by gas station
            if (isset($gasstations[$gasstationId])) {
                $gasstations[$gasstationId]["menu"][] = array("gas_name" => $gasName, "gas_price" => $gasPrice);
            } else {
                $gasstations[$gasstationId] = $gasstation;
            }
        }
    }

    // Return JSON response
    echo json_encode(array_values($gasstations));
}

// Close the database connection
$conn->close();
?>
