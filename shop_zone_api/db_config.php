<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "jan_g_shopy_userseller";

$connectNow = new mysqli($host, $username, $password, $database);
if ($connectNow->connect_error) {
    die("Connection failed: " . $connectNow->connect_error);
}
?>
