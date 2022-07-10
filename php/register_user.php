<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$name = $_POST['name']; 
$email = $_POST['email'];
$phonenum = $_POST['phonenum'];
$password = $_POST['password'];
$address = $_POST['address'];
$base64image = $_POST['image'];
$sqlinsert = "INSERT INTO `member`( `mName`, `mEmail`, `mPhoneNum`, `mPassword`, `mAddress`) 

VALUES ('$name','$email','$phonenum','$password','$address')";

if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = mysqli_insert_id($conn);
    $decoded_string = base64_decode($base64image);
    $path = '../assets/user/' . $filename . '.jpg';
    $is_written = file_put_contents($path, $decoded_string);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>