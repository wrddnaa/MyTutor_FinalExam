<?php
if(!isset($_POST)){
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$subject_id = $_POST['subject_id'];
$email = $_POST['email'];
$cartqty = "1";
$carttotal = 0;

$sqlchecksubj = "SELECT * FROM tbl_subject where subject_id = '$subject_id'";
$resultsubject = $conn->query($sqlchecksubj);
$num_of_subject = $resultsubj->num_rows;
if ($num_of_subject>1){
    $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
        return;
}

$sqlinsert = "SELECT * FROM tbl_cart WHERE user_email = '$email' AND subject_id = $subject_id' AND cart_stus IS NULL";
$subjectInCart = $sqlinsert;
$result = $conn->query($sqlinsert);
$num_of_result = $result->num_rows;

if($num_of_result == 0){
    $add_cart = "INSERT INTO 'tbl_cart'('user_email, 'subject_id', 'cart_qty') VALUES ('$email', '$subject_id', '$cartqty')";
    if ($conn->query($addcart) == TRUE){

    }else{
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
        return;
    }
}

$sqlgetqty = "SELECT * FROM tbl_cart WHERE user_email = '$email' AND cart_stus IS NULL";
$result = $conn->query($sqlgetqty);
$num_of_result = $result->num_rows();
$carttotal = 0;
while($row = $result->fetch_assoc()){
    $carttotal += $row['cart_qty'] + $carttotal;
}

$mycart = array();
$mycart['carttotal'] =$carttotal;
$response = array('status' => 'success', 'data' => $mycart);
sendJsonResponse($response);

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>
