---
name: prisma-browser-access-data-control-rule
description: Creates, clones or edits a Prisma Browser Access & Data Control rule in Strata Cloud Manager with the user. The user validates a rule card first, the agent fills the console through a browser MCP server, the user saves and publishes. Use when the user asks to create, clone or edit an Access & Data Control rule for Prisma Browser.
---

# Prisma Browser Access & Data Control rule

Scope: Access & Data Control rules only. Browser Security and Browser Customization rules are out of scope.

## Absolute rules

- The user validates the rule card before any input in the console.
- The agent fills the form fields. The user clicks **Save** and **Publish**.
- The agent never types credentials. If the console asks for a login, the user logs in.
- Before each keystroke, check the page URL and the active field.

## Naming

Ask the user for their naming convention. Default proposal:

- Rule: `<scope>-<object>`, lowercase, words separated by `_`: `prod-block_genai_upload`, `test-read_only`.
- Rule section: one per usage, for example `prod-rules` and `test-rules`. A rule goes in the section of its usage.

## Known pitfalls

### Redirect to an address of the targeted category

A rule cannot redirect to an address that belongs to the applications or categories the rule targets. The redirect would trigger the rule again.

Example: category **Artificial Intelligence**, **Redirect** to an AI assistant URL. The console shows, under the URL field: "This URL is classified under the "Artificial Intelligence" category you are redirecting from, which would cause a redirect loop. Please choose a different URL." The **Access** tab shows **Redirect loop conflict** and the rule does not save.

The **Redirect** URL must be outside the applications, categories (**Website classification**) and URLs of the rule. To send the user to a site of the targeted category:

1. **Block** with a link: **Edit dialog text** > **Customize and edit dialog texts** > **Add link** (**Link name**, **URL**). An **Allow** rule placed above allows the linked site.
2. Or **Redirect** to a page outside the category (for example a company page) that links to the site.

Switching from **Redirect** to **Block** resets the dialog text: type it again.

### See the text of AI prompts (GenAI prompt)

For events to show the text of prompts sent to an AI assistant, the rule that allows this assistant needs two settings:

1. **Controls and data profiles** > **GenAI prompt** card > **+ Set value...** > **Allow** > **Set**. The tab shows **Controls and data profiles | GenAI prompt**.
2. **Tracking** > **Activity logging** to **On** > under **GenAI Prompt**, check **Prompt content**. This checkbox appears only after setting 1.

After publication, read the prompt in **Insights** > **Analytics** > **Events**: category **DLP**, type **GenAI prompt**, filter **User**, then the event detail.

- Edit the existing **Allow** rule of the assistant. A rule placed below never matches (first match wins).
- The control covers only the assistants listed by icons in its dialog ("This control supports the listed Gen AI apps"). As of November 2026: ChatGPT, Copilot, Gemini, Claude, Perplexity.
- **Block** with a data profile (**When Contains**) blocks prompts that contain sensitive data.
- Prompt text is personal data. Flag it in the rule card and get approval from the data owner.

### Rule order

Prisma Browser reads rules from top to bottom. An exception (**Allow**) goes above the broad rule it bypasses. **Create rule at top of section** puts the new rule first in the section: create the broad rule first, then the exception.

### Console input

- Text fields (name, description, message) need real keystrokes. A value set by script is ignored: the counter stays at `0`, and the value can land in another field.
- Close an open list (users, applications, categories) with `Tab`. `Escape` can cancel the selection.

## Steps

1. **Rule card**, shown to the user and validated: name, rule section, mode (Active, Monitoring, Disabled), scope (users, groups, devices, networks, countries), applications or categories, access action (Allow, Prompt, Redirect, Block), data controls, dialog text.
2. **Check the catalog**: each application or category of the card exists in the console (search in the application picker). Report any missing item before input.
3. **Input**: Configuration > Policy > Rules > **Access & Data Control** tab > **Create new rule** on the section row. Fill the fields in the order of the card. Take a screenshot at the end.
4. **Save**: the user reviews and clicks **Save**.
5. **Publish**: propose a version description (300 characters max), for example `feat(prod): add rule prod-block_genai_upload`. The user clicks **Publish**.
6. **Test**: Prisma Browser receives a published version after a few minutes. On a test device, trigger the rule, check the effect on screen, then the event in **Insights** > **Analytics** > **Events** (**Policy rule** column). A value written through accessibility tools does not prove a typing block: check on screen or in the events.
