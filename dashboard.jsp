<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Software Simulation - Dashboard</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #000000, #1a1a2e);
            color: #fff;
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            overflow-x: hidden;
        }

        .container {
            max-width: 600px;
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            animation: fadeIn 1s ease-out, floatAnimation 6s ease-in-out infinite;
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-align: center;
            color: #fff;
            animation: slideInDown 1s ease-out, glowAnimation 2s ease-in-out infinite alternate;
        }

        h2 {
            font-size: 2rem;
            margin-bottom: 30px;
            text-align: center;
            color: #4da6ff;
            animation: slideInUp 1s ease-out 0.5s both;
        }

        .button {
            display: inline-block;
            padding: 15px 30px;
            font-size: 18px;
            text-decoration: none;
            background-color: rgba(255, 255, 255, 0.1);
            color: #fff;
            border-radius: 50px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            margin: 10px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .button:before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: all 0.6s ease;
        }

        .button:hover:before {
            width: 300px;
            height: 300px;
        }

        .button:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .logout-button {
            background-color: rgba(255, 51, 51, 0.1);
            border-color: rgba(255, 51, 51, 0.3);
        }

        .logout-button:hover {
            background-color: rgba(255, 51, 51, 0.2);
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideInDown {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes slideInUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes floatAnimation {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        @keyframes glowAnimation {
            from { text-shadow: 0 0 5px rgba(255, 255, 255, 0.5); }
            to { text-shadow: 0 0 20px rgba(255, 255, 255, 0.8), 0 0 30px rgba(255, 255, 255, 0.6); }
        }

        @media (max-width: 480px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 2rem;
            }

            h2 {
                font-size: 1.5rem;
            }

            .button {
                padding: 12px 24px;
                font-size: 16px;
                display: block;
                width: 100%;
                margin: 10px 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Email Software Simulation</h1>
        <h2>Dashboard</h2>
        <a href="composeEmail.jsp" class="button">Compose Email</a>
        <a href="sentBox.jsp" class="button">Sent Box</a>
        <a href="inbox.jsp" class="button">Inbox</a>
        <form action="login.jsp" method="post">
            <input type="submit" value="Logout" class="button logout-button">
        </form>
    </div>
</body>
</html>