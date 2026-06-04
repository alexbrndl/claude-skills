# claude-skills

Collection de **skills Claude Code** partagés par l'équipe. Chaque skill est un guide réutilisable que Claude charge automatiquement quand la situation s'y prête.

Le repo est packagé comme une **marketplace de plugins** : on l'installe en une commande et on reçoit les skills voulus, avec mises à jour via git. Une méthode d'installation manuelle (sans plugin) est aussi documentée plus bas.

Les skills sont adaptés de projets open source, voir [CREDITS.md](CREDITS.md).

## Skills disponibles

Le repo contient 4 plugins indépendants, soit **64 skills** au total. Installez uniquement ce dont vous avez besoin.

---

### design-skills (5 skills)

Skills pour la direction artistique, la revue de design, le motion et la coordination d'agents de design en parallèle.

| Skill | À quoi il sert |
|-------|----------------|
| `brand-illustrations` | Générer une série d'illustrations visuellement cohérentes ou définir un style DNA réutilisable pour un produit. |
| `design-direction` | Choisir la direction visuelle d'un écran, site ou composant avant de coder ou travailler sur canvas. |
| `design-review` | Critiquer une UI existante (code, screenshot, page live) pour qualité visuelle, accessibilité et polish. |
| `motion` | Ajouter, revoir ou déboguer des animations et transitions (CSS, Vue Transition, GSAP, scroll-driven). |
| `orchestrating-parallel-design-agents` | Lancer plusieurs agents en parallèle pour explorer des directions de design dans un fichier partagé (Paper, Figma) sans collision. |

---

### marketing-skills (43 skills)

Skills couvrant l'ensemble du funnel marketing : acquisition, activation, rétention, copywriting, SEO, emails, publicité et plus.

| Skill | À quoi il sert |
|-------|----------------|
| `ab-testing` | Planifier et concevoir des A/B tests ou un programme d'expérimentation growth. |
| `ad-creative` | Générer et itérer du copy publicitaire (headlines, descriptions, variations) pour toutes les plateformes. |
| `ads` | Stratégie et optimisation de campagnes payantes (Google, Meta, LinkedIn, Twitter/X). |
| `ai-seo` | Optimiser le contenu pour les moteurs de recherche IA (AI Overviews, Perplexity, citations LLM). |
| `analytics` | Mettre en place ou auditer le tracking et la mesure marketing (GA4, GTM, Mixpanel, Segment). |
| `aso` | Auditer et optimiser une fiche App Store ou Google Play. |
| `churn-prevention` | Réduire le churn : flows d'annulation, save offers, dunning, win-back. |
| `co-marketing` | Trouver des partenaires co-marketing et planifier des campagnes conjointes. |
| `cold-email` | Rédiger des emails de prospection outbound et des séquences de cold outreach. |
| `community-marketing` | Créer une stratégie de communauté (Discord, Slack, forum) et activer la croissance community-led. |
| `competitor-profiling` | Rechercher et profiler des concurrents à partir de leurs URLs. |
| `competitors` | Créer des pages comparatives et alternatives pour le SEO et les ventes. |
| `content-strategy` | Planifier une stratégie de contenu : piliers, clusters, calendrier éditorial. |
| `copy-editing` | Editer, améliorer ou rafraîchir du copy marketing existant. |
| `copywriting` | Rédiger ou réécrire du copy marketing pour toute page (homepage, landing, pricing, features). |
| `cro` | Optimiser les conversions sur des pages et formulaires marketing. |
| `customer-research` | Conduire ou synthétiser de la recherche client (interviews, transcripts, review mining, JTBD). |
| `directory-submissions` | Soumettre un produit aux répertoires SaaS, AI, startup pour des backlinks et de la visibilité. |
| `emails` | Créer des séquences email automatisées (onboarding, nurture, re-engagement). |
| `free-tools` | Planifier et évaluer un outil gratuit comme levier marketing (calculateur, générateur, audit tool). |
| `image` | Créer, générer ou optimiser des images marketing (hero, social, mockup, OG image). |
| `launch` | Planifier le lancement d'un produit ou d'une feature (checklist, GTM, Product Hunt). |
| `lead-magnets` | Créer et distribuer des lead magnets pour la capture d'emails (ebook, template, checklist). |
| `marketing-ideas` | Générer des idées et stratégies marketing pour un produit SaaS. |
| `marketing-plan` | Produire un plan marketing exhaustif structuré par AARRR pour un client ou produit. |
| `marketing-psychology` | Appliquer les principes de psychologie et de behavioral science au marketing. |
| `onboarding` | Optimiser l'onboarding post-signup, l'activation utilisateur et le time-to-value. |
| `paywalls` | Créer ou optimiser des paywalls et écrans d'upgrade in-app. |
| `popups` | Créer ou optimiser des popups, modals et banners de conversion. |
| `pricing` | Stratégie de pricing, packaging et monétisation. |
| `product-marketing` | Créer un document de contexte produit-marketing (positioning, ICP, audience). |
| `programmatic-seo` | Créer des pages SEO à grande échelle via templates et données. |
| `prospecting` | Trouver et qualifier des listes de prospects (B2B SaaS, B2B, PME locales). |
| `referrals` | Créer ou optimiser un programme de referral, d'affiliation ou de bouche-à-oreille. |
| `revops` | Revops : lead scoring, routing, pipeline, handoff marketing-ventes. |
| `sales-enablement` | Créer des supports de vente (deck, one-pager, objection handling, script de démo). |
| `schema` | Ajouter ou corriger du schema markup et des données structurées (JSON-LD, rich snippets). |
| `seo-audit` | Auditer et diagnostiquer les problèmes SEO d'un site. |
| `signup` | Optimiser les flows d'inscription et de création de compte. |
| `site-architecture` | Planifier ou restructurer l'arborescence, la navigation et le maillage interne d'un site. |
| `sms` | Planifier et construire des campagnes et séquences SMS/MMS marketing. |
| `social` | Créer et optimiser du contenu pour les réseaux sociaux (LinkedIn, Twitter/X, Instagram, TikTok). |
| `video` | Créer ou produire des vidéos avec des outils IA (Remotion, HeyGen, Runway, Veo, etc.). |

---

### writing-skills (1 skill)

| Skill | À quoi il sert |
|-------|----------------|
| `prose` | Rédiger ou éditer de la prose en français ou anglais pour supprimer les tournures IA et resserrer le texte. |

---

### ai-engineering-skills (15 skills)

Skills pour concevoir des systèmes à base de LLM : context engineering, multi-agent, évaluation, mémoire et infrastructure d'agents.

| Skill | À quoi il sert |
|-------|----------------|
| `advanced-evaluation` | Systèmes d'évaluation LLM-as-judge : scoring, comparaison par paires, calibration de rubriques. |
| `bdi-mental-states` | Modéliser les états mentaux d'agents avec les concepts BDI (beliefs, desires, intentions). |
| `context-compression` | Compression et summarisation de contexte pour les sessions longues et les handoffs entre agents. |
| `context-degradation` | Diagnostiquer et corriger les défaillances de contexte (lost-in-middle, context poisoning, attention failures). |
| `context-fundamentals` | Concepts fondamentaux du context engineering : anatomie d'une context window, mécanique de l'attention. |
| `context-optimization` | Optimiser l'efficacité du contexte : budgeting, KV-cache, retrieval scoping, réduction des tokens. |
| `evaluation` | Construire des systèmes d'évaluation d'agents : checks déterministes, suites de régression, monitoring. |
| `filesystem-context` | Contexte stocké sur fichier : scratchpads durables, offloading d'outputs, handoff cross-agents. |
| `harness-engineering` | Concevoir des harnesses d'agents autonomes : research loops, surfaces verrouillées, rollback, approbation humaine. |
| `hosted-agents` | Infrastructure d'agents hébergés : exécution sandboxée, session persistence, agents auto-spawning. |
| `latent-briefing` | Partager de la mémoire entre agents via KV cache et latent briefing pour réduire les tokens workers. |
| `memory-systems` | Mémoire sémantique persistante pour agents : rétention cross-session, entity tracking, graph/vector retrieval. |
| `multi-agent-patterns` | Concevoir des systèmes multi-agents : isolation de contexte, coordination supervisor/swarm, handoffs. |
| `project-development` | Décisions de niveau projet sur les systèmes LLM : pipeline multi-étapes, coûts tokens, structured output. |
| `tool-design` | Couche interface des outils d'agents : tool descriptions, schemas, formats de réponse, MCP server design. |

---

## Installation

### Méthode recommandée : via plugin (une commande)

Les 4 plugins sont **indépendants** : installez uniquement ceux dont vous avez besoin.

Dans Claude Code, ajoutez d'abord la marketplace :

```
/plugin marketplace add alexbrndl/claude-skills
```

Puis installez le ou les plugins voulus :

```
/plugin install design-skills@alexbrndl-skills
/plugin install marketing-skills@alexbrndl-skills
/plugin install writing-skills@alexbrndl-skills
/plugin install ai-engineering-skills@alexbrndl-skills
```

Puis rechargez :

```
/reload-plugins
```

Les skills sont alors disponibles, *namespacés* sous le nom du plugin, par exemple :

```
/design-skills:orchestrating-parallel-design-agents
/marketing-skills:copywriting
/ai-engineering-skills:multi-agent-patterns
```

Claude les invoque aussi automatiquement quand le contexte correspond à leur description.

> Prérequis : Claude Code **v2.1.145+** (support des skills dans les plugins).

### Mettre à jour

```
/plugin marketplace update alexbrndl-skills
```

### Méthode simple : sans plugin (copie ou symlink)

Pour installer un seul skill sans passer par le système de plugins, copiez son dossier dans `~/.claude/skills/` :

```bash
# Cloner le repo une fois
git clone https://github.com/alexbrndl/claude-skills.git

# Copier un skill dans ses skills personnels
cp -r claude-skills/plugins/design-skills/skills/orchestrating-parallel-design-agents \
      ~/.claude/skills/orchestrating-parallel-design-agents
```

Ou en **symlink** (le skill reste synchronisé avec le repo quand vous `git pull`) :

```bash
ln -s "$(pwd)/claude-skills/plugins/design-skills/skills/orchestrating-parallel-design-agents" \
      ~/.claude/skills/orchestrating-parallel-design-agents
```

Claude Code détecte les ajouts dans `~/.claude/skills/` sans redémarrage. **Exception** : si le dossier `~/.claude/skills/` n'existait pas encore au lancement, redémarrez Claude Code après l'avoir créé.

## Ajouter un nouveau skill

1. Crée le dossier : `plugins/<nom-du-plugin>/skills/<nom-du-skill>/SKILL.md`
   (nom en kebab-case, verbe d'action de préférence, ex. `<gerund>-<objet>`).
2. Le `SKILL.md` commence par un frontmatter YAML :

   ```yaml
   ---
   name: nom-du-skill
   description: Use when [conditions de déclenchement et symptômes, PAS le déroulé du skill]
   ---

   # Nom du skill
   ...
   ```

   La `description` décrit **quand** utiliser le skill (Claude s'en sert pour le déclencher automatiquement), jamais le workflow lui-même.
3. Commit + push. Les utilisateurs récupèrent le skill via `/plugin marketplace update alexbrndl-skills` (méthode plugin) ou un `git pull` (méthode manuelle).

Pas besoin de modifier `marketplace.json` ni `plugin.json` pour un nouveau skill : tout `SKILL.md` placé dans `plugins/<plugin>/skills/` est automatiquement inclus dans le plugin correspondant. (Crée un nouveau plugin uniquement si tu veux un regroupement séparé.)

## Structure du repo

```
claude-skills/
├── .claude-plugin/
│   └── marketplace.json                 # Catalogue de la marketplace
├── plugins/
│   ├── design-skills/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   └── skills/
│   │       ├── brand-illustrations/
│   │       ├── design-direction/
│   │       ├── ...                      # 5 skills au total
│   │       └── orchestrating-parallel-design-agents/
│   ├── marketing-skills/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   └── skills/
│   │       ├── ab-testing/
│   │       ├── copywriting/
│   │       └── ...                      # 43 skills au total
│   ├── writing-skills/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   └── skills/
│   │       └── prose/                   # 1 skill
│   └── ai-engineering-skills/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       └── skills/
│           ├── context-fundamentals/
│           ├── multi-agent-patterns/
│           └── ...                      # 15 skills au total
├── CREDITS.md
└── README.md
```

## Références

- Skills : https://code.claude.com/docs/en/skills
- Plugins : https://code.claude.com/docs/en/plugins
- Marketplaces : https://code.claude.com/docs/en/plugin-marketplaces
