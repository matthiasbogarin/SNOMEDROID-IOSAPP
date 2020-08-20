<?php

// Create connection
$db_con = mysqli_connect("buancisserver.manhattan.edu","csc_wu","wu") or die("Could not connect to the MySQL database.");

//run a select on database name using the connection.
mysqli_select_db($db_con, "csc_wu") or die ("Could not select Database by name.");


 
// This SQL statement selects by giving conceptid for all parent relationships.
$cid = $_GET['id'];
$query = "Select term from snap_syn WHERE conceptId=$cid";
 
// Check if there are results
if ($result = mysqli_query($db_con, $query))
{
    //fetch data and place each row into an array/
    while($row = mysqli_fetch_array($result))
    {
        $row_set[] = $row;
    }
}
else
{
    echo "Could not get results from query.";
}

//encode the results to json and print it to the webpage
echo trim(json_encode($row_set));

//close connection
mysqli_close($db_con);
?>
