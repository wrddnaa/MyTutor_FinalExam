<?php
if (!isset($_POST)){
    echo "failed";
}

include_once("dbconnect.php");
$email = $POST['email'];
$password = sha1($_POST['password']);
$sqllogin = "SELECT * FROM member WHERE mEmail = '$email' AND mPassword = '$password'";
$result = $conn->query($sqllogin);
$numrow = $result->num_rows; 

if ($numrow > 0){
    while ($row = $result->fetch_assoc()){
    $member['phonenum'] = $row['mPhoneNum'];
    $member['name'] = $row['mName'];
    $member['address'] = $row['mAddress'];
    $member['email'] = $row['mEmail'];
    $member['password'] = $row['mPassword'];
}
$response = array('status' => 'success','data' => $member);
sendJsonResponse($response);
} else{
   $response = array('status' => 'failed','data' => null);
   sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>