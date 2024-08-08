<?php
// Include your database connection file
include "db_connection.php";

$first_name = mysqli_real_escape_string($conn, $_POST['wfirst_name']);
$last_name = mysqli_real_escape_string($conn, $_POST['wlast_name']);
$worker_id = mysqli_real_escape_string($conn, $_POST['worker_id']);
$city = mysqli_real_escape_string($conn, $_POST['wcity']);
$state = mysqli_real_escape_string($conn, $_POST['wstate']);
$pin_code = mysqli_real_escape_string($conn, $_POST['wpin_code']);

// Insert into worker table using prepared statement
$sql = "INSERT INTO worker (wfirst_name, wlast_name, worker_id, wcity, wstate, wpin_code) 
        VALUES (?,?,?,?,?,?)";
$stmt = mysqli_prepare($conn, $sql);

// Bind parameters to the statement
mysqli_stmt_bind_param($stmt, "ssssss", $first_name, $last_name, $worker_id, $city, $state, $pin_code);

// Execute the prepared statement
if (mysqli_stmt_execute($stmt)) {
    // Insert successful
    header("Location: success.html");
    exit();
} else {
    // Handle the error
    echo "Error: " . mysqli_error($conn);
    // Log the error for further investigation
    error_log("Error: " . mysqli_error($conn));
}

// Close the prepared statement
mysqli_stmt_close($stmt);

// Close the database connection
mysqli_close($conn);
?>
