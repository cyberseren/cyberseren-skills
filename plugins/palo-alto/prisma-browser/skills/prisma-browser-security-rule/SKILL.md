---
name: prisma-browser-security-rule
description: Creates, clones or edits a Prisma Browser Browser Security rule in Strata Cloud Manager with the user. The user validates a rule card first, the agent fills the console through a browser MCP server, the user saves and publishes. Use when the user asks to harden Prisma Browser for a group of users, for example browser lock, session duration, password manager, developer tools, extensions or network protection.
license: Apache-2.0
compatibility: Requires a browser MCP server (for example Chrome DevTools MCP), a model with tool calling, and a Strata Cloud Manager account with rights on Prisma Browser policies.
metadata:
  author: cyberseren
  version: "0.1.0"
---

# Prisma Browser Browser Security rule

Scope: Browser Security rules only. They decide what the browser itself allows. Access & Data Control and Browser Customization rules are out of scope.

## Absolute rules

- The user validates the rule card before any input in the console.
- The agent fills the form fields. The user clicks **Save** and **Publish**.
- The agent never types credentials. If the console asks for a login, the user logs in.
- Before each keystroke, check the page URL and the active field.

## Naming

Ask the user for their naming convention. Default proposal:

- Rule: `<scope>-<object>`, lowercase, words separated by `_`: `prod-browser_security`, `test-allow_automation`.
- Rule section: one per usage, for example `prod-rules` and `test-rules`. A rule goes in the section of its usage.

## How rules apply

- Prisma Browser reads rules from top to bottom. The first rule whose scope matches the user applies.
- The last rule, **Browser Security - baseline**, applies to every user that no other rule targets.
- A rule for one population goes in a section above the baseline.
- Put all the controls of one population in one rule. A second rule for the same users never matches.
- A control the rule does not set stays at **Not set**.

## Controls

The console groups the controls in families, in this order: **Browser Session**, **Browser Hardening**, **Passwords and Autofill**, **Network Protection**, **Extensions**, **Privacy**, **Protected Browsing (Attack surface reduction)**, **Printers**, **Internet Explorer Compatibility Mode**.

Each control is a card: **+ Set value...**, choose the value, then **Set**. Common controls:

| Family | Control | Values |
|---|---|---|
| Browser Session | **Browser lock** | **Enable**, **Lock when idle for** (for example `15 minutes`) |
| Browser Session | **Session Refresh** | **Enable**, **Log the user out every** (for example `12 hours`), **When the browser is closed** |
| Browser Hardening | **Authentication factor** | **IdP Authentication** (**Prisma Browser authentication profile**), **PIN code**, **Passkey** |
| Browser Hardening | **Developer Tools**, **Remote Debugging** | **Allow**, **Block** |
| Passwords and Autofill | **Password Manager** | **Enable** with **Multi-factor authentication** and **Require MFA again after**, or **Disable** with **Disable export** |
| Passwords and Autofill | **Mobile Password Saving** | **Allow**, **Block** |

For any other control, read its card in the console and show its values in the rule card.

## Known pitfalls

### Unlock method

**Browser lock** asks the user to authenticate. The method is a separate control, **Authentication factor**, lower in the list. Set both in the same rule.

### Company password manager

To keep passwords in the company password manager:

1. **Password Manager** > **Disable**. Leave **Disable export** unchecked: each user can export saved passwords as CSV, then import them into the company manager.
2. **Mobile Password Saving** > **Block**.
3. Install the company password manager extension with a Browser Customization rule (**Extension Force Install**).

### Test automation

Playwright and Selenium drive the browser through remote debugging. When the rule blocks it, the tool fails with `DevTools remote debugging is disallowed by the system admin`.

- Allow **Remote Debugging** and **Developer Tools** in a rule that targets only the test accounts, never employees.
- The token comes from **System Settings** > **Integrations** > **WebDriver Automation** > **Generate Token**, for a local user of the Cloud Identity Engine.
- The test device sets `PRISMA_BROWSER_AUTOMATION_TOKEN` before the tool starts the browser. The token is about 1600 characters: store it in a file, not on a terminal line.

### Console input

- Open **Configuration** > **Policy** > **Rules**, then the **Browser Security** tab. A direct URL to the tab can fail: go through the Rules page.
- Text fields (name, description) need real keystrokes. A value set by script is ignored.

## Steps

1. **Rule card**, shown to the user and validated: name, rule section, scope (users and groups), and each control with its value, grouped by family.
2. **Section**: if the section does not exist, **Create** > **New section**, type the name, click the check mark. It goes above the baseline.
3. **Input**: **Create new rule** on the section row. Fill **Name**, **Description**, then **Scope** > **Users/User groups**. Set each control of the card in **Browser Security controls**. Take a screenshot at the end: the **Browser security controls** column summarizes the rule.
4. **Save**: the user reviews and clicks **Save**.
5. **Publish**: propose a version description (300 characters max), for example `feat(prod): add rule prod-browser_security`. The user clicks **Publish**.
6. **Test**: Prisma Browser receives a published version after a few minutes. On a test device of a targeted user:
   - check the effect on screen, for example the lock screen after the idle time, or **Password Manager disabled by policy** in the password manager;
   - open `chrome://policy` and check that the rule's values are there, and that a value set only by the baseline is still there;
   - on a device of a user outside the scope, check that nothing changed.
