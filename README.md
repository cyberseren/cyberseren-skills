# CyberSeren Skills

Agent skills by [CyberSeren](https://cyberseren.com).

## How it works

CyberSeren publishes agent skills for the security products we deploy for our customers and for Serenity, our dashboard. Each vendor has its own plugin, and each of its products has a plugin inside it. You install a whole vendor, one product or one skill.

Today, CyberSeren is an official Palo Alto Networks partner, so the first skills cover Palo Alto Networks products. Skills for Serenity are coming next.

## Plugins

| Plugin | Contents |
|--------|----------|
| `palo-alto` | Bundle: installs every Palo Alto Networks plugin below |
| `prisma-browser` | Prisma Browser: create Access & Data Control rules in Strata Cloud Manager |
| `serenity` | Coming soon: skills for Serenity, the CyberSeren dashboard |

## Install

### Claude Code

    /plugin marketplace add cyberseren/cyberseren-skills
    /plugin install palo-alto@cyberseren        # all Palo Alto Networks skills
    /plugin install prisma-browser@cyberseren   # Prisma Browser skills only

### Any agent, one skill

    npx skills add cyberseren/cyberseren-skills --skill prisma-browser-access-data-control-rule

Pick one install method per agent: installing both gives you every skill twice.

## Use a local or internal model

These skills read and change your security configuration. Run them with a model hosted locally or inside your company, so your production data stays in your company.

## Disclaimer

Not an official Palo Alto Networks product. Palo Alto Networks, Prisma and Cortex are trademarks of Palo Alto Networks, Inc. Review every change before you publish it.

## License

Apache-2.0
