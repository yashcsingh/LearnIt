<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - LearnIt</title>
</head>
<body style="display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0;">
    <div style="text-align: center; padding: 25px; border: 1px solid #ccc; border-radius: 5px; box-shadow: 0 0 5px #aaa;">
        <h1>Admin Login</h1>
        <form action="AdminLogin" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required style="width: 80%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px;">
            <br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required style="width: 80%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px;">
            <br>
            <button type="submit" style="background-color: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">Login</button>
        </form>
    </div>
</body>
</html>
