# CyberSeren Skills

Skills d'agent IA par [CyberSeren](https://cyberseren.com).

## Fonctionnement

CyberSeren publie des skills d'agent IA pour les produits de sécurité que nous mettons en place chez nos clients et pour Serenity, notre dashboard. Chaque éditeur a son plugin, et chaque produit de l'éditeur a son plugin à l'intérieur. Vous installez tout un éditeur, un seul produit ou un seul skill.

Aujourd'hui, CyberSeren est partenaire officiel de Palo Alto Networks. Les premiers skills couvrent donc les produits Palo Alto Networks. Des skills pour Serenity suivront.

## Plugins

| Plugin | Contenu |
|--------|---------|
| `palo-alto` | Bundle : installe tous les plugins Palo Alto Networks ci-dessous |
| `prisma-browser` | Prisma Browser : créer des règles Access & Data Control dans Strata Cloud Manager |
| `serenity` | À venir : skills pour Serenity, le dashboard CyberSeren |

## Installation

### Claude Code

    /plugin marketplace add cyberseren/cyberseren-skills
    /plugin install palo-alto@cyberseren        # tous les skills Palo Alto Networks
    /plugin install prisma-browser@cyberseren   # skills Prisma Browser seulement

### Tout agent, un seul skill

    npx skills add cyberseren/cyberseren-skills --skill prisma-browser-access-data-control-rule

Choisissez une seule méthode d'installation par agent : avec les deux, chaque skill apparaît deux fois.

## Utilisez un modèle local ou interne

Ces skills lisent et modifient votre configuration de sécurité. Utilisez-les avec un modèle hébergé en local ou dans votre entreprise, pour que vos données de production restent dans votre entreprise.

## Avertissement

Produit non officiel de Palo Alto Networks. Palo Alto Networks, Prisma et Cortex sont des marques de Palo Alto Networks, Inc. Relisez chaque changement avant de le publier.

## Licence

Apache-2.0
