import Text "mo:base/Text";
import Array "mo:base/Array";
import Nat "mo:base/Nat";

module {
    // Super simple - just store names
    public type ContractState = {
        var projectName: ?Text;
        var projectDescription: ?Text;
        var participants: [Text]; // Just names, no principals
    };
    
    // Initialize empty state
    public func init() : ContractState = {
        var projectName = null;
        var projectDescription = null;
        var participants = [];
    };
    
    // Contract management class
    public class EngagementContract(state: ContractState) {
        
        // Set project info
        public func setProjectInfo(name: Text, description: Text) {
            state.projectName := ?name;
            state.projectDescription := ?description;
        };
        
        // Add participant - just add the name
        public func engage(name: Text) : Bool {
            // Check if name already exists (optional - remove if you want duplicates)
            let exists = Array.find<Text>(state.participants, func(n) = n == name);
            switch(exists) {
                case (?_) { false }; // Name already exists
                case null {
                    state.participants := Array.append(state.participants, [name]);
                    true
                };
            };
        };
        
        // Get all participants
        public func getParticipants() : [Text] {
            state.participants
        };
        
        // Get participant count
        public func getCount() : Nat {
            state.participants.size()
        };
        
        // Get project info
        public func getProjectInfo() : {name: ?Text; description: ?Text} {
            {
                name = state.projectName;
                description = state.projectDescription;
            }
        };
        
        // Get state for upgrades
        public func getState() : ContractState {
            state
        };
    };
    
    // Helper function to extract name from URL
    public func extractName(url : Text) : ?Text {
        switch (Text.split(url, #text("?name=")).next()) {
            case null { 
                // Also try &name= format
                switch (Text.split(url, #text("&name=")).next()) {
                    case null { null };
                    case (?_) {
                        let parts = Text.split(url, #text("&name="));
                        switch (parts.next()) {
                            case null { null };
                            case (?_) {
                                switch (parts.next()) {
                                    case null { null };
                                    case (?nameValue) {
                                        let cleanName = switch (Text.split(nameValue, #text("&")).next()) {
                                            case null { 
                                                switch (Text.split(nameValue, #text("#")).next()) {
                                                    case null { nameValue };
                                                    case (?clean) { clean };
                                                };
                                            };
                                            case (?clean) { clean };
                                        };
                                        ?cleanName;
                                    };
                                };
                            };
                        };
                    };
                };
            };
            case (?_) {
                let parts = Text.split(url, #text("?name="));
                switch (parts.next()) {
                    case null { null };
                    case (?_) {
                        switch (parts.next()) {
                            case null { null };
                            case (?nameValue) {
                                let cleanName = switch (Text.split(nameValue, #text("&")).next()) {
                                    case null {
                                        switch (Text.split(nameValue, #text("#")).next()) {
                                            case null { nameValue };
                                            case (?clean) { clean };
                                        };
                                    };
                                    case (?clean) { clean };
                                };
                                ?cleanName;
                            };
                        };
                    };
                };
            };
        };
    };
    
    // Generate HTML page with working engagement
    public func html(contract: EngagementContract) : Text {
        let info = contract.getProjectInfo();
        let participants = contract.getParticipants();
        
        let projectTitle = switch(info.name) {
            case (?name) { name };
            case null { "smart contract d'engagement symbolique" };
        };
        
        let projectDesc = switch(info.description) {
            case (?desc) { desc };
            case null { "description" };
        };
        
        // Build participants list
        var participantsList = "";
        for (name in participants.vals()) {
            participantsList := participantsList # 
                "<div class=\"participant\">" #
                "<span class=\"participant-name\">" # name # "</span>" #
                "</div>";
        };
        
        if (participantsList == "") {
            participantsList := "<div class=\"empty-state\">Qui sera le premier à s'engager?</div>";
        };

        "<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>" # projectTitle # "</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
      --color1: rgb(0, 231, 255);
      --color2: rgb(16, 56, 217);
      --charizard1: rgb(255, 213, 170);
      --charizard2: #d2ddaa;
      --charizardfront: url(evoli.webp);
    }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            max-width: 600px;
            width: 100%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);

        }

        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2.5rem;
            text-align: center;
        }

        .description {
            color: #666;
            text-align: center;
            margin-bottom: 40px;
            font-size: 1.1rem;
        }

        .stats {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
        }

        .stats-number {
            font-size: 3rem;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stats-label {
            font-size: 1rem;
            opacity: 0.9;
        }

        .participants-section {
            margin-top: 30px;
        }

        .section-title {
            color: #333;
            font-size: 1.3rem;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }

        .participants-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 10px;
        }

        .participant {
            padding: 12px;
            background: #f8f9fa;
            border-radius: 10px;
            transition: all 0.3s ease;
            text-align: center;
        }

        .participant:hover {
            background: #e9ecef;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .participant-name {
            font-weight: 600;
            color: #333;
            font-size: 1rem;
        }

        .empty-state {
            text-align: center;
            color: #999;
            padding: 40px;
            font-style: italic;
        }

        .engage-form {
            margin-top: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 15px;
        }

        .form-title {
            color: #333;
            font-size: 1.2rem;
            margin-bottom: 15px;
            text-align: center;
        }

        .input-group {
            display: flex;
            gap: 10px;
        }

        .name-input {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .name-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .engage-button {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .engage-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .engage-button:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }

        .message {
            margin-top: 15px;
            padding: 10px 15px;
            border-radius: 8px;
            text-align: center;
            font-weight: 600;
        }

        .message.success {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .message.error {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        @media (max-width: 600px) {
            .container {
                padding: 30px 20px;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            .stats-number {
                font-size: 2.5rem;
            }
            
            .participants-grid {
                grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            }
        }

        .card {
       width: 85vw;  /* Reduced from 85vw */
  height: 119vw;  /* Reduced from 119vw */
  max-width: 250px; 
  max-height: 350px;  
      @media screen and (min-width: 600px) {
        width: clamp(15vw, 85vh, 22vw);
        height: clamp(21vw, 119vh, 30.8vw);
      }
      position: relative;
      overflow: hidden;
      margin: 20px auto;
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

    </style>
</head>
<body>
    <div class=\"container\">

      <div style=\"display: flex; justify-content: center; margin-bottom: 30px;\">
         <div class=\"card charizard animated\"></div>
     </div>
        <h1>" # projectTitle # "</h1>
        <p class=\"description\">" # projectDesc # "</p>
        
        <div class=\"stats\">
            <div class=\"stats-number\">" # Nat.toText(participants.size()) # "</div>
            <div class=\"stats-label\">Personnes qui se sont engagées:</div>
        </div>
        
        <div class=\"participants-section\">
            <h2 class=\"section-title\">Participant.e.s</h2>
            <div class=\"participants-grid\">
                " # participantsList # "
            </div>
        </div>
        
        <div class=\"engage-form\">
            <h3 class=\"form-title\">Rejoins le projet</h3>
            <div class=\"input-group\">
                <input type=\"text\" class=\"name-input\" placeholder=\"Ton prénom\" id=\"nameInput\">
                <button class=\"engage-button\" id=\"engageBtn\">
                    Je m'engage
                </button>
            </div>
            <div id=\"message\" class=\"message\" style=\"display: none;\"></div>
        </div>
    </div>

    <script>
        const nameInput = document.getElementById('nameInput');
        const engageBtn = document.getElementById('engageBtn');
        const messageDiv = document.getElementById('message');
        let isSubmitting = false;

        function showMessage(text, type) {
            messageDiv.textContent = text;
            messageDiv.className = `message ${type}`;
            messageDiv.style.display = 'block';
        }

        function hideMessage() {
            messageDiv.style.display = 'none';
        }

        function setLoading(loading) {
            isSubmitting = loading;
            engageBtn.disabled = loading;
            engageBtn.textContent = loading ? 'Engaging...' : 'Engage';
        }

        async function submitEngagement() {
            if (isSubmitting) return;

            const name = nameInput.value.trim();
            
            if (!name) {
                showMessage('Please enter your name', 'error');
                return;
            }

            if (name.length < 2) {
                showMessage('Name must be at least 2 characters long', 'error');
                return;
            }

            setLoading(true);
            hideMessage();

            try {
                const response = await fetch(`/engagement/engage?name=${encodeURIComponent(name)}`, {
                    method: 'POST'
                });

                const responseText = await response.text();
                let data;
                
                try {
                    data = JSON.parse(responseText);
                } catch (jsonError) {
                    console.error('JSON parse error:', jsonError);
                    showMessage('Server returned invalid response', 'error');
                    return;
                }

                if (!response.ok) {
                    showMessage(data.message || `HTTP error! status: ${response.status}`, 'error');
                    return;
                }

                if (data.success) {
                    showMessage(data.message || 'Bienvenue sur le projet!', 'success');
                    nameInput.value = '';
                    
                    // Refresh the page after a delay to show updated participant count
                    setTimeout(() => {
                        window.location.reload();
                    }, 2000);
                } else {
                    showMessage(data.message || 'ça na pas marché. Essaie encore.', 'error');
                }

            } catch (error) {
                console.error('Engagement error:', error);
                
                if (error.name === 'TypeError' && error.message.includes('fetch')) {
                    showMessage('Cannot connect to server. Please try again later.', 'error');
                } else {
                    showMessage(`Error: ${error.message}`, 'error');
                }
            } finally {
                setLoading(false);
            }
        }

        // Event listeners
        engageBtn.addEventListener('click', submitEngagement);

        nameInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                submitEngagement();
            }
        });

        nameInput.addEventListener('input', () => {
            hideMessage();
        });
    </script>

    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js\"></script>
  <script>
    var x;
    var \\$cards = \\$(\".card\");
    var \\$style = \\$(\".hover\");

    \\$cards.on(\"mousemove touchmove\", function(e) {
      // normalise touch/mouse
      var pos = [e.offsetX, e.offsetY];
      e.preventDefault();
      if (e.type === \"touchmove\") {
        pos = [e.touches[0].clientX, e.touches[0].clientY];
      }
      var \\$card = \\$(this);
      // math for mouse position
      var l = pos[0];
      var t = pos[1];
      var h = \\$card.height();
      var w = \\$card.width();
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
      var grad_pos = \\`background-position: \\${lp}% \\${tp}%;\\`;
      var sprk_pos = \\`background-position: \\${px_spark}% \\${py_spark}%;\\`;
      var opc = \\`opacity: \\${p_opc / 100};\\`;
      var tf = \\`transform: rotateX(\\${ty}deg) rotateY(\\${tx}deg);\\`;
      // need to use a <style> tag for psuedo elements
      var style = \\`.card:hover:before { \\${grad_pos} }  /* gradient */ .card:hover:after { \\${sprk_pos} \\${opc} }   /* sparkles */\\`;
      // set / apply css class and style
      \\$cards.removeClass(\"active\");
      \\$card.removeClass(\"animated\");
      \\$card.attr(\"style\", tf);
      \\$style.html(style);
      if (e.type === \"touchmove\") {
        return false;
      }
      clearTimeout(x);
    }).on(\"mouseout touchend touchcancel\", function() {
      // remove css, apply custom animation on end
      var \\$card = \\$(this);
      \\$style.html(\"\");
      \\$card.removeAttr(\"style\");
      x = setTimeout(function() {
        \\$card.addClass(\"animated\");
      }, 2500);
    });
  </script>
</body>
</html>"
    };
};