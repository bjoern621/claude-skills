---
date: 2026-11-21
verdict: good
source: an informal Markdown message to a group of friends, a ski trip cost list outside any repository. writing-style covers it in part at most.
---

## Verdict
"ab jetzt immer lesen ob ich in der datei sachen geändert habe. und dann deinen stil anpassen."
Earlier, on the same list: "etnferne alles wir und ich komplett einfach, neutral als infos"
On the usage hint: "nicht explizit schreiben, das können die Leute sich denken"
On scope: "beachte dass hier der writing style nicht greift bzw nur teilweise. das hier ist eine informale nachricht an eine freundesgruppe"

## Text
The agent's lines and the user's edit of each.
The pronoun sentences survive as quoted in the session, trimmed where marked.

Under "## Allgemeine Informationen", deleted:
"Preisliste für Alpe d'Huez, zum Vergleich mit Zillertal und Silvretta Montafon unter denselben Annahmen.
Alle Preise stammen vom 21.11.2026 und gelten für eine Buchung an diesem Tag."

"- Benzin: 8 Liter auf 100 km, Super E5 etwa 2,00 € pro Liter (geschätzt, Super E10 kostet laut ADAC 1,938 €)"
became "- Benzin: 8 Liter auf 100 km, 2,00 € pro Liter"

"- 8 Personen gehen in die Skischule" became "- 8 Personen Skischule"

Under "- Verleih für alle 11 eingerechnet: Ski oder Snowboard mit Schuhen, Helm", next to per-item rental prices in each location's section, deleted:
"- Eigene Ausrüstung: Einzelpreis beim jeweiligen Ort abziehen"

"Ihr wohnt in 3 getrennten Apartments", "Den Preis von 260 € habe ich … geschätzt" and "wir brauchen" gave way to statements without pronouns, such as "3 getrennte Apartments im selben Haus" and "260 € geschätzt aus der Preisspanne im Shop".

## Patterns
- Opening line describing the page under a heading that already names it: "Preisliste für Alpe d'Huez, zum Vergleich mit …". Rule: docs.md "A page" ("The first line names what the page does") pulls the other way, reference.md "Prompt echo" agrees with the edit. Cause: Conflict (both readers on the first draft kept the line and cited docs.md. A reader of a draft without it added "Die Liste vergleicht die Kosten des Skiurlaubs in drei Orten.").
- Assumption carrying a hedge and its derivation: "etwa 2,00 € pro Liter (geschätzt, Super E10 kostet laut ADAC 1,938 €)". Rule: docs.md "Assumed values get declared once for the whole section". Cause: Narrow (both readers renamed the section "Annahmen" and still kept "geschätzt" with the ADAC price).
- Verb clause where a noun phrase carries the fact: "8 Personen gehen in die Skischule". Rule: SKILL.md "Short". Cause: Held ("8 Personen in der Skischule" from both readers).
- Personal voice in a list shared with a group: "Ihr wohnt", "habe ich geschätzt". Rule: docs.md "Register follows the page". Cause: Held (both readers moved to the third person).
- A step that the reader derives from the listed facts: "Eigene Ausrüstung: Einzelpreis beim jeweiligen Ort abziehen". Rule: SKILL.md "Let a fact stand alone" names connectors and participles alone. Cause: Narrow (both readers kept the step, expanded it to an imperative with a worked example and cited "An instruction or an obligation on the reader says so" and "A real case anchors a rule". One of them addressed the reader as "du" for it.).

## Scope
The causes come from four fresh readers handed writing-style and the agent drafts.
They read the text as a docs page.
Since the text falls outside writing-style, the case changes no rule.
The Conflict between docs.md "A page" and the "Prompt echo" tell stays open for a case inside its scope.
