---
name: prisma-browser-customization-rule
description: Creates, clones or edits a Prisma Browser Browser Customization rule in Strata Cloud Manager with the user. The user validates a rule card first, the agent fills the console through a browser MCP server, the user saves and publishes. Use when the user asks to prepare Prisma Browser for a group of users, for example company shortcuts, forced extensions, new tab page, logo, brand color or onboarding wizard.
license: Apache-2.0
compatibility: Requires a browser MCP server with file upload (for example Chrome DevTools MCP), a model with tool calling, and a Strata Cloud Manager account with rights on Prisma Browser policies.
metadata:
  author: cyberseren
  version: "0.1.0"
---

# Prisma Browser Browser Customization rule

Scope: Browser Customization rules only. They prepare what the user sees and finds at first launch. They block nothing. Access & Data Control and Browser Security rules are out of scope.

## Absolute rules

- The user validates the rule card before any input in the console.
- The agent fills the form fields. The user clicks **Save** and **Publish**.
- The agent never types credentials. If the console asks for a login, the user logs in.
- Before each keystroke, check the page URL and the active field.

## Naming

Ask the user for their naming convention. Default proposal:

- Rule: `<scope>-<object>`, lowercase, words separated by `_`: `prod-managed_shortcuts`, `test-no_onboarding`.
- Rule section: one per usage, for example `prod-rules` and `test-rules`. A rule goes in the section of its usage.

## How rules apply

- Prisma Browser reads rules from top to bottom. The first rule whose scope matches the user applies.
- The last rule, **Browser Customization - baseline**, applies to every user that no other rule targets.
- A rule for one population goes in a section above the baseline.
- Put all the controls of one population in one rule. A second rule for the same users never matches.
- A control the rule does not set stays at **Not set**.

## Controls

The console groups the controls in families:

- **Branding**: theme color, brand color, logo, company name, dialog texts.
- **Customization**: private browsing, forced extensions, installed web apps, default search engine, sidebar.
- **New Tab and Home Page**: new tab page, home page, shortcuts, background image, administrator messages.
- **Routing**, **Upgrade Management**, **Custom Preferences**: PAC file, update channel, advanced Chromium policies.

Each control is a card: **+ Set value...**, choose the value, then **Set**. Common controls:

| Control | Input |
|---|---|
| **Managed Shortcuts** | **Set shortcuts** > **Add shortcut**: **URL**, **Name**, **Pinned app**, then **Add**. Drag and drop to reorder. |
| **Extension Force Install** | **Add extension**: **Extension ID**, **Store** (**Chrome Web Store**), **Pin to toolbar**, then **Add**. |
| **Background image** | **Set Background image**, drop the image, **Set new tab page mode** (**Light mode** or dark), **Invert logo color**. |
| **Company Logo** | **Set company logo**, drop the logo, check the preview. |
| **Company Name** | **Set name**, type the name. |
| **Brand Color** | **Custom color**, type the hex value. It colors the dialogs and the block pages. |
| **Onboarding Wizard** | **Enable** or **Disable**. |

For any other control, read its card in the console and show its values in the rule card.

## Known pitfalls

### Files to prepare

Ask the user for the local path of each file before input. The agent drops it with the file upload tool of the browser MCP server.

- Background image: PNG or JPEG, 2560 × 1440 pixels, 3 MB max.
- Logo: transparent PNG or SVG, 600 pixels wide, 1 MB max.
- The background image carries no logo: **Company Logo** already shows it on the new tab page.
- To change an image already set, use **Replace** on the card and keep the other settings.

### Shortcuts and extensions

- Pin only the most used shortcuts (**Pinned app**). The others stay in the company bookmarks folder.
- After **Add extension**, the console shows the extension name. Check it against the card: a wrong ID shows another name or none.

### Company password manager

A forced extension does not stop the built-in password manager. To keep passwords in the company manager, also disable **Password Manager** in a Browser Security rule for the same users.

### Onboarding wizard

Disable **Onboarding Wizard** for prepared devices, test accounts and automation scripts: the wizard blocks the first launch.

### Console input

- Open **Configuration** > **Policy** > **Rules**, then the **Browser Customization** tab. A direct URL to the tab can fail: go through the Rules page.
- Text fields (name, description, shortcut name) need real keystrokes. A value set by script is ignored.

## Steps

1. **Rule card**, shown to the user and validated: name, rule section, scope (users and groups), and each control with its value. List every shortcut (name, URL, pinned or not), every extension (ID and expected name), and the path of each file.
2. **Section**: if the section does not exist, **Create** > **New section**, type the name, click the check mark. It goes above the baseline.
3. **Input**: **Create new rule** on the section row. Fill **Name**, **Description**, then **Scope** > **Users/User groups**. Set each control of the card in **Browser Customization controls**. Take a screenshot at the end: the **Browser customization controls** column summarizes the rule.
4. **Save**: the user reviews and clicks **Save**.
5. **Publish**: propose a version description (300 characters max), for example `feat(prod): add rule prod-managed_shortcuts`. The user clicks **Publish**.
6. **Test**: Prisma Browser receives a published version after a few minutes. On a test device of a targeted user, open a new tab and check the logo, the background, the pinned shortcuts, the company bookmarks folder and the extension pinned in the toolbar. On a device of a user outside the scope, check that nothing changed.
