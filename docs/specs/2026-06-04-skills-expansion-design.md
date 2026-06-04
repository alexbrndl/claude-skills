# Spec : extension de claude-skills (63 nouveaux skills, 4 plugins)

Date : 2026-06-04
Statut : validé en brainstorming, en attente de plan d'implémentation

## 1. Objectif

Étendre la marketplace `alexbrndl-skills` avec 63 skills construits à partir du contenu de 8 repos open source analysés en intégralité le 2026-06-04. Trois natures de skills :

- **5 skills composés** (nouveaux, fusion de plusieurs sources) : `design-review`, `design-direction`, `motion`, `brand-illustrations`, `prose`
- **43 skills importés-optimisés** depuis `coreyhaines31/marketingskills`
- **15 skills importés-optimisés** depuis `muratcankoylan/Agent-Skills-for-Context-Engineering`

## 2. Sources et licences

| Repo | Licence | Usage |
|---|---|---|
| coreyhaines31/marketingskills | MIT | Import 1:1 optimisé (43 skills) |
| muratcankoylan/Agent-Skills-for-Context-Engineering | MIT | Import 1:1 optimisé (15 skills) + standards de construction |
| pbakaus/impeccable | Apache 2.0 | Extraits pour design-review et design-direction |
| Leonxlnx/taste-skill | MIT | Extraits pour design-review, design-direction, motion + prompts anti-troncature |
| alchaincyf/huashu-design | MIT | Extraits pour design-review, design-direction, motion, brand-illustrations |
| nextlevelbuilder/ui-ux-pro-max-skill | MIT | Données CSV pour design-direction et design-review |
| hardikpandya/stop-slop | MIT | Base de prose |
| helloianneo/ian-xiaohei-illustrations | MIT | Méthode pour brand-illustrations |

Obligation : créer `CREDITS.md` à la racine listant les 8 sources avec liens, auteurs et licences. Apache 2.0 (impeccable) impose de conserver l'attribution.

Les clones d'analyse sont dans `/tmp/skills-analysis/` (éphémère). Si absents au moment de l'implémentation, re-cloner avec `git clone --depth 1 https://github.com/<owner>/<repo>`.

## 3. Architecture cible

```
claude-skills/
├── .claude-plugin/marketplace.json        # 4 plugins (+3 nouveaux)
├── CREDITS.md                             # attribution des 8 sources
├── README.md                              # mis à jour (4 plugins, tableau des skills)
├── docs/specs/                            # ce document
└── plugins/
    ├── design-skills/                     # existant, 1 → 5 skills
    │   └── skills/
    │       ├── orchestrating-parallel-design-agents/   # inchangé
    │       ├── design-review/
    │       ├── design-direction/
    │       ├── motion/
    │       └── brand-illustrations/
    ├── marketing-skills/                  # nouveau, 43 skills
    ├── writing-skills/                    # nouveau, 1 skill (prose)
    └── ai-engineering-skills/             # nouveau, 15 skills
```

Chaque nouveau plugin reçoit son `.claude-plugin/plugin.json` (name, description, version 0.1.0, author), et une entrée dans `marketplace.json`.

## 4. Standards de construction (appliqués aux 63 skills)

Issus des patterns observés dans context-engineering, marketingskills et impeccable :

1. **SKILL.md concis**, en anglais, frontmatter `name` + `description`. La description décrit uniquement quand déclencher le skill, jamais son déroulé (convention existante du repo). Longueur : viser 150-200 lignes pour les skills composés ; limite dure à 500 lignes (recommandation officielle Claude Code) pour les imports. Au-dessus, déporter en `references/` en déplaçant, jamais en supprimant. Critère réel : tout ce qui reste dans le SKILL.md doit servir à chaque activation.
2. **Progressive disclosure** : le contenu lourd (checklists complètes, CSV, scripts, templates) vit dans `references/` et n'est chargé qu'à la demande. Le SKILL.md indique quand charger quoi.
3. **Routing explicite** : chaque skill d'un même domaine déclare quand NE PAS s'activer et vers quel skill voisin router (ex : design-review ↔ design-direction ↔ motion).
4. **Pas d'auto-promo** : retirer tout lien `?ref=`, watermark ou cross-promotion présent dans les sources.
5. **Scripts annexes** dans `scripts/` du skill concerné, jamais inline dans le SKILL.md.

## 5. Plugin design-skills : 4 nouveaux skills composés

### 5.1 design-review

Critique d'une UI existante (code, screenshot, ou les deux).

- **SKILL.md** : workflow en 2 assessments indépendants (revue LLM + checklist déterministe) puis synthèse avec sévérité P0-P3 (pattern impeccable `critique.md`). Test final "second-order slop" : vérifier qu'on n'est pas tombé dans le contre-cliché évident. Mention de `npx impeccable detect` comme outil déterministe externe optionnel.
- **references/ai-tells.md** : checklist AI-tells de taste-skill (`skills/taste-skill/SKILL.md` §4 et §9.F : palette beige+brass avec hex bannis, gradients AI-purple, eyebrows numérotés, faux screenshots en div, dots décoratifs, strips locale/météo, scroll cues, marquee max 1/page, zigzag max 2) + "Absolute bans" d'impeccable (`skill/SKILL.src.md`) + règle eyebrow ≤ ceil(sections/3).
- **references/thresholds.md** : seuils chiffrés d'impeccable (contraste WCAG, line-length 65-75ch, ratio typo ≥ 1.25, hero clamp ≤ 6rem, tracking floor -0.04em, z-index sémantique).
- **references/antipatterns.md** : taxonomie des ~36 anti-patterns (`cli/engine/registry/antipatterns.mjs`) reformatée en checklist.
- **references/scoring.md** : grille de critique 5 dimensions de huashu (`references/critique-guide.md`) + sélection des règles UX pertinentes de ui-ux-pro-max (`ux-guidelines.csv`).
- **Routing** : "pas pour démarrer un design → design-direction ; pas pour des questions d'animation → motion".

### 5.2 design-direction

Démarrer un design avec une direction forte au lieu du générique IA.

- **SKILL.md** : Brief Inference (déclarer la lecture du brief en 1 ligne avant de coder, taste §0), dials DESIGN_VARIANCE / MOTION_INTENSITY / VISUAL_DENSITY (taste §1), protocole core assets 5-10-2-8 de huashu (récupérer logo/produit/screenshots réels avant de dessiner : 5 recherches, 10 candidats, garder 2, note ≥ 8/10).
- **references/philosophies.md** : 20 philosophies de design de huashu (`references/design-styles.md` : Pentagram, Müller-Brockmann, Kenya Hara, Field.io, Sagmeister...) avec prompt DNA et mots-clés.
- **references/fonts.md** : procédure de sélection de fonts en 4 étapes + reflex-reject lists (polices et lanes esthétiques saturées) d'impeccable (`skill/reference/brand.md` l.18-42).
- **references/palettes.csv** : les 160 palettes en tokens sémantiques de ui-ux-pro-max (`src/ui-ux-pro-max/data/colors.csv`), nettoyées.
- **references/styles.csv** : les 84 recettes CSS de styles UI (`data/styles.csv`), nettoyées.
- **Routing** : "pas pour critiquer un design existant → design-review".

### 5.3 motion

Animer proprement (web, Vue Transition, GSAP, scroll).

- **SKILL.md** : règles socles : animer uniquement transform/opacity, respecter prefers-reduced-motion, IntersectionObserver ou `animation-timeline: view()` plutôt que listener scroll, principe "pure render/seekable" (l'état visuel = fonction du temps).
- **references/pitfalls.md** : les 14 pitfalls d'animation de huashu (`references/animation-pitfalls.md`).
- **references/scroll-patterns.md** : squelettes GSAP ScrollTrigger de taste (§5.A/B, avec cleanup `gsap.context().revert()`) + équivalents Vue et CSS natifs.
- **scripts/render-video.js** : export d'une animation HTML en MP4 propre via Playwright + ffmpeg (huashu, adapté : retirer le watermark). Référencé en fin de SKILL.md comme outil optionnel d'export de démos.
- **Routing** : "pas pour choisir une direction visuelle → design-direction".

### 5.4 brand-illustrations

Générer des séries d'illustrations cohérentes (méthode xiaohei, adaptée en anglais).

- **SKILL.md** : workflow 5 étapes (digérer le contenu → shot list → génération une image à la fois → QA → sauvegarde), test "retire l'élément central" (si la métaphore tient sans lui, il est décoratif), méthode de métaphore en 3 étapes (concept abstrait → action physique → objet low-tech), règle anti-copie des exemples, prompt d'édition chirurgical.
- **references/style-dna-template.md** : template de document de DA séparé (couleurs avec rôle sémantique fixe, contraintes mesurables, listes obligatoire/interdit).
- **references/prompt-template.md** : bloc fixe (Visual DNA + personnage/motif + contraintes) + slots variables {theme}, {structure}, {core idea}, {composition}.
- Intègre le protocole assets de marque de huashu (`brand-spec.md`) pour ancrer le style sur des assets réels.

## 6. Plugin writing-skills : prose

- **SKILL.md** : condensé de stop-slop en écartant les règles dogmatiques (zéro adverbe absolu, zéro tiret absolu, scoring 1-10). Garde : false agency (nommer l'humain), faux contrastes binaires (affirmer Y directement), déclaratifs vagues (montrer la chose précise), listing négatif, les 12 quick checks.
- **references/banned-patterns.md** : tables de phrases et structures bannies + table de remplacement du jargon.
- Règles applicables au FR comme à l'EN.

## 7. Plugin marketing-skills : import optimisé des 43 skills

Pipeline en 3 passes :

1. **Copie** : les 43 dossiers `skills/<nom>/` (SKILL.md + references/ + evals.json) depuis le clone marketingskills. Les `tools/integrations` et CLI ne sont PAS repris (hors périmètre, dépendances d'API).
2. **Optimisation par agents parallèles** (un lot de skills par agent) : retirer les liens `?ref=` et l'auto-promo ; vérifier la conformité aux standards §4 ; corriger les incohérences ; alléger les passages purement "grosse équipe sales B2B" sans supprimer de skill ; conserver les evals.json.
3. **Revue croisée** : un agent vérifie la cohérence du routing inter-skills, en particulier le skill socle `product-marketing` (qui crée `.agents/product-marketing.md` lu par les autres) et les sections "Related Skills".

## 8. Plugin ai-engineering-skills : import optimisé des 15 skills

Même pipeline en 3 passes que §7, depuis le clone Agent-Skills-for-Context-Engineering (`skills/`). Les 15 skills sont repris, y compris les 3 de niche (bdi-mental-states, latent-briefing, hosted-agents). Le "Researcher OS", les exemples et les benchmarks ne sont PAS repris.

Ajout : **references/anti-truncation.md** dans le skill `harness-engineering`, contenant les prompts anti-troncature de taste-skill (`research/laziness/remediation/reference-prompts.md`), seul élément repris du dossier research/ de taste.

## 9. Écarté volontairement

- Les 7 variants + 5 annexes restantes de taste-skill (répétitifs, plomberie), son dossier `research/` (données fabriquées, sauf prompts anti-troncature), ses 3 skills image-gen (1000-1500 lignes, usage marginal).
- Les 6 skills ClaudeKit embarqués dans ui-ux-pro-max (cross-promo), ses CSV morts et fonts TTF, son moteur BM25 (les agents lisent les CSV directement).
- Le détecteur CLI d'impeccable (~4500 lignes : on le référence via `npx impeccable detect` au lieu de le recréer).
- Le pipeline audio/TTS/PPTX de huashu (services chinois payants), son watermark.
- Le scoring 1-10 et les règles absolutistes de stop-slop.
- Le skill xiaohei tel quel (chinois, PNG raster) : seule la méthode est reprise.

## 10. Critères de réussite

- `marketplace.json` valide avec 4 plugins, installables via `/plugin install <plugin>@alexbrndl-skills`.
- 63 nouveaux SKILL.md avec frontmatter valide, description = déclencheur uniquement, aucun ne dépasse 500 lignes.
- Aucun lien d'auto-promo (`?ref=`, watermark) dans le contenu importé.
- `CREDITS.md` couvre les 8 sources.
- README à jour : tableau des skills par plugin, instructions d'installation par plugin.
- Routing explicite présent dans les 4 skills design et préservé dans les imports.

## 11. Phasage suggéré pour l'implémentation

1. **Phase A** : infrastructure (plugin.json × 3, marketplace.json, CREDITS.md, dossier docs/).
2. **Phase B** : les 5 skills composés (design × 4 + prose), écrits à la main avec extraction verbatim des sources.
3. **Phase C** : import marketing-skills (pipeline 3 passes, agents parallèles).
4. **Phase D** : import ai-engineering-skills (même pipeline) + anti-truncation.
5. **Phase E** : README, revue finale de cohérence, test d'installation locale.
