import Text "mo:base/Text";

module {
    public func html() : Text {
        let htmlTemplate = "<!DOCTYPE html>
<html lang=\"en\">
<head>
  <meta charset=\"UTF-8\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
  <title>Satoshi's Cyber Boots</title>
  <style>
    :root {
      --color1: rgb(0, 231, 255);
      --color2: rgb(16, 56, 217);
      --charizard1: rgb(255, 213, 170);
      --charizard2: #d2ddaa;
      --charizardfront: url(unnamed.webp);
    }

    body, html {
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      background-color: white;
      overflow-x: hidden;
    }

    .container {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-top: 20px;
      flex: 1 0 auto;
    }

    .card {
      width: 85vw;
      height: 119vw;
      @media screen and (min-width: 600px) {
        width: clamp(15vw, 85vh, 22vw);
        height: clamp(21vw, 119vh, 30.8vw);
      }
      position: relative;
      overflow: hidden;
      margin: 20px;
      z-index: 10;
      touch-action: none;
      border-radius: 5% / 3.5%;
      box-shadow: -5px -5px 5px -5px var(--color1),
                  5px 5px 5px -5px var(--color2),
                  -7px -7px 10px -5px transparent,
                  7px 7px 10px -5px transparent,
                  0 0 5px 0px rgba(255, 255, 255, 0),
                  0 55px 35px -20px rgba(0, 0, 0, 0.5);
      transition: transform 0.5s ease, box-shadow 0.2s ease;
      will-change: transform, filter;
      background-color: #040712;
      background-image: var(--front);
      background-size: cover;
      background-repeat: no-repeat;
      background-position: 50% 50%;
      transform-origin: center;
    }

    .card:hover {
      box-shadow: -20px -20px 30px -25px var(--color1),
                  20px 20px 30px -25px var(--color2),
                  -7px -7px 10px -5px var(--color1),
                  7px 7px 10px -5px var(--color2),
                  0 0 13px 4px rgba(255, 255, 255, 0.3),
                  0 55px 35px -20px rgba(0, 0, 0, 0.5);
    }

    .card.charizard {
      --color1: var(--charizard1);
      --color2: var(--charizard2);
      --front: var(--charizardfront);
    }

    .card:before,
    .card:after {
      content: \"\";
      position: absolute;
      left: 0;
      right: 0;
      bottom: 0;
      top: 0;
      background-repeat: no-repeat;
      opacity: .5;
      mix-blend-mode: color-dodge;
      transition: all .33s ease;
    }

    .card:before {
      background-position: 50% 50%;
      background-size: 300% 300%;
      background-image: linear-gradient(
        115deg,
        transparent 0%,
        var(--color1) 25%,
        transparent 47%,
        transparent 53%,
        var(--color2) 75%,
        transparent 100%
      );
      opacity: .5;
      filter: brightness(.5) contrast(1);
      z-index: 1;
    }

    .card:after {
      opacity: 1;
      background-image: url(\"https://assets.codepen.io/13471/sparkles.gif\"),
                        url(\"https://assets.codepen.io/13471/holo.png\"),
                        linear-gradient(125deg, #ff008450 15%, #fca40040 30%, #ffff0030 40%, #00ff8a20 60%, #00cfff40 70%, #cc4cfa50 85%);
      background-position: 50% 50%;
      background-size: 160%;
      background-blend-mode: overlay;
      z-index: 2;
      filter: brightness(1) contrast(1);
      transition: all .33s ease;
      mix-blend-mode: color-dodge;
      opacity: .75;
    }

    .card.active:after,
    .card:hover:after {
      filter: brightness(1) contrast(1);;
      opacity: 1;
    }

    .card.active,
    .card:hover {
      animation: none;
      transition: box-shadow 0.1s ease-out;
    }

    .card.active:before,
    .card:hover:before {
      animation: none;
      background-image: linear-gradient(
        110deg,
        transparent 25%,
        var(--color1) 48%,
        var (--color2) 52%,
        transparent 75%
      );
      background-position: 50% 50%;
      background-size: 250% 250%;
      opacity: .88;
      filter: brightness(.66) contrast(1.33);
      transition: none;
    }

    .card.active:before,
    .card:hover:before,
    .card.active:after,
    .card:hover:after {
      animation: none;
      transition: none;
    }

    .card.animated {
      transition: none;
      animation: holoCard 12s ease 0s 1;
      &:before {
        transition: none;
        animation: holoGradient 12s ease 0s 1;
      }
      &:after {
        transition: none;
        animation: holoSparkle 12s ease 0s 1;
      }
    }

    @keyframes holoSparkle {
      0%, 100% {
        opacity: .75; background-position: 50% 50%; filter: brightness(1.2) contrast(1.25);
      }
      5%, 8% {
        opacity: 1; background-position: 40% 40%; filter: brightness(.8) contrast(1.2);
      }
      13%, 16% {
        opacity: .5; background-position: 50% 50%; filter: brightness(1.2) contrast(.8);
      }
      35%, 38% {
        opacity: 1; background-position: 60% 60%; filter: brightness(1) contrast(1);
      }
      55% {
        opacity: .33; background-position: 45% 45%; filter: brightness(1.2) contrast(1.25);
      }
    }

    @keyframes holoGradient {
      0%, 100% {
        opacity: 0.5;
        background-position: 50% 50%;
        filter: brightness(.5) contrast(1);
      }
      5%, 9% {
        background-position: 100% 100%;
        opacity: 1;
        filter: brightness(.75) contrast(1.25);
      }
      13%, 17% {
        background-position: 0% 0%;
        opacity: .88;
      }
      35%, 39% {
        background-position: 100% 100%;
        opacity: 1;
        filter: brightness(.5) contrast(1);
      }
      55% {
        background-position: 0% 0%;
        opacity: 1;
        filter: brightness(.75) contrast(1.25);
      }
    }

    @keyframes holoCard {
      0%, 100% {
        transform: rotateZ(0deg) rotateX(0deg) rotateY(0deg);
      }
      5%, 8% {
        transform: rotateZ(0deg) rotateX(6deg) rotateY(-20deg);
      }
      13%, 16% {
        transform: rotateZ(0deg) rotateX(-9deg) rotateY(32deg);
      }
      35%, 38% {
        transform: rotateZ(3deg) rotateX(12deg) rotateY(20deg);
      }
      55% {
        transform: rotateZ(-3deg) rotateX(-12deg) rotateY(-27deg);
      }
    }

    .button {
      margin-top: 30px;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      background-color: #040712;
      color: white;
      font-size: 18px;
      cursor: pointer;
      box-shadow: -5px -5px 5px -5px var(--color1),
                  5px 5px 5px -5px var(--color2),
                  -7px -7px 10px -5px transparent,
                  7px 7px 10px -5px transparent,
                  0 0 5px 0px rgba(255, 255, 255, 0),
                  0 55px 35px -20px rgba(0, 0, 0, 0.5);
      transition: box-shadow 0.2s ease, transform 0.2s ease;
    }

    .button:hover {
      box-shadow: -10px -10px 15px -10px var(--color1),
                  10px 10px 15px -10px var(--color2),
                  -7px -7px 10px -5px var(--color1),
                  7px 7px 10px -5px var(--color2),
                  0 0 13px 4px rgba(255, 255, 255, 0.3),
                  0 55px 35px -20px rgba(0, 0, 0, 0.5);
      transform: scale(1.05);
    }

    footer {
      text-align: center;
      font-family: 'Courier New', monospace;
      padding-top: 80px ;
      flex-shrink: 0;
      color: black;
    }

    footer a {
      color: var(--color1);
      text-decoration: none;
    }

    footer a:hover {
      text-decoration: underline;
    }

.metadata-container {
  color: #e2e8f0;
  font-family: 'Courier New', monospace;
  padding: 1rem;
}

.title {
  font-size: 1.5rem;
  color: #2595c6; /* Darker shade of #38bdf8 */
  margin-bottom: 1.5rem;
  text-shadow: 0 0 10px rgba(37, 149, 198, 0.5); /* Darker text shadow */
}

.metadata-item {
  margin: 0.75rem 0;
  padding: 0.5rem;
  border-left: 3px solid #2595c6; /* Darker border color */
  background: rgba(10, 135, 190, 0.1); /* Darker background color */
}

.label {
  color: #748191; /* Darker shade of #94a3b8 */
  font-size: 0.875rem;
  margin-bottom: 0.25rem;
}

.value {
  color: #2595c6; /* Darker shade of #38bdf8 */
  font-size: 1rem;
}

.blockchain-badge {
  display: inline-block;
  background: rgba(10, 135, 190, 0.2); /* Darker background */
  padding: 0.5rem 1rem;
  border-radius: 20px;
  border: 1px solid #2595c6; /* Darker border */
  color: #2595c6; /* Darker text color */
  font-size: 0.875rem;
  animation: pulse 2s infinite;
}

.timestamp {
  margin-top: 1.5rem;
  font-size: 0.875rem;
  color: #4a5568; /* Darker shade of #64748b */
}


@keyframes pulse {
  0% {
    box-shadow: 0 0 0 0 rgba(56, 189, 248, 0.4);
  }
  70% {
    box-shadow: 0 0 0 10px rgba(56, 189, 248, 0);
  }
  100% {
    box-shadow: 0 0 0 0 rgba(56, 189, 248, 0);
  }
}

.history-section {
  color: #e2e8f0;
  font-family: 'Courier New', monospace;
  padding: 1rem;
  margin-top: 2rem;
  border-top: 1px solid #2595c6;
}

.history-title {
  font-size: 1.5rem;
  color: #2595c6;
  margin-bottom: 1.5rem;
  text-shadow: 0 0 10px rgba(37, 149, 198, 0.5);
}

.history-item {
  margin: 1rem 0;
  padding: 1rem;
  border-left: 3px solid #2595c6;
  background: rgba(10, 135, 190, 0.1);
}

.history-date {
  color: var(--color1);
  font-size: 0.875rem;
  margin-bottom: 0.5rem;
  font-weight: bold;
}

.history-description {
  color: #748191;
  font-size: 0.875rem;
  margin-bottom: 1rem;
}

.history-image {
  max-width: 200px;
  height: auto;
  border-radius: 8px;
  cursor: pointer;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  border: 2px solid #2595c6;
}

.history-image:hover {
  transform: scale(1.05);
  box-shadow: 0 0 20px rgba(37, 149, 198, 0.6);
}

  </style>
</head>
<body>
  <div class=\"container\">
    <div class=\"card charizard animated\">
    </div>
   
      <div class=\"metadata-container\">
        <h1 class=\"title\">Satoshi's Cyber Boots</h1>

        <div class=\"metadata-item\">
          <div class=\"label\">BLOCKCHAIN</div>
          <div class=\"blockchain-badge\">ICP</div>
        </div>
        
        <div class=\"metadata-item\">
          <div class=\"label\">DESCRIPTION</div>
          <div class=\"value\">Delivering On Grand Experiments (D.O.G.E.)</div>
        </div>
        
        <div class=\"metadata-item\">
          <div class=\"label\">OWNER</div>
          <div class=\"value\">Just a regular cyber mother fucker brining money back to people.</div>
        </div>
        
        <div class=\"timestamp\">
          Timestamp: November 15th, 2024 23:37:06
        </div>
      </div>

      <div class=\"history-section\">
  <h2 class=\"history-title\">History</h2>
  <div class=\"history-item\">
    <div class=\"history-date\">May 17th, 2025 - Crap Sogn Gion, GALAAXY, 7032 Laax</div>
    <div class=\"history-description\">Vitalik captured with Satoshi's Cyber Boots</div>
    <a href=\"https://satj4-jqaaa-aaaak-qtqlq-cai.raw.icp0.io/vitalik.webp\" target=\"_blank\">
      <img src=\"vitalik.webp\" alt=\"Vitalik with Satoshi's Cyber Boots\" class=\"history-image\">
    </a>
  </div>
</div>
    <footer>
      <p>A <a href=\"https://elie.diy\" target=\"_blank\">elie.diy</a> project</p>
    </footer>
  </div>
  <style class=\"hover\"></style>
  <script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js\"></script>
  <script>
    var x;
    var \$cards = \$(\".card\");
    var \$style = \$(\".hover\");

    \$cards.on(\"mousemove touchmove\", function(e) {
      // normalise touch/mouse
      var pos = [e.offsetX, e.offsetY];
      e.preventDefault();
      if (e.type === \"touchmove\") {
        pos = [e.touches[0].clientX, e.touches[0].clientY];
      }
      var \$card = \$(this);
      // math for mouse position
      var l = pos[0];
      var t = pos[1];
      var h = \$card.height();
      var w = \$card.width();
      var px = Math.abs(Math.floor(100 / w * l) - 100);
      var py = Math.abs(Math.floor(100 / h * t) - 100);
      var pa = (50 - px) + (50 - py);
      // math for gradient / background positions
      var lp = (50 + (px - 50) / 1.5);
      var tp = (50 + (py - 50) / 1.5);
      var px_spark = (50 + (px - 50) / 7);
      var py_spark = (50 + (py - 50) / 7);
      var p_opc = 20 + (Math.abs(pa) * 1.5);
      var ty = ((tp - 50) / 2) * -1;
      var tx = ((lp - 50) / 1.5) * .5;
      // css to apply for active card
      var grad_pos = `background-position: \${lp}% \${tp}%;`;
      var sprk_pos = `background-position: \${px_spark}% \${py_spark}%;`;
      var opc = `opacity: \${p_opc / 100};`;
      var tf = `transform: rotateX(\${ty}deg) rotateY(\${tx}deg);`;
      // need to use a <style> tag for psuedo elements
      var style = `.card:hover:before { \${grad_pos} }  /* gradient */ .card:hover:after { \${sprk_pos} \${opc} }   /* sparkles */`;
      // set / apply css class and style
      \$cards.removeClass(\"active\");
      \$card.removeClass(\"animated\");
      \$card.attr(\"style\", tf);
      \$style.html(style);
      if (e.type === \"touchmove\") {
        return false;
      }
      clearTimeout(x);
    }).on(\"mouseout touchend touchcancel\", function() {
      // remove css, apply custom animation on end
      var \$card = \$(this);
      \$style.html(\"\");
      \$card.removeAttr(\"style\");
      x = setTimeout(function() {
        \$card.addClass(\"animated\");
      }, 2500);
    });
  </script>
</body>
</html>";

        htmlTemplate
    }
};