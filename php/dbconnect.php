<?php
$servername = "localhost";
$username   = "moneymon_280769_mytutor_db";
$password   = "dDHku)tDT2JafnxZM2dr";
$dbname     = "moneymon_280769_mytutor_db";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}
?>