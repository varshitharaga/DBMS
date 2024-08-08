<?php
// Include your database connection file
include "db_connection.php";

$first_name = mysqli_real_escape_string($conn, $_POST['cfirst_name']);
        $last_name = mysqli_real_escape_string($conn, $_POST['clast_name']);
        $client_id = mysqli_real_escape_string($conn, $_POST['client_id']);
        $city = mysqli_real_escape_string($conn, $_POST['ccity']);
        $state = mysqli_real_escape_string($conn, $_POST['cstate']);
        $pin_code = mysqli_real_escape_string($conn, $_POST['cpin_code']);

        // Insert into worker table using prepared statement
        $sql = "INSERT INTO client (cfirst_name, clast_name,client_id,  ccity, cstate, cpin_code) 
                VALUES (?,?,?,?,?,?);";
        $stmt = mysqli_prepare($conn, $sql);
        // Bind parameters to the statement
mysqli_stmt_bind_param($stmt, "ssssss", $first_name, $last_name,$client_id, $city, $state, $pin_code);

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
