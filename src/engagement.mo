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
            case null { "Engagement Contract" };
        };
        
        let projectDesc = switch(info.description) {
            case (?desc) { desc };
            case null { "A decentralized commitment registry" };
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
            participantsList := "<div class=\"empty-state\">Be the first to engage!</div>";
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
    </style>
</head>
<body>
    <div class=\"container\">
        <h1>" # projectTitle # "</h1>
        <p class=\"description\">" # projectDesc # "</p>
        
        <div class=\"stats\">
            <div class=\"stats-number\">" # Nat.toText(participants.size()) # "</div>
            <div class=\"stats-label\">People Engaged</div>
        </div>
        
        <div class=\"participants-section\">
            <h2 class=\"section-title\">Participants</h2>
            <div class=\"participants-grid\">
                " # participantsList # "
            </div>
        </div>
        
        <div class=\"engage-form\">
            <h3 class=\"form-title\">Join the Movement</h3>
            <div class=\"input-group\">
                <input type=\"text\" class=\"name-input\" placeholder=\"Enter your name\" id=\"nameInput\">
                <button class=\"engage-button\" id=\"engageBtn\">
                    Engage
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
                    showMessage(data.message || 'Successfully engaged! Welcome to the movement!', 'success');
                    nameInput.value = '';
                    
                    // Refresh the page after a delay to show updated participant count
                    setTimeout(() => {
                        window.location.reload();
                    }, 2000);
                } else {
                    showMessage(data.message || 'Failed to engage. Please try again.', 'error');
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
</body>
</html>"
    };
};