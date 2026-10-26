<?php
// create_appointment.php - Insert a new appointment
header('Content-Type: application/json; charset=utf-8');
require_once 'db_connect.php';

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    $input = $_POST;
}

$title = $input['title'] ?? '';
$student_id = $input['student_id'] ?? 1;
$lecturer_id = $input['lecturer_id'] ?? 1;
$department_id = $input['department_id'] ?? 3;
$building_id = $input['building_id'] ?? 16;
$room_number = $input['room_number'] ?? 'ห้อง 301';
$appointment_date = $input['appointment_date'] ?? '24 พ.ค. 2567';
$appointment_time = $input['appointment_time'] ?? '10:30 - 11:30 น.';
$topic = $input['topic'] ?? '';

if (empty($title) || empty($topic)) {
    echo json_encode(["success" => false, "error" => "Title and topic are required."]);
    exit();
}

$stmt = $conn->prepare("INSERT INTO appointments (title, student_id, lecturer_id, department_id, building_id, room_number, appointment_date, appointment_time, topic, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'PENDING')");
$stmt->bind_param("siiiiisss", $title, $student_id, $lecturer_id, $department_id, $building_id, $room_number, $appointment_date, $appointment_time, $topic);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Appointment created successfully", "appointment_id" => $stmt->insert_id]);
} else {
    echo json_encode(["success" => false, "error" => $stmt->error]);
}

$stmt->close();
$conn->close();
?>