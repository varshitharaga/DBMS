// db_connection.php
<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "sql_script";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
} else {
    echo "Connected successfully";
}
?>
