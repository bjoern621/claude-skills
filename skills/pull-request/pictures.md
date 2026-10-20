# Pictures

Capture from the running branch, upload to the forge, paste the returned Markdown under the sentence that it shows.

## Capture

Screenshot: start the app from the branch and shoot the viewport holding the changed element.
A page that depends on the colour scheme gets the light scheme unless the project ships dark by default.

```sh
npx playwright screenshot --viewport-size=1280,800 http://localhost:5173/connect after.png
```

Before shot: run the default branch in a detached second worktree at `origin/<default-branch>`.
Shoot the same view with the same viewport, then remove that worktree.

GIF: record with `claude-in-chrome`'s `gif_creator`, padding a frame before and after the action.
GitHub caps images at 10 MB.

A diagram, an error and CLI output go into the body as fenced blocks.

## Upload

GitLab returns ready Markdown:

```sh
glab api --hostname <host> --method POST "projects/<url-encoded project>/uploads" --form "file=@after.png" | jq -r .markdown
```

The returned path resolves inside the project that the merge request belongs to.

GitHub offers no attachment API.
Open the PR with its text first, then add the picture.
Upload through the web editor with `claude-in-chrome`:
1. Open the pull request in a new tab.
2. Hand the file to the comment box's file input with `file_upload`.
3. Copy the `![…](https://github.com/user-attachments/assets/…)` line that the editor inserts.
4. Clear the comment box unsubmitted and close the tab.
5. Put the line into the description with `gh pr edit <number> --body-file <file>`.

Without a browser connection, the PR opens with text alone.
The report tells the user which file to drag where.
