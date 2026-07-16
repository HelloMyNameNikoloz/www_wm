# Cup Quiz

- Gruppenansicht mit der Bilanz der abgeschlossenen Gruppenspiele
- Listenansicht mit FIFA-Platzierung und FIFA-Punkten vom 11. Juni 2026
- Sortierung der Listenansicht nach A–Z, Z–A oder FIFA-Ranking
- Quiz mit den Kategorien Flaggen, Länder und Spieler
- Zehn zufällige Fragen pro Runde und alle 48 WM-Flaggen

## Struktur

- `src/App`: Anwendungszustand, Updates und Seiten-Routing
- `src/Components`: gemeinsam genutzte UI-Komponenten
- `src/Pages`: Ansichten und Unterkomponenten pro Seite
- `src/Data`: Datentypen, JSON-Decoder und Selektoren
- `public/data`: Teams, Spiele, Quizfragen und Länder-/Flaggen-Zuordnung als JSON

## GitHub Pages

Der Workflow `.github/workflows/pages.yml` baut und veröffentlicht den Inhalt von `public`. In den Repository-Einstellungen muss unter **Pages → Build and deployment** einmalig **GitHub Actions** als Quelle gewählt werden.
