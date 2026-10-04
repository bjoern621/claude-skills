# Issues

Shape of an issue, modelled on the PeerDrop issues the team wrote by hand (numbers below 250).
Wording follows [writing-style](../writing-style/SKILL.md); pictures follow the table in [SKILL.md](SKILL.md), step 4.

## Template

Take the project's issue template when one exists: `.github/ISSUE_TEMPLATE/`, `.gitlab/issue_templates/`.
Its title prefix and its section headings carry over (`[Bug]: `, `### Schritte zur Reproduktion`).
A section with nothing to say goes, heading included.
Write in the project's language, as for a pull request.

## Title

Name the problem or the capability in 2 to 6 words.

- `[Bug]: OTP Input auf Handy`
- `[US]: Copy Button eigener Token`
- `[Task]: Doppelte Github Actions`

## Body by type

**User story.**
One sentence in the form "As a <role> I can <capability>, so that <benefit>": "Als Benutzer habe ich neben der Anzeige meines persönlichen Token einen Copy Button, damit der Token schnell kopiert wird."
Acceptance criteria follow as checkboxes, each one a state somebody can check by looking:
> - [ ] Der Copy Button wird auf der LandingPage angezeigt
> - [ ] Nach dem Kopieren erscheint eine Meldung

**Bug.**
One or two sentences on what goes wrong, then numbered steps from a fresh start to the failure:
> 1. Öffne die LandingPage auf einem beliebigen Handy
> 2. Tippe in das OTP Input
> 3. Es öffnet sich die Zifferntastatur des Betriebsystems

Where the right behaviour is not obvious from the steps, two labelled lines "Aktuelles Verhalten:" and "Erwartetes Verhalten:" state both.
A known culprit goes in as the offending line in a code block.

**Task.**
One paragraph: what to do and why.
Known spots go in as a list, each with its location:
> - `Console.WriteLine($"Session Token received {sessionToken}");` (DeviceHandler:23)
> - `console.log("response:", response);` (Fetch.tsx:35)

## Links

Name each dependency in its own line, in the project's words: "Voraussetzung: #7", "Blocked by #187", "Zur Weiterführung von #186".
A design source, an upstream issue or a reference page goes in as a link next to the sentence using it.

## Questions

An undecided point stays a question in the issue: "Speicherung per Map oder Redis?"
Several candidate wordings for a UI string go in as a list for the team to pick from.

## Pictures

A UI task carries the wireframe or mockup it builds.
A change between two states shows both: "Vor Hinzufügen:" with one screenshot, "Nach Hinzufügen:" with the other.
A bug shows the broken screen or the console error.

## Finished

The issue is finished once the template's sections with content are filled, every acceptance criterion and repro step can be checked by somebody else, each dependency is linked and the picture the type calls for is in.
