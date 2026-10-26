<?php
// db_connect.php - Database connection for XAMPP MySQL
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'campus_meet_db';

$conn = new mysqli($host, $username, $password, $dbname);
$conn->set_charset("utf8mb4");

if ($conn->connect_error) {
    header('Content-Type: application/json');
    echo json_encode(["success" => false, "error" => "Database connection failed: " . $conn->connect_error]);
    exit();
}
?>