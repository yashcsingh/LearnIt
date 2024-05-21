<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Instructor Availability</title>
<meta charset="UTF-8">
    <title>Instructor Availability</title>
    <!-- Include jQuery library -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Include jQuery UI library -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- Include date range picker library -->
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
    <!-- Include timepicker.js library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
    

<title>Appointment Booking</title>
</head>
<body>
	<h1>Instructor Availability Form</h1>
    <form action="#" method="POST">
        
        <label for="available_dates">Available Dates:</label>
        <input type="text" id="available_dates" name="available_dates" required><br><br>

        <label for="available_time_start">Available Time (Start):</label>
        <input type="text" id="available_time_start" name="available_time_start" required><br><br>

        <label for="available_time_end">Available Time (End):</label>
        <input type="text" id="available_time_end" name="available_time_end" required><br><br>

        <input type="submit" value="Submit">
    </form>
    
    <script>
        $(document).ready(function() {
            // Initialize date range picker
            $('#available_dates').daterangepicker({
                opens: 'left',
                autoUpdateInput: false,
                minDate: moment().add(1, 'days'), // Set the minimum date to the next day
            });
            
         	// Update the input field when a date is selected
            $('#available_dates').on('apply.daterangepicker', function(ev, picker) {
                $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
            });

         	// Initialize timepicker for start time without AM/PM
            $('#available_time_start').timepicker({
                controlType: 'select',
                timeFormat: 'HH:mm', // Use 'HH:mm' for 24-hour format
                step: 15,
                showDuration: true,
                minTime: '11:00',   // Minimum time (11:00 AM)
                maxTime: '18:00'    // Maximum time (6:00 PM)
                
            });

            // Initialize timepicker for end time without AM/PM
            $('#available_time_end').timepicker({
                controlType: 'select',
                timeFormat: 'HH:mm', // Use 'HH:mm' for 24-hour format
                step: 15,
                showDuration: true,
                minTime: '11:00',   // Minimum time (11:00 AM)
                maxTime: '18:00'    // Maximum time (6:00 PM)
            });
        });
    </script>
</body>
</html>