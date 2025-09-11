import Text "mo:base/Text";

module {
    public func html() : Text {
        let htmlTemplate = "<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Kimono de Thibault</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #ffffff;
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .auth-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
        }

        .auth-content {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .auth-logo {
            width: 50px;
            height: 50px;
            border-radius: 8px;
        }

        .auth-text {
            text-align: left;
        }

        .auth-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .auth-subtitle {
            font-size: 14px;
            opacity: 0.9;
        }

        .verified-badge {
            background: #27ae60;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .check-icon {
            width: 16px;
            height: 16px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #27ae60;
            font-weight: bold;
            font-size: 12px;
        }

        h1 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 3.5em;
            font-weight: 300;
            letter-spacing: 3px;
            text-align: center;
        }

        .collection-title {
            text-align: center;
            color: #7f8c8d;
            font-size: 18px;
            margin-bottom: 40px;
            font-style: italic;
        }

        .main-content {
            background: #fafafa;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            text-align: center;
        }

        .kimono-image {
            max-width: 100%;
            width: 600px;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 12px 40px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
        }

        .kimono-image:hover {
            transform: translateY(-5px);
            box-shadow: 0 16px 50px rgba(0,0,0,0.2);
        }

        .description {
            font-size: 20px;
            line-height: 1.8;
            color: #555;
            margin: 20px 0;
            font-weight: 300;
        }

        .signature {
            color: #7f8c8d;
            font-size: 16px;
            margin-top: 20px;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .auth-banner {
                flex-direction: column;
                text-align: center;
            }

            .auth-content {
                flex-direction: column;
                text-align: center;
            }

            h1 {
                font-size: 2.5em;
                letter-spacing: 1px;
            }

            .main-content {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class=\"container\">
        <!-- Authentication Banner -->
        <div class=\"auth-banner\">
            <div class=\"auth-content\">
                <img src=\"/logo.webp\" alt=\"Logo\" class=\"auth-logo\"/>
                <div class=\"auth-text\">
                    <div class=\"auth-title\">Collection d'Alleret 2025 de l'association le petit prince</div>
                    <div class=\"auth-subtitle\">Kimono authentifié et certifié</div>
                </div>
            </div>
            <div class=\"verified-badge\">
                <span class=\"check-icon\">✓</span>
                Scan valide
            </div>
        </div>


        <div class=\"main-content\">
            <img src=\"/Thibault.webp\" alt=\"Kimono image\" class=\"kimono-image\"/>
            <p class=\"description\">Kimono customisé par Thibault</p>
            <p class=\"signature\">— Pièce unique de la collection 2025 —</p>
        </div>
    </div>
</body>
</html>";

        htmlTemplate
    }
};
