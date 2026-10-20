# Issues

Shape of an issue, modelled on the PeerDrop issues that the team wrote by hand.
Wording follows `writing-style`.

## Title and template

The project's issue template (`.github/ISSUE_TEMPLATE/`, `.gitlab/issue_templates/`) sets the title prefix and the section headings.
Without a template, prefix and headings follow the project's recent issues.
A section with nothing to say goes, heading included.
The title names the problem or the capability in 2 to 6 words: `[Bug]: OTP Input auf Handy`.
Title and body follow the project's language, as in [SKILL.md](SKILL.md), step 1.

## Body by type

User story: one sentence "As a <role> I can <capability>, so that <benefit>", then acceptance criteria as checkboxes.
Each criterion names a state that somebody can check by looking.

Bug: one or two sentences on what goes wrong, then numbered steps from a fresh start to the failure.
Current and expected behaviour follow in the project's language ("Aktuelles Verhalten:") where the steps leave the right behaviour open.
A known culprit goes in as the offending line in a code block.

Task: one paragraph on what to do and why, then known spots as a list, each with its location.

## Links and questions

Each dependency takes its own line in the project's words: "Voraussetzung: #7", "Blocked by #187".
A design source or an upstream issue goes in as a link beside the sentence using it.
An undecided point stays a question: "Speicherung per Map oder Redis?"

## Finished

- Every template section is filled or removed with its heading.
- Somebody else can check every acceptance criterion and repro step.
- Each dependency is linked.
- A UI task carries its mockup, a bug its broken screen or console error.
