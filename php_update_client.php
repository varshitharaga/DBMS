<?php
include "db_connection.php";

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Check if worker_id is provided in the form data
    if (isset($_POST['client_id'])) {
        $client_id = mysqli_real_escape_string($conn, $_POST['client_id']);
        $first_name = mysqli_real_escape_string($conn, $_POST['cfirst_name']);
        $last_name = mysqli_real_escape_string($conn, $_POST['clast_name']);
        $city = mysqli_real_escape_string($conn, $_POST['ccity']);
        $state = mysqli_real_escape_string($conn, $_POST['cstate']);
        $pin_code = mysqli_real_escape_string($conn, $_POST['cpin_code']);

        // Check if worker_id exists to determine if it's an update or insert
        $checkSql = "SELECT * FROM client WHERE client_id = ?";
        $checkStmt = mysqli_prepare($conn, $checkSql);
        mysqli_stmt_bind_param($checkStmt, "s", $client_id);
        mysqli_stmt_execute($checkStmt);
        $result = mysqli_stmt_get_result($checkStmt);
        $row = mysqli_fetch_assoc($result);
        mysqli_stmt_close($checkStmt);

        if ($row) {
            // Worker ID exists, update the record
            $updateSql = "UPDATE client SET";
            $updateParams = array();

            // Check each form field and add it to the update query if provided
            if (!empty($first_name)) {
                $updateSql .= " cfirst_name=?,";
                $updateParams[] = $first_name;
            }
            if (!empty($last_name)) {
                $updateSql .= " clast_name=?,";
                $updateParams[] = $last_name;
            }
            if (!empty($city)) {
                $updateSql .= " ccity=?,";
                $updateParams[] = $city;
            }
            if (!empty($state)) {
                $updateSql .= " cstate=?,";
                $updateParams[] = $state;
            }
            if (!empty($pin_code)) {
                $updateSql .= " cpin_code=?,";
                $updateParams[] = $pin_code;
            }

            // Remove the trailing comma
            $updateSql = rtrim($updateSql, ',');

            $updateSql .= " WHERE client_id=?";
            $updateParams[] = $client_id;

            $updateStmt = mysqli_prepare($conn, $updateSql);

            // Dynamically bind parameters based on the provided fields
            $paramTypes = str_repeat('s', count($updateParams));
            mysqli_stmt_bind_param($updateStmt, $paramTypes, ...$updateParams);

            if (mysqli_stmt_execute($updateStmt)) {
                // Update successful
                header("Location: success.html");
                exit();
            } else {
                // Handle the error
                echo "Error updating client: " . mysqli_error($conn);
                error_log("Error updating client: " . mysqli_error($conn));
            }

            mysqli_stmt_close($updateStmt);
        } else {
            // Worker ID does not exist, insert a new record
            // ... (similar to your existing insert code)
        }
    } else {
        // worker_id not provided in the form data, handle accordingly
        echo "Client ID not provided!";
    }
} else {
    // Form not submitted using POST method, handle accordingly
    echo "Form not submitted!";
}

// Close the database connection
mysqli_close($conn);
?>
