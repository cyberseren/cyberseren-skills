# prisma-browser

Skills for Prisma Browser in Strata Cloud Manager, by CyberSeren.

| Skill | What it does |
|-------|--------------|
| `prisma-browser-access-data-control-rule` | Creates, clones or edits an Access & Data Control rule. You validate the rule card first, the skill fills the console, you publish. |
| `prisma-browser-security-rule` | Creates, clones or edits a Browser Security rule: browser lock, session, password manager, developer tools. Same flow. |
| `prisma-browser-customization-rule` | Creates, clones or edits a Browser Customization rule: shortcuts, forced extensions, new tab page, branding. Same flow. |

Requirements: a browser MCP server (for example Chrome DevTools MCP) and an account on your Strata Cloud Manager tenant. The customization skill also uploads images: the MCP server needs a file upload tool.

Install: `/plugin install prisma-browser@cyberseren` in Claude Code. For other agents, see the main README.
