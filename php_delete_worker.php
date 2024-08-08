<?php
// Include your database connection file
include "db_connection.php";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action']) && $_POST['action'] == 'delete' && isset($_POST['worker_id'])) {
    // Check if action is 'delete' and worker_id is provided in the request
    $worker_id = mysqli_real_escape_string($conn, $_POST['worker_id']);

    // Prepare the SQL statement for deletion
    $deleteSql = "DELETE FROM worker WHERE worker_id = ?";
    $deleteStmt = mysqli_prepare($conn, $deleteSql);
    mysqli_stmt_bind_param($deleteStmt, "s", $worker_id);

    // Execute the prepared statement for deletion
    if (mysqli_stmt_execute($deleteStmt)) {
        // Deletion successful
        header("Location: success.html");
        exit();
    } else {
        // Handle the error
        echo "Error deleting worker: " . mysqli_error($conn);
        error_log("Error deleting worker: " . mysqli_error($conn));
    }

    // Close the prepared statement for deletion
    mysqli_stmt_close($deleteStmt);
} else {
    // Invalid request for deletion, handle accordingly
    echo "Invalid deletion request!";
}

// Close the database connection
mysqli_close($conn);
?>
