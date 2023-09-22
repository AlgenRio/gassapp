<?php
    $servername = "localhost";
    $dbusername = "root";
    $dbpassword = "";
    $dbname = "dbgasapp";

    try{
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $dbusername, $dbpassword);
        $conn -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        //  echo 'SUCCESFULLY CONNECT TO DATABASE ACTIVITY!';
    }catch(PDOException $error){
        $error->getMessage();
        echo 'UNSUCCESFULLY CONNECT TO DATABASE YEARBOOK!';
    }


?>