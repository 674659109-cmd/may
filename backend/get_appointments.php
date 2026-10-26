<?php
// get_appointments.php - Fetch all appointments
header('Content-Type: application/json; charset=utf-8');
require_once 'db_connect.php';

$sql = "SELECT * FROM appointments ORDER BY appointment_id DESC";
$result = $conn->query($sql);

$appointments = array();
if ($result && $result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $appointments[] = $row;
    }
}

echo json_encode(["success" => true, "data" => $appointments]);
$conn->close();
?>