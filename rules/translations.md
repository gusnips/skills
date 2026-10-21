# Translations — native voice only

Never ship a literal translation. The source language is a meaning spec, not
text to mirror: read what it means and promises, close the source, then write
what a native company would put in that exact spot. Then verify the meaning
survived — structure may change 100%, meaning 0%.

- The bar is "a native company wrote this", not "it's understandable".
  Understandable-but-translated is a bug. Test: read it aloud — native voice
  or dub? A dub is a reject.
- Hunt the recurring traps: calqued word order, false friends (pt "brevemente"
  = "soon", not "briefly"), gerund/participle calques, textbook terms no dev
  uses. Keep the anglicisms devs actually say (per language: pt keeps
  webhook/payload/template/QR code/checkout; es translates
  plantilla/código QR/carga útil).
- pt-BR talks to the reader in the standard imperative: "responda", "aponte",
  "fale", "comece", "deixe", "cancele". Never the spoken form ("responde",
  "aponta", "fala", "começa", "deixa", "cancela"): written down, it reads as
  the third person, so next to a line about the product or the AI ("Ela
  atende") it names the wrong actor. The rest of a casual voice (pra, tá, a
  gente) can stay. A verb in a title needs a clear actor: "Comece em 10
  minutos", not "Começa em 10 minutos" (what starts?).
- One term per concept per language, consistent across every surface. Fence
  words that collide with the product's own states (e.g. WhatsApp "ban" must
  never be translated with the word for the product's account "suspension").
- Invariants are byte-level: placeholders, ICU plural pairs, markup, brand
  tokens. Every locale lands in the same commit; run the project's i18n gate
  before committing.
- When reviewing existing translations, verify with fresh native eyes that
  REJECT translated-sounding text — a gate that only rejects wrong meaning
  leaves the whole surface reading like a translation, because it is one.
