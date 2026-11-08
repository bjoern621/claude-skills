---
date: 2026-11-08
verdict: bad
source: IEM Köln Reiseplan page, option cards
---

## Verdict
"das sind doch ähnliche optionen? mache alles nach schema x, nicht mal so mal so schirebne, immer pP angeben nicht nur 4/5 mal z.b. etc etc"

## Text
Each line stands for one line on a card:

Card A: "Zug, 3 Nächte" / "Mo 02:09 bis 06:50" / "ICE 920, direkt, 221,94 €" / "235,15 € p.P." / "gewählt"
Card B: "Zug, 4 Nächte" / "Mo 18:11 bis 22:15" / "ICE 1072, direkt, 155,94 €" / "263,48 € p.P." / "+28,33 €"
Card C: "Sprinter, 3 Nächte" / "Abfahrt nach dem Final" / "Hin und zurück, 195,50 €" / "213,75 € p.P." / "−21,40 €"
Card D: "Sprinter, 4 Nächte" / "Abfahrt am Montag" / "Hin und zurück, 195,50 €" / "253,08 € p.P." / "+17,94 €"

Elsewhere on the same page: "Beide kosten 101,94 € für alle 6." beside "Gesamtpreis pro Person", a row price "263,48" without a unit and "Unterkunft 1.323,00 €" beside "263,48 € pro Person".

## Patterns
- Sibling items in unequal shape: "Mo 02:09 bis 06:50" beside "Abfahrt nach dem Final" and "ICE 920, direkt, 221,94 €" beside "Hin und zurück, 195,50 €". Rule: none ("A name matches its siblings" holds for names). Cause: Uncovered (a fresh reader kept "Abfahrt nach dem Final" beside "Montag 02:09 bis 06:50" and "Rückfahrt direkt (ICE 920)" beside "Hin und zurück, selbst gefahren").
- Unit drift across one comparison: "221,94 €" for 6 beside "235,15 € p.P.", "+28,33 €" with no base and "pro Person" beside "p.P.". Rule: "Terms and names", one concept keeps one name and a term that reads several ways gets pinned down. Cause: Held for the written form and the missing unit. Uncovered for the base (one fresh reader moved every amount to per person, another kept "221,94 € für alle 6" beside "235,15 € pro Person").

## Rewrite
Card B: "Zug, 4 Nächte" / "Mo 18:11 bis 22:15" / "ICE 1072, direkt" / "Fahrt 42,98 € p.P." / "Unterkunft 220,50 € p.P." / "263,48 € p.P." / "+28,33 € p.P."
Card C: "Sprinter, 3 Nächte" / "So nach dem Final" / "Eigener Sprinter, direkt" / "Fahrt 32,58 € p.P." / "Unterkunft 181,17 € p.P." / "213,75 € p.P." / "−21,40 € p.P."
