<?php

if (isset($_POST)){
    $response = array ('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die(); 
}

include_once("dbconnect.php");

$sqlloadproduct = "SELECT * FROM tbl_subjects";

$result = $conn->query($sqlloadproduct);

$result = $conn->query($sqlloadproduct);
if ($result->num_rows > 0) {
  
    $products["products"] = array();
    while ($row = $result->fetch_assoc()) {
        $prlist = array();
        $prlist['subject_id'] = $row['subject_id'];
        $prlist['subject_name'] = $row['subject_name'];
        $prlist['subject_description'] = $row['subject_description'];
        $prlist['subject_price'] = $row['subject_price'];
        $prlist['tutor_id'] = $row['tutor_id'];
        $prlist['subject_sessions'] = $row['subject_sessions'];
        $prlist['subject_rating'] = $row['subject_rating'];
        array_push($products["products"],$prlist);
    }
    $response = array('status' => 'success', 'data' => $products);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed','data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>