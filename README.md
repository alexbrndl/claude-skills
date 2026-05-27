# claude-skills

Collection de **skills Claude Code** partagés par l'équipe design. Chaque skill est un guide réutilisable que Claude charge automatiquement quand la situation s'y prête.

Le repo est packagé comme une **marketplace de plugins** : l'équipe l'installe en une commande et reçoit tous les skills, avec mises à jour via git. Une méthode d'installation manuelle (sans plugin) est aussi documentée plus bas.

## Skills disponibles

| Skill | À quoi il sert |
|-------|----------------|
| `orchestrating-parallel-design-agents` | Lancer plusieurs agents en parallèle pour explorer des directions de design dans un même fichier partagé (Paper, Figma) sans collision et en gardant les sorties cohérentes. |

## Installation

### Méthode recommandée — via plugin (une commande)

Dans Claude Code :

```
/plugin marketplace add alexbrndl/claude-skills
/plugin install design-skills@alexbrndl-skills
```

Puis recharger :

```
/reload-plugins
```

Les skills du plugin sont alors disponibles, *namespacés* sous le nom du plugin, par exemple :

```
/design-skills:orchestrating-parallel-design-agents
```

Claude les invoque aussi automatiquement quand le contexte correspond à leur description.

> Prérequis : Claude Code **v2.1.145+** (support des skills dans les plugins).

### Mettre à jour

```
/plugin marketplace update alexbrndl-skills
```

### Méthode simple — sans plugin (copie ou symlink)

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

1. Crée le dossier : `plugins/design-skills/skills/<nom-du-skill>/SKILL.md`
   (nom en kebab-case, verbe d'action de préférence, ex. `<gerund>-<objet>`).
2. Le `SKILL.md` commence par un frontmatter YAML :

   ```yaml
   ---
   name: nom-du-skill
   description: Use when [conditions de déclenchement et symptômes — PAS le déroulé du skill]
   ---

   # Nom du skill
   ...
   ```

   La `description` décrit **quand** utiliser le skill (Claude s'en sert pour le déclencher automatiquement), jamais le workflow lui-même.
3. Commit + push. Les utilisateurs récupèrent le skill via `/plugin marketplace update alexbrndl-skills` (méthode plugin) ou un `git pull` (méthode manuelle).

Pas besoin de modifier `marketplace.json` ni `plugin.json` pour un nouveau skill : tout `SKILL.md` placé dans `plugins/design-skills/skills/` est automatiquement inclus dans le plugin `design-skills`. (Crée un nouveau plugin uniquement si tu veux un regroupement séparé.)

## Structure du repo

```
claude-skills/
├── .claude-plugin/
│   └── marketplace.json                 # Catalogue de la marketplace
├── plugins/
│   └── design-skills/
│       ├── .claude-plugin/
│       │   └── plugin.json              # Métadonnées du plugin
│       └── skills/
│           └── orchestrating-parallel-design-agents/
│               └── SKILL.md
└── README.md
```

## Références

- Skills : https://code.claude.com/docs/en/skills
- Plugins : https://code.claude.com/docs/en/plugins
- Marketplaces : https://code.claude.com/docs/en/plugin-marketplaces
