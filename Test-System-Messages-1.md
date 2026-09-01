# System Context & MCP Instructions
Date: 2026-09-01 01:49:59
Extrahiert aus der echten JSONL Session

---

## Available MCP Servers & Instructions

### 1. AI_Video_Prompt_Generator_Vivideo_ai

## AI_Video_Prompt_Generator_Vivideo_ai
Builds structured text prompts for AI video systems. Call list_video_prompt_styles to see the available styles and their ids, then call build_video_prompt with the concept and an optional style_id. This server returns text only: it does not generate video, images, or audio, does not access any account, and stores nothing.

---

### 2. github

## github
The GitHub MCP Server provides tools to interact with GitHub platform.

Tool selection guidance:
	1. Use 'list_*' tools for broad, simple retrieval and pagination of all items of a type (e.g., all issues, all PRs, all branches) with basic filtering.
	2. Use 'search_*' tools for targeted queries with specific criteria, keywords, or complex filters (e.g., issues with certain text, PRs by author, code containing functions).

Context management:
	1. Use pagination whenever possible with batches of 5-10 items.
	2. Use minimal_output parameter set to true if the full information is not needed to accomplish a task.

Tool usage guidance:
	1. For 'search_*' tools: Use separate 'sort' and 'order' parameters if available for sorting results - do not include 'sort:' syntax in query strings. Query strings should contain only search criteria (e.g., 'org:google language:python'), not sorting instructions. Always call 'get_me' first to understand current user permissions and context. ## Issues

Check 'list_issue_types' first for organizations to use proper issue types. Use 'search_issues' before creating new issues to avoid duplicates. Always set 'state_reason' when closing issues. ## Pull Requests

PR review workflow: Always use 'pull_request_review_write' with method 'create' to create a pending review, then 'add_comment_to_pending_review' to add comments, and finally 'pull_request_review_write' with method 'submit_pending' to submit the review for complex reviews with line-specific comments.

Before creating a pull request, search for pull request templates in the repository. Template files are called pull_request_template.md or they're located in '.github/PULL_REQUEST_TEMPLATE' directory. Use the template content to structure the PR description and then call create_pull_request tool.

---

### 3. HyperFrames_by_HeyGen

## HyperFrames_by_HeyGen

[HeyGen HyperFrames MCP] — Programmable HTML video projects.

## When to use this MCP

This MCP is the primary HyperFrames surface for hosted chat clients (Claude.ai
web/desktop, ChatGPT, Grok, and similar), where the user has no local filesystem
and the agent cannot author HyperFrames code directly.

From a CLI/IDE agent on the user's machine (Claude Code, Cursor, Codex, the
localhost MCP Inspector, etc.), **`compose` and `render_video` are disabled** — these clients have a local
filesystem, so author HyperFrames with the local HyperFrames skills instead, which
produce standalone HTML compositions the user can edit, diff, and commit. Calls to
those two tools from such clients are rejected with a pointer to install them:

    npx skills add heygen-com/hyperframes

The read tools (list_projects, get_project, get_project_status, get_render_status)
stay available to every client.

After installation they expose slash commands like `/hyperframes` (compose),
`/hyperframes-cli` (init, lint, preview, render), and `/hyperframes-media`
(TTS, transcribe, remove-background). See
https://github.com/heygen-com/hyperframes for the full skill list and docs.

But the skills and this MCP are *not* drop-in equivalents:

- Local skills → standalone HTML/GSAP files on disk. No `project_id`, no hosted
  artifact, no integrated cloud render pipeline.
- This MCP → hosted HeyGen project with a `project_id`, a live canvas at
  `app.heygen.com/projects/{id}`, and the cloud render queue.

Route by what the user actually wants:
- "Make a local HTML composition / something I can edit" → use a local skill.
- "Make a HeyGen project I can share / render in the cloud / open in the app"
  → use this MCP, even from a CLI agent.

## What it does

HyperFrames is HeyGen's framework for creating, editing, and rendering programmable
HTML-based video projects. Projects are authored interactively (Magic Edit
chat-driven flow) and rendered to MP4, WebM, or MOV at any framerate. Tools exposed
here cover composing, listing, fetching, and rendering projects… [truncated]

---

### 4. Idiolect

## Idiolect
Idiolect AI makes you write in THIS user's own voice. Before writing on the user's behalf, call get_my_voice once per conversation and follow its single `next` action. If the profile is missing, ask for representative, natural writing the user actually authored, then call create_my_voice. Never use prompts, instructions, questions, search queries, AI replies, AI drafts or rewrites, templates, boilerplate, quoted replies, or another person's writing as profile evidence; user approval is permission to store a piece, not proof they wrote it. If evidence is thin, ask only for the exact missing blocks and characters returned and retry create_my_voice. Use the explicit Writing Profile tools to list profiles, create another profile, add samples to an exact profile, change the current profile, or delete an exact profile. The server owns setup state, approval receipts, retries, and idempotency; never ask the user for workflow coordinates or tokens. After creation, reload the voice and continue the original writing task when one exists. Use record_voice_feedback only for an outputId returned by Idiolect AI. Use score_voice only when the user explicitly asks for measurement. For a rewrite, use it only when it preserves the user's meaning and fits their request. Voice Match is relative, not forensic, and unavailable scores must remain unavailable. Never infer another person's writing or invent the user's opinions or facts.

---

### 5. Melon

## Melon
Melon Music Service MCP Server

---

### 6. tldraw

## tldraw
Use `search` to query the tldraw Editor API spec (e.g. search for methods by category or name). Use `exec` to run JavaScript on the canvas — your code receives `editor` (the tldraw Editor instance) and helpers like toRichText, createShapeId, createArrowBetweenShapes. The current canvas state is kept in model context as raw TLShape, asset, and binding data.

---

### 7. AI_Video_Prompt_Generator_Vivideo_ai

## AI_Video_Prompt_Generator_Vivideo_ai
Builds structured text prompts for AI video systems. Call list_video_prompt_styles to see the available styles and their ids, then call build_video_prompt with the concept and an optional style_id. This server returns text only: it does not generate video, images, or audio, does not access any account, and stores nothing.

---

### 8. github

## github
The GitHub MCP Server provides tools to interact with GitHub platform.

Tool selection guidance:
	1. Use 'list_*' tools for broad, simple retrieval and pagination of all items of a type (e.g., all issues, all PRs, all branches) with basic filtering.
	2. Use 'search_*' tools for targeted queries with specific criteria, keywords, or complex filters (e.g., issues with certain text, PRs by author, code containing functions).

Context management:
	1. Use pagination whenever possible with batches of 5-10 items.
	2. Use minimal_output parameter set to true if the full information is not needed to accomplish a task.

Tool usage guidance:
	1. For 'search_*' tools: Use separate 'sort' and 'order' parameters if available for sorting results - do not include 'sort:' syntax in query strings. Query strings should contain only search criteria (e.g., 'org:google language:python'), not sorting instructions. Always call 'get_me' first to understand current user permissions and context. ## Issues

Check 'list_issue_types' first for organizations to use proper issue types. Use 'search_issues' before creating new issues to avoid duplicates. Always set 'state_reason' when closing issues. ## Pull Requests

PR review workflow: Always use 'pull_request_review_write' with method 'create' to create a pending review, then 'add_comment_to_pending_review' to add comments, and finally 'pull_request_review_write' with method 'submit_pending' to submit the review for complex reviews with line-specific comments.

Before creating a pull request, search for pull request templates in the repository. Template files are called pull_request_template.md or they're located in '.github/PULL_REQUEST_TEMPLATE' directory. Use the template content to structure the PR description and then call create_pull_request tool.

---

### 9. HyperFrames_by_HeyGen

## HyperFrames_by_HeyGen

[HeyGen HyperFrames MCP] — Programmable HTML video projects.

## When to use this MCP

This MCP is the primary HyperFrames surface for hosted chat clients (Claude.ai
web/desktop, ChatGPT, Grok, and similar), where the user has no local filesystem
and the agent cannot author HyperFrames code directly.

From a CLI/IDE agent on the user's machine (Claude Code, Cursor, Codex, the
localhost MCP Inspector, etc.), **`compose` and `render_video` are disabled** — these clients have a local
filesystem, so author HyperFrames with the local HyperFrames skills instead, which
produce standalone HTML compositions the user can edit, diff, and commit. Calls to
those two tools from such clients are rejected with a pointer to install them:

    npx skills add heygen-com/hyperframes

The read tools (list_projects, get_project, get_project_status, get_render_status)
stay available to every client.

After installation they expose slash commands like `/hyperframes` (compose),
`/hyperframes-cli` (init, lint, preview, render), and `/hyperframes-media`
(TTS, transcribe, remove-background). See
https://github.com/heygen-com/hyperframes for the full skill list and docs.

But the skills and this MCP are *not* drop-in equivalents:

- Local skills → standalone HTML/GSAP files on disk. No `project_id`, no hosted
  artifact, no integrated cloud render pipeline.
- This MCP → hosted HeyGen project with a `project_id`, a live canvas at
  `app.heygen.com/projects/{id}`, and the cloud render queue.

Route by what the user actually wants:
- "Make a local HTML composition / something I can edit" → use a local skill.
- "Make a HeyGen project I can share / render in the cloud / open in the app"
  → use this MCP, even from a CLI agent.

## What it does

HyperFrames is HeyGen's framework for creating, editing, and rendering programmable
HTML-based video projects. Projects are authored interactively (Magic Edit
chat-driven flow) and rendered to MP4, WebM, or MOV at any framerate. Tools exposed
here cover composing, listing, fetching, and rendering projects… [truncated]

---

### 10. Idiolect

## Idiolect
Idiolect AI makes you write in THIS user's own voice. Before writing on the user's behalf, call get_my_voice once per conversation and follow its single `next` action. If the profile is missing, ask for representative, natural writing the user actually authored, then call create_my_voice. Never use prompts, instructions, questions, search queries, AI replies, AI drafts or rewrites, templates, boilerplate, quoted replies, or another person's writing as profile evidence; user approval is permission to store a piece, not proof they wrote it. If evidence is thin, ask only for the exact missing blocks and characters returned and retry create_my_voice. Use the explicit Writing Profile tools to list profiles, create another profile, add samples to an exact profile, change the current profile, or delete an exact profile. The server owns setup state, approval receipts, retries, and idempotency; never ask the user for workflow coordinates or tokens. After creation, reload the voice and continue the original writing task when one exists. Use record_voice_feedback only for an outputId returned by Idiolect AI. Use score_voice only when the user explicitly asks for measurement. For a rewrite, use it only when it preserves the user's meaning and fits their request. Voice Match is relative, not forensic, and unavailable scores must remain unavailable. Never infer another person's writing or invent the user's opinions or facts.

---

### 11. Melon

## Melon
Melon Music Service MCP Server

---

### 12. tldraw

## tldraw
Use `search` to query the tldraw Editor API spec (e.g. search for methods by category or name). Use `exec` to run JavaScript on the canvas — your code receives `editor` (the tldraw Editor instance) and helpers like toRichText, createShapeId, createArrowBetweenShapes. The current canvas state is kept in model context as raw TLShape, asset, and binding data.

---

### 13. AI_Video_Prompt_Generator_Vivideo_ai

## AI_Video_Prompt_Generator_Vivideo_ai
Builds structured text prompts for AI video systems. Call list_video_prompt_styles to see the available styles and their ids, then call build_video_prompt with the concept and an optional style_id. This server returns text only: it does not generate video, images, or audio, does not access any account, and stores nothing.

---

### 14. github

## github
The GitHub MCP Server provides tools to interact with GitHub platform.

Tool selection guidance:
	1. Use 'list_*' tools for broad, simple retrieval and pagination of all items of a type (e.g., all issues, all PRs, all branches) with basic filtering.
	2. Use 'search_*' tools for targeted queries with specific criteria, keywords, or complex filters (e.g., issues with certain text, PRs by author, code containing functions).

Context management:
	1. Use pagination whenever possible with batches of 5-10 items.
	2. Use minimal_output parameter set to true if the full information is not needed to accomplish a task.

Tool usage guidance:
	1. For 'search_*' tools: Use separate 'sort' and 'order' parameters if available for sorting results - do not include 'sort:' syntax in query strings. Query strings should contain only search criteria (e.g., 'org:google language:python'), not sorting instructions. Always call 'get_me' first to understand current user permissions and context. ## Issues

Check 'list_issue_types' first for organizations to use proper issue types. Use 'search_issues' before creating new issues to avoid duplicates. Always set 'state_reason' when closing issues. ## Pull Requests

PR review workflow: Always use 'pull_request_review_write' with method 'create' to create a pending review, then 'add_comment_to_pending_review' to add comments, and finally 'pull_request_review_write' with method 'submit_pending' to submit the review for complex reviews with line-specific comments.

Before creating a pull request, search for pull request templates in the repository. Template files are called pull_request_template.md or they're located in '.github/PULL_REQUEST_TEMPLATE' directory. Use the template content to structure the PR description and then call create_pull_request tool.

---

### 15. HyperFrames_by_HeyGen

## HyperFrames_by_HeyGen

[HeyGen HyperFrames MCP] — Programmable HTML video projects.

## When to use this MCP

This MCP is the primary HyperFrames surface for hosted chat clients (Claude.ai
web/desktop, ChatGPT, Grok, and similar), where the user has no local filesystem
and the agent cannot author HyperFrames code directly.

From a CLI/IDE agent on the user's machine (Claude Code, Cursor, Codex, the
localhost MCP Inspector, etc.), **`compose` and `render_video` are disabled** — these clients have a local
filesystem, so author HyperFrames with the local HyperFrames skills instead, which
produce standalone HTML compositions the user can edit, diff, and commit. Calls to
those two tools from such clients are rejected with a pointer to install them:

    npx skills add heygen-com/hyperframes

The read tools (list_projects, get_project, get_project_status, get_render_status)
stay available to every client.

After installation they expose slash commands like `/hyperframes` (compose),
`/hyperframes-cli` (init, lint, preview, render), and `/hyperframes-media`
(TTS, transcribe, remove-background). See
https://github.com/heygen-com/hyperframes for the full skill list and docs.

But the skills and this MCP are *not* drop-in equivalents:

- Local skills → standalone HTML/GSAP files on disk. No `project_id`, no hosted
  artifact, no integrated cloud render pipeline.
- This MCP → hosted HeyGen project with a `project_id`, a live canvas at
  `app.heygen.com/projects/{id}`, and the cloud render queue.

Route by what the user actually wants:
- "Make a local HTML composition / something I can edit" → use a local skill.
- "Make a HeyGen project I can share / render in the cloud / open in the app"
  → use this MCP, even from a CLI agent.

## What it does

HyperFrames is HeyGen's framework for creating, editing, and rendering programmable
HTML-based video projects. Projects are authored interactively (Magic Edit
chat-driven flow) and rendered to MP4, WebM, or MOV at any framerate. Tools exposed
here cover composing, listing, fetching, and rendering projects… [truncated]

---

### 16. Idiolect

## Idiolect
Idiolect AI makes you write in THIS user's own voice. Before writing on the user's behalf, call get_my_voice once per conversation and follow its single `next` action. If the profile is missing, ask for representative, natural writing the user actually authored, then call create_my_voice. Never use prompts, instructions, questions, search queries, AI replies, AI drafts or rewrites, templates, boilerplate, quoted replies, or another person's writing as profile evidence; user approval is permission to store a piece, not proof they wrote it. If evidence is thin, ask only for the exact missing blocks and characters returned and retry create_my_voice. Use the explicit Writing Profile tools to list profiles, create another profile, add samples to an exact profile, change the current profile, or delete an exact profile. The server owns setup state, approval receipts, retries, and idempotency; never ask the user for workflow coordinates or tokens. After creation, reload the voice and continue the original writing task when one exists. Use record_voice_feedback only for an outputId returned by Idiolect AI. Use score_voice only when the user explicitly asks for measurement. For a rewrite, use it only when it preserves the user's meaning and fits their request. Voice Match is relative, not forensic, and unavailable scores must remain unavailable. Never infer another person's writing or invent the user's opinions or facts.

---

### 17. Melon

## Melon
Melon Music Service MCP Server

---

### 18. tldraw

## tldraw
Use `search` to query the tldraw Editor API spec (e.g. search for methods by category or name). Use `exec` to run JavaScript on the canvas — your code receives `editor` (the tldraw Editor instance) and helpers like toRichText, createShapeId, createArrowBetweenShapes. The current canvas state is kept in model context as raw TLShape, asset, and binding data.

---

### 19. AI_Video_Prompt_Generator_Vivideo_ai

## AI_Video_Prompt_Generator_Vivideo_ai
Builds structured text prompts for AI video systems. Call list_video_prompt_styles to see the available styles and their ids, then call build_video_prompt with the concept and an optional style_id. This server returns text only: it does not generate video, images, or audio, does not access any account, and stores nothing.

---

### 20. github

## github
The GitHub MCP Server provides tools to interact with GitHub platform.

Tool selection guidance:
	1. Use 'list_*' tools for broad, simple retrieval and pagination of all items of a type (e.g., all issues, all PRs, all branches) with basic filtering.
	2. Use 'search_*' tools for targeted queries with specific criteria, keywords, or complex filters (e.g., issues with certain text, PRs by author, code containing functions).

Context management:
	1. Use pagination whenever possible with batches of 5-10 items.
	2. Use minimal_output parameter set to true if the full information is not needed to accomplish a task.

Tool usage guidance:
	1. For 'search_*' tools: Use separate 'sort' and 'order' parameters if available for sorting results - do not include 'sort:' syntax in query strings. Query strings should contain only search criteria (e.g., 'org:google language:python'), not sorting instructions. Always call 'get_me' first to understand current user permissions and context. ## Issues

Check 'list_issue_types' first for organizations to use proper issue types. Use 'search_issues' before creating new issues to avoid duplicates. Always set 'state_reason' when closing issues. ## Pull Requests

PR review workflow: Always use 'pull_request_review_write' with method 'create' to create a pending review, then 'add_comment_to_pending_review' to add comments, and finally 'pull_request_review_write' with method 'submit_pending' to submit the review for complex reviews with line-specific comments.

Before creating a pull request, search for pull request templates in the repository. Template files are called pull_request_template.md or they're located in '.github/PULL_REQUEST_TEMPLATE' directory. Use the template content to structure the PR description and then call create_pull_request tool.

---

### 21. HyperFrames_by_HeyGen

## HyperFrames_by_HeyGen

[HeyGen HyperFrames MCP] — Programmable HTML video projects.

## When to use this MCP

This MCP is the primary HyperFrames surface for hosted chat clients (Claude.ai
web/desktop, ChatGPT, Grok, and similar), where the user has no local filesystem
and the agent cannot author HyperFrames code directly.

From a CLI/IDE agent on the user's machine (Claude Code, Cursor, Codex, the
localhost MCP Inspector, etc.), **`compose` and `render_video` are disabled** — these clients have a local
filesystem, so author HyperFrames with the local HyperFrames skills instead, which
produce standalone HTML compositions the user can edit, diff, and commit. Calls to
those two tools from such clients are rejected with a pointer to install them:

    npx skills add heygen-com/hyperframes

The read tools (list_projects, get_project, get_project_status, get_render_status)
stay available to every client.

After installation they expose slash commands like `/hyperframes` (compose),
`/hyperframes-cli` (init, lint, preview, render), and `/hyperframes-media`
(TTS, transcribe, remove-background). See
https://github.com/heygen-com/hyperframes for the full skill list and docs.

But the skills and this MCP are *not* drop-in equivalents:

- Local skills → standalone HTML/GSAP files on disk. No `project_id`, no hosted
  artifact, no integrated cloud render pipeline.
- This MCP → hosted HeyGen project with a `project_id`, a live canvas at
  `app.heygen.com/projects/{id}`, and the cloud render queue.

Route by what the user actually wants:
- "Make a local HTML composition / something I can edit" → use a local skill.
- "Make a HeyGen project I can share / render in the cloud / open in the app"
  → use this MCP, even from a CLI agent.

## What it does

HyperFrames is HeyGen's framework for creating, editing, and rendering programmable
HTML-based video projects. Projects are authored interactively (Magic Edit
chat-driven flow) and rendered to MP4, WebM, or MOV at any framerate. Tools exposed
here cover composing, listing, fetching, and rendering projects… [truncated]

---

### 22. Idiolect

## Idiolect
Idiolect AI makes you write in THIS user's own voice. Before writing on the user's behalf, call get_my_voice once per conversation and follow its single `next` action. If the profile is missing, ask for representative, natural writing the user actually authored, then call create_my_voice. Never use prompts, instructions, questions, search queries, AI replies, AI drafts or rewrites, templates, boilerplate, quoted replies, or another person's writing as profile evidence; user approval is permission to store a piece, not proof they wrote it. If evidence is thin, ask only for the exact missing blocks and characters returned and retry create_my_voice. Use the explicit Writing Profile tools to list profiles, create another profile, add samples to an exact profile, change the current profile, or delete an exact profile. The server owns setup state, approval receipts, retries, and idempotency; never ask the user for workflow coordinates or tokens. After creation, reload the voice and continue the original writing task when one exists. Use record_voice_feedback only for an outputId returned by Idiolect AI. Use score_voice only when the user explicitly asks for measurement. For a rewrite, use it only when it preserves the user's meaning and fits their request. Voice Match is relative, not forensic, and unavailable scores must remain unavailable. Never infer another person's writing or invent the user's opinions or facts.

---

### 23. Melon

## Melon
Melon Music Service MCP Server

---

### 24. tldraw

## tldraw
Use `search` to query the tldraw Editor API spec (e.g. search for methods by category or name). Use `exec` to run JavaScript on the canvas — your code receives `editor` (the tldraw Editor instance) and helpers like toRichText, createShapeId, createArrowBetweenShapes. The current canvas state is kept in model context as raw TLShape, asset, and binding data.

---

### 25. HyperFrames_by_HeyGen

## HyperFrames_by_HeyGen

[HeyGen HyperFrames MCP] — Programmable HTML video projects.

## When to use this MCP

This MCP is the primary HyperFrames surface for hosted chat clients (Claude.ai
web/desktop, ChatGPT, Grok, and similar), where the user has no local filesystem
and the agent cannot author HyperFrames code directly.

From a CLI/IDE agent on the user's machine (Claude Code, Cursor, Codex, the
localhost MCP Inspector, etc.), **`compose` and `render_video` are disabled** — these clients have a local
filesystem, so author HyperFrames with the local HyperFrames skills instead, which
produce standalone HTML compositions the user can edit, diff, and commit. Calls to
those two tools from such clients are rejected with a pointer to install them:

    npx skills add heygen-com/hyperframes

The read tools (list_projects, get_project, get_project_status, get_render_status)
stay available to every client.

After installation they expose slash commands like `/hyperframes` (compose),
`/hyperframes-cli` (init, lint, preview, render), and `/hyperframes-media`
(TTS, transcribe, remove-background). See
https://github.com/heygen-com/hyperframes for the full skill list and docs.

But the skills and this MCP are *not* drop-in equivalents:

- Local skills → standalone HTML/GSAP files on disk. No `project_id`, no hosted
  artifact, no integrated cloud render pipeline.
- This MCP → hosted HeyGen project with a `project_id`, a live canvas at
  `app.heygen.com/projects/{id}`, and the cloud render queue.

Route by what the user actually wants:
- "Make a local HTML composition / something I can edit" → use a local skill.
- "Make a HeyGen project I can share / render in the cloud / open in the app"
  → use this MCP, even from a CLI agent.

## What it does

HyperFrames is HeyGen's framework for creating, editing, and rendering programmable
HTML-based video projects. Projects are authored interactively (Magic Edit
chat-driven flow) and rendered to MP4, WebM, or MOV at any framerate. Tools exposed
here cover composing, listing, fetching, and rendering projects… [truncated]

---

### 26. Melon

## Melon
Melon Music Service MCP Server

---

### 27. AI_Video_Prompt_Generator_Vivideo_ai

## AI_Video_Prompt_Generator_Vivideo_ai
Builds structured text prompts for AI video systems. Call list_video_prompt_styles to see the available styles and their ids, then call build_video_prompt with the concept and an optional style_id. This server returns text only: it does not generate video, images, or audio, does not access any account, and stores nothing.

---

### 28. github

## github
The GitHub MCP Server provides tools to interact with GitHub platform.

Tool selection guidance:
	1. Use 'list_*' tools for broad, simple retrieval and pagination of all items of a type (e.g., all issues, all PRs, all branches) with basic filtering.
	2. Use 'search_*' tools for targeted queries with specific criteria, keywords, or complex filters (e.g., issues with certain text, PRs by author, code containing functions).

Context management:
	1. Use pagination whenever possible with batches of 5-10 items.
	2. Use minimal_output parameter set to true if the full information is not needed to accomplish a task.

Tool usage guidance:
	1. For 'search_*' tools: Use separate 'sort' and 'order' parameters if available for sorting results - do not include 'sort:' syntax in query strings. Query strings should contain only search criteria (e.g., 'org:google language:python'), not sorting instructions. Always call 'get_me' first to understand current user permissions and context. ## Issues

Check 'list_issue_types' first for organizations to use proper issue types. Use 'search_issues' before creating new issues to avoid duplicates. Always set 'state_reason' when closing issues. ## Pull Requests

PR review workflow: Always use 'pull_request_review_write' with method 'create' to create a pending review, then 'add_comment_to_pending_review' to add comments, and finally 'pull_request_review_write' with method 'submit_pending' to submit the review for complex reviews with line-specific comments.

Before creating a pull request, search for pull request templates in the repository. Template files are called pull_request_template.md or they're located in '.github/PULL_REQUEST_TEMPLATE' directory. Use the template content to structure the PR description and then call create_pull_request tool.

---

### 29. HyperFrames_by_HeyGen

## HyperFrames_by_HeyGen

[HeyGen HyperFrames MCP] — Programmable HTML video projects.

## When to use this MCP

This MCP is the primary HyperFrames surface for hosted chat clients (Claude.ai
web/desktop, ChatGPT, Grok, and similar), where the user has no local filesystem
and the agent cannot author HyperFrames code directly.

From a CLI/IDE agent on the user's machine (Claude Code, Cursor, Codex, the
localhost MCP Inspector, etc.), **`compose` and `render_video` are disabled** — these clients have a local
filesystem, so author HyperFrames with the local HyperFrames skills instead, which
produce standalone HTML compositions the user can edit, diff, and commit. Calls to
those two tools from such clients are rejected with a pointer to install them:

    npx skills add heygen-com/hyperframes

The read tools (list_projects, get_project, get_project_status, get_render_status)
stay available to every client.

After installation they expose slash commands like `/hyperframes` (compose),
`/hyperframes-cli` (init, lint, preview, render), and `/hyperframes-media`
(TTS, transcribe, remove-background). See
https://github.com/heygen-com/hyperframes for the full skill list and docs.

But the skills and this MCP are *not* drop-in equivalents:

- Local skills → standalone HTML/GSAP files on disk. No `project_id`, no hosted
  artifact, no integrated cloud render pipeline.
- This MCP → hosted HeyGen project with a `project_id`, a live canvas at
  `app.heygen.com/projects/{id}`, and the cloud render queue.

Route by what the user actually wants:
- "Make a local HTML composition / something I can edit" → use a local skill.
- "Make a HeyGen project I can share / render in the cloud / open in the app"
  → use this MCP, even from a CLI agent.

## What it does

HyperFrames is HeyGen's framework for creating, editing, and rendering programmable
HTML-based video projects. Projects are authored interactively (Magic Edit
chat-driven flow) and rendered to MP4, WebM, or MOV at any framerate. Tools exposed
here cover composing, listing, fetching, and rendering projects… [truncated]

---

### 30. tldraw

## tldraw
Use `search` to query the tldraw Editor API spec (e.g. search for methods by category or name). Use `exec` to run JavaScript on the canvas — your code receives `editor` (the tldraw Editor instance) and helpers like toRichText, createShapeId, createArrowBetweenShapes. The current canvas state is kept in model context as raw TLShape, asset, and binding data.

---

### 31. HyperFrames_by_HeyGen

## HyperFrames_by_HeyGen

[HeyGen HyperFrames MCP] — Programmable HTML video projects.

## When to use this MCP

This MCP is the primary HyperFrames surface for hosted chat clients (Claude.ai
web/desktop, ChatGPT, Grok, and similar), where the user has no local filesystem
and the agent cannot author HyperFrames code directly.

From a CLI/IDE agent on the user's machine (Claude Code, Cursor, Codex, the
localhost MCP Inspector, etc.), **`compose` and `render_video` are disabled** — these clients have a local
filesystem, so author HyperFrames with the local HyperFrames skills instead, which
produce standalone HTML compositions the user can edit, diff, and commit. Calls to
those two tools from such clients are rejected with a pointer to install them:

    npx skills add heygen-com/hyperframes

The read tools (list_projects, get_project, get_project_status, get_render_status)
stay available to every client.

After installation they expose slash commands like `/hyperframes` (compose),
`/hyperframes-cli` (init, lint, preview, render), and `/hyperframes-media`
(TTS, transcribe, remove-background). See
https://github.com/heygen-com/hyperframes for the full skill list and docs.

But the skills and this MCP are *not* drop-in equivalents:

- Local skills → standalone HTML/GSAP files on disk. No `project_id`, no hosted
  artifact, no integrated cloud render pipeline.
- This MCP → hosted HeyGen project with a `project_id`, a live canvas at
  `app.heygen.com/projects/{id}`, and the cloud render queue.

Route by what the user actually wants:
- "Make a local HTML composition / something I can edit" → use a local skill.
- "Make a HeyGen project I can share / render in the cloud / open in the app"
  → use this MCP, even from a CLI agent.

## What it does

HyperFrames is HeyGen's framework for creating, editing, and rendering programmable
HTML-based video projects. Projects are authored interactively (Magic Edit
chat-driven flow) and rendered to MP4, WebM, or MOV at any framerate. Tools exposed
here cover composing, listing, fetching, and rendering projects… [truncated]

---

### 32. tldraw

## tldraw
Use `search` to query the tldraw Editor API spec (e.g. search for methods by category or name). Use `exec` to run JavaScript on the canvas — your code receives `editor` (the tldraw Editor instance) and helpers like toRichText, createShapeId, createArrowBetweenShapes. The current canvas state is kept in model context as raw TLShape, asset, and binding data.

---

### 33. AI_Video_Prompt_Generator_Vivideo_ai

## AI_Video_Prompt_Generator_Vivideo_ai
Builds structured text prompts for AI video systems. Call list_video_prompt_styles to see the available styles and their ids, then call build_video_prompt with the concept and an optional style_id. This server returns text only: it does not generate video, images, or audio, does not access any account, and stores nothing.

---

### 34. github

## github
The GitHub MCP Server provides tools to interact with GitHub platform.

Tool selection guidance:
	1. Use 'list_*' tools for broad, simple retrieval and pagination of all items of a type (e.g., all issues, all PRs, all branches) with basic filtering.
	2. Use 'search_*' tools for targeted queries with specific criteria, keywords, or complex filters (e.g., issues with certain text, PRs by author, code containing functions).

Context management:
	1. Use pagination whenever possible with batches of 5-10 items.
	2. Use minimal_output parameter set to true if the full information is not needed to accomplish a task.

Tool usage guidance:
	1. For 'search_*' tools: Use separate 'sort' and 'order' parameters if available for sorting results - do not include 'sort:' syntax in query strings. Query strings should contain only search criteria (e.g., 'org:google language:python'), not sorting instructions. Always call 'get_me' first to understand current user permissions and context. ## Issues

Check 'list_issue_types' first for organizations to use proper issue types. Use 'search_issues' before creating new issues to avoid duplicates. Always set 'state_reason' when closing issues. ## Pull Requests

PR review workflow: Always use 'pull_request_review_write' with method 'create' to create a pending review, then 'add_comment_to_pending_review' to add comments, and finally 'pull_request_review_write' with method 'submit_pending' to submit the review for complex reviews with line-specific comments.

Before creating a pull request, search for pull request templates in the repository. Template files are called pull_request_template.md or they're located in '.github/PULL_REQUEST_TEMPLATE' directory. Use the template content to structure the PR description and then call create_pull_request tool.

---

### 35. HyperFrames_by_HeyGen

## HyperFrames_by_HeyGen

[HeyGen HyperFrames MCP] — Programmable HTML video projects.

## When to use this MCP

This MCP is the primary HyperFrames surface for hosted chat clients (Claude.ai
web/desktop, ChatGPT, Grok, and similar), where the user has no local filesystem
and the agent cannot author HyperFrames code directly.

From a CLI/IDE agent on the user's machine (Claude Code, Cursor, Codex, the
localhost MCP Inspector, etc.), **`compose` and `render_video` are disabled** — these clients have a local
filesystem, so author HyperFrames with the local HyperFrames skills instead, which
produce standalone HTML compositions the user can edit, diff, and commit. Calls to
those two tools from such clients are rejected with a pointer to install them:

    npx skills add heygen-com/hyperframes

The read tools (list_projects, get_project, get_project_status, get_render_status)
stay available to every client.

After installation they expose slash commands like `/hyperframes` (compose),
`/hyperframes-cli` (init, lint, preview, render), and `/hyperframes-media`
(TTS, transcribe, remove-background). See
https://github.com/heygen-com/hyperframes for the full skill list and docs.

But the skills and this MCP are *not* drop-in equivalents:

- Local skills → standalone HTML/GSAP files on disk. No `project_id`, no hosted
  artifact, no integrated cloud render pipeline.
- This MCP → hosted HeyGen project with a `project_id`, a live canvas at
  `app.heygen.com/projects/{id}`, and the cloud render queue.

Route by what the user actually wants:
- "Make a local HTML composition / something I can edit" → use a local skill.
- "Make a HeyGen project I can share / render in the cloud / open in the app"
  → use this MCP, even from a CLI agent.

## What it does

HyperFrames is HeyGen's framework for creating, editing, and rendering programmable
HTML-based video projects. Projects are authored interactively (Magic Edit
chat-driven flow) and rendered to MP4, WebM, or MOV at any framerate. Tools exposed
here cover composing, listing, fetching, and rendering projects… [truncated]

---

### 36. Idiolect

## Idiolect
Idiolect AI makes you write in THIS user's own voice. Before writing on the user's behalf, call get_my_voice once per conversation and follow its single `next` action. If the profile is missing, ask for representative, natural writing the user actually authored, then call create_my_voice. Never use prompts, instructions, questions, search queries, AI replies, AI drafts or rewrites, templates, boilerplate, quoted replies, or another person's writing as profile evidence; user approval is permission to store a piece, not proof they wrote it. If evidence is thin, ask only for the exact missing blocks and characters returned and retry create_my_voice. Use the explicit Writing Profile tools to list profiles, create another profile, add samples to an exact profile, change the current profile, or delete an exact profile. The server owns setup state, approval receipts, retries, and idempotency; never ask the user for workflow coordinates or tokens. After creation, reload the voice and continue the original writing task when one exists. Use record_voice_feedback only for an outputId returned by Idiolect AI. Use score_voice only when the user explicitly asks for measurement. For a rewrite, use it only when it preserves the user's meaning and fits their request. Voice Match is relative, not forensic, and unavailable scores must remain unavailable. Never infer another person's writing or invent the user's opinions or facts.

---

### 37. Melon

## Melon
Melon Music Service MCP Server

---

### 38. tldraw

## tldraw
Use `search` to query the tldraw Editor API spec (e.g. search for methods by category or name). Use `exec` to run JavaScript on the canvas — your code receives `editor` (the tldraw Editor instance) and helpers like toRichText, createShapeId, createArrowBetweenShapes. The current canvas state is kept in model context as raw TLShape, asset, and binding data.

---

