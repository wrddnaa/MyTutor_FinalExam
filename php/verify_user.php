<?php
    error_reporting(0);
    include_once("dbconnect.php");
    
    $email = $_GET['email'];
    $otp = $_GET['key'];
    $sql = "SELECT * FROM member WHERE mEmail = '$email' AND otp= '$otp'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE member SET otp = '0' WHERE email = '$email'";
        if ($conn->query($sqlupdate) === TRUE){
            echo 'success';
        }else{
            echo 'failed';
        }   
    }else{
        echo "failed";
    } 
?>