<?php
// update_status.php - Update appointment status (CONFIRMED / CANCELLED)
header('Content-Type: application/json; charset=utf-8');
require_once 'db_connect.php';

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    $input = $_POST;
}

$appointment_id = $input['appointment_id'] ?? 0;
$status = $input['status'] ?? 'PENDING';

if ($appointment_id == 0) {
    echo json_encode(["success" => false, "error" => "Invalid appointment ID."]);
    exit();
}

$stmt = $conn->prepare("UPDATE appointments SET status = ? WHERE appointment_id = ?");
$stmt->bind_param("si", $status, $appointment_id);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Appointment status updated to $status"]);
} else {
    echo json_encode(["success" => false, "error" => $stmt->error]);
}

$stmt->close();
$conn->close();
?>