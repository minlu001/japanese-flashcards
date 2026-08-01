const express = require('express');
const cors = require('cors');
const Kuroshiro = require('kuroshiro').default || require('kuroshiro');
const KuromojiAnalyzer = require('kuroshiro-analyzer-kuromoji');

const app = express();
app.use(cors());
app.use(express.json());

const kuroshiro = new Kuroshiro();
let isKuroshiroReady = false;

// Initialize Kuroshiro dictionary analyzer on startup
async function initKuroshiro() {
  await kuroshiro.init(new KuromojiAnalyzer());
  isKuroshiroReady = true;
  console.log("Kuroshiro Furigana Analyzer initialized.");
}
initKuroshiro().catch(console.error);

// Helper function to generate HTML <ruby> tags
async function generateFuriganaHtml(text) {
  if (!isKuroshiroReady || !text) return text;
  return await kuroshiro.convert(text, {
    mode: "furigana",
    to: "hiragana"
  });
}

// Example API Endpoint to add a flashcard
app.post('/api/cards', async (req, res) => {
  const { kanji_text, english_translation } = req.body;
  
  // Convert "漢字を勉強します" -> "<ruby>漢字<rt>かんじ</rt></ruby>を<ruby>勉強<rt>べんきょう</rt></ruby>します"
  const furigana_html = await generateFuriganaHtml(kanji_text);

  // TODO: Insert into SQLite database (card_id, raw_kanji, furigana_html, english_translation)
  
  res.json({
    raw_kanji: kanji_text,
    furigana_html: furigana_html,
    english_translation: english_translation
  });
});

app.listen(3000, () => console.log('Backend server running on port 3000'));
