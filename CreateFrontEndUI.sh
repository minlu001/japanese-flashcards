#!/bin/bash

cat << 'EOF' > /root/jp-flashcards/frontend/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staging JP Flashcards</title>
    <style>
        body { font-family: sans-serif; background: #f5f7fa; padding: 20px; display: flex; flex-direction: column; align-items: center;}
        .container { max-width: 500px; width: 100%; background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        textarea { width: 100%; height: 80px; padding: 10px; border-radius: 6px; box-sizing: border-box; resize: none; font-size: 16px; }
        button { width: 100%; padding: 12px; margin-top: 10px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; }
        .btn-speak { background: #3498db; color: white; }
        .btn-save { background: #2ecc71; color: white; }
        .card { background: #ecf0f1; padding: 12px; margin-top: 10px; border-radius: 6px; display: flex; justify-content: space-between; align-items: center; }
        .action-btns button { width: auto; margin: 0 2px; padding: 5px 10px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Rocky 9 JP Flashcards</h1>
    <textarea id="text-input" placeholder="Paste Japanese text..."></textarea>
    <button class="btn-speak" onclick="speakText()">🔊 Pronounce</button>
    <button class="btn-save" onclick="saveFlashcard()">⭐ Save to Local Cloud</button>
    <h2>Flashcards</h2>
    <div id="flashcard-container">Loading...</div>
</div>

<script>
    // ⚠️ Swap this with your actual Rocky 9 local IP address!
    const API_URL = "http://YOUR_ROCKY9_IP:3000/api/cards";

    async function fetchFlashcards() {
        try {
            const res = await fetch(API_URL);
            const data = await res.json();
            const container = document.getElementById('flashcard-container');
            container.innerHTML = '';
            data.forEach(card => {
                const el = document.createElement('div');
                el.className = 'card';
                el.innerHTML = `<span>${card.text}</span><div>
                    <button style="background:#9b59b6;color:white" onclick="speakText('${card.text}')">🔊</button>
                    <button style="background:#e74c3c;color:white" onclick="deleteCard(${card.id})">🗑️</button>
                </div>`;
                container.appendChild(el);
            });
        } catch (e) {
            document.getElementById('flashcard-container').innerText = "Error connecting to API.";
        }
    }

    async function saveFlashcard() {
        const text = document.getElementById('text-input').value.trim();
        if(!text) return;
        await fetch(API_URL, {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ text })
        });
        document.getElementById('text-input').value = '';
        fetchFlashcards();
    }

    async function deleteCard(id) {
        await fetch(`${API_URL}/${id}`, { method: 'DELETE' });
        fetchFlashcards();
    }

    function speakText(textToSpeak) {
        const text = textToSpeak || document.getElementById('text-input').value;
        if (!text.trim()) return;
        const utterance = new SpeechSynthesisUtterance(text);
        utterance.lang = 'ja-JP';
        utterance.rate = 0.9;
        window.speechSynthesis.cancel();
        window.speechSynthesis.speak(utterance);
    }

    fetchFlashcards();
</script>
</body>
</html>
EOF
