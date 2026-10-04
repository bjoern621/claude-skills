# Pictures

Capture the picture from the running branch, upload it to the forge, then paste the returned Markdown under the sentence it shows.

## Capture

**Screenshot.**
Start the app from the branch (the project's dev command, or the `run` skill).
Shoot the changed element, cropped to it plus enough surroundings to place it.
A layout change takes the full viewport.
Headless, with Playwright:

```sh
npx playwright screenshot --viewport-size=1280,800 http://localhost:5173/connect after.png
```

With a browser already driven through `claude-in-chrome`, its screenshot action serves as well.
A page depending on the colour scheme gets the scheme its users default to.

**Before shot.**
Run the default branch in a second worktree at `origin/<default-branch>`, detached, and shoot the same view with the same viewport.
Remove that worktree afterwards.

**GIF.**
Record with `claude-in-chrome`'s `gif_creator`, padding a frame before and after the action.
Keep it under 10 MB, GitHub's cap for images, by shortening the clip or shrinking the viewport.

**Mermaid and text.**
A diagram, an error and CLI output go into the body as fenced blocks and need no upload.

## Upload

### GitLab

`glab` sends the file as multipart and the response carries ready Markdown:

```sh
glab api --hostname <host> --method POST "projects/<url-encoded project>/uploads" --form "file=@after.png" | jq -r .markdown
```

Paste the printed `![after](/uploads/…/after.png)` into the description.
The path resolves inside that project alone, so upload to the project the merge request belongs to.

### GitHub

GitHub's API has no endpoint for attachments.
Upload through the web editor with `claude-in-chrome`:
1. Open the pull request in a new tab.
2. Hand the file to the comment box's file input with `file_upload`.
3. Read the `![…](https://github.com/user-attachments/assets/…)` line the editor inserts.
4. Clear the comment box without submitting, close the tab.
5. Put the line into the description with `gh pr edit <number> --body-file <file>`.

Without a browser connection, open the PR with the text alone and tell the user which file to drag into which spot of the description.
