# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a LaTeX semester thesis (currently) and future master's thesis for TUM (Technical University of Munich), using the **AIRlatex** document class from the Chair of Robotics, Artificial Intelligence and Real-time Systems (I6/AIR). The thesis is written in English.

**Title:** Dexterous Manipulation of Unknown Objects & Fine Tool Use with Dual-Arm, Dual-Hand Robots

**Author:** Carsten Oertel
**Supervisor:** Prof. Knoll (I6/AIR chair)
**Advisor:** Zhang Chi, M.Sc.
**Industry Partner:** Agile Robots SE (industry supervisor: M.Sc. Antonio Gonzales Marin)
**Field of Study:** Mechanical Engineering
**Duration:** 12 months total — Semester Thesis (6 months, part-time) + Master's Thesis (6 months, full-time)

### Scope Deviation from Original Plan

The original expose/presentation planned a 3-phase pipeline (grasping -> finger-gaiting -> thread start). The actual semester thesis **narrowed focus to dexterous grasping** with a specific scientific contribution around **safer policy distillation**. Finger-gaiting and thread start are deferred to the master's thesis.

### What Was Actually Done (Semester Thesis)

The work follows and extends the **DextrAH-RGB** approach (Singh et al. 2025):

1. **Privileged Teacher Policy (RL):** Built a dexterous grasping agent in Isaac Lab using the direct environment API (`DirectRLEnv`, same paradigm as DextrAH-RGB). Integrated custom robot asset (Agile Hand on FR3 arm), wrote custom reward functions and environment modifications. Training works, grasping agent works.

2. **Student Policy Distillation:** The original DextrAH-RGB paper uses **DAgger** for distilling the privileged teacher into a vision-based student policy. This thesis replaces DAgger with **SafeDAgger** (Zhang & Cho 2016) / **DexSafeDagger** (Chi Zhang 2026, advisor's paper) and compares the two approaches.

**Key differences from DextrAH-RGB:**

- No Fabric-Guided Policies (FGPs) — the FGP setup had too many intricacies for the available time; standard RL policy is used instead
- Direct environment API (`DirectRLEnv`) in Isaac Lab (same paradigm as DextrAH-RGB)
- Custom asset integration (Agile Hand + FR3)
- Custom reward shaping
- SafeDAgger instead of DAgger for distillation (the scientific contribution)

### Scientific Contribution

Comparison of **DAgger vs. SafeDAgger** for distilling a privileged dexterous grasping policy into a vision-based student policy. The hypothesis is that SafeDAgger's query-efficient, safety-aware distillation produces comparable or better grasping performance with fewer unsafe episodes during training — critical for eventual real-world deployment of dexterous hands.

### Research Questions (Revised)

1. Can a privileged RL teacher policy for dexterous grasping be effectively trained in Isaac Lab with a custom dexterous hand asset?
2. Does SafeDAgger improve training safety (fewer unsafe episodes) compared to vanilla DAgger when distilling to a vision-based student policy?
3. What is the trade-off between safety and task performance (grasp success rate) when using SafeDAgger vs. DAgger?

### Hardware & Software Stack

- **Arm:** Franka Research 3 (FR3); alternative: Agile Robots Yu5
- **Hand:** Agile Hand (16 DoF, thumb rotation DoF) — "Tekken" is an internal codename, use "Agile Hand" in the thesis
- **Sensors:** RGB-D (Intel RealSense D405)
- **Simulation:** Isaac Lab (direct environment API, `DirectRLEnv`)
- **Learning:** PPO for teacher policy, DAgger/SafeDAgger for student distillation

### Key References (actual method basis)

- **DextrAH-RGB** (Singh et al. 2025) — Base approach: privileged teacher -> vision student for dexterous grasping
- **DextrAH-G** (Lum et al. 2024) — Depth-based variant with geometric fabrics
- **Geometric Fabrics** (Ratliff & Van Wyk 2023) — Controller architecture (referenced but not used due to complexity)
- **DAgger** (Ross et al. 2011) — Baseline distillation method
- **SafeDAgger** (Zhang & Cho 2016) — Query-efficient imitation learning
- **DexSafeDagger** (Chi Zhang 2026) — Advisor's extension: Q-value failure prediction for safer distillation
- **DeXtreme** (Handa et al. 2024) — Sim-to-real dexterous manipulation, ADR
- **IBORL** (Huang et al. 2025) — Imitation-bootstrapped online RL
- **DexGraspNet** (Wang et al. 2023) — Large-scale dexterous grasp dataset
- **DRL for Robotics Survey** (Tang et al. 2024) — Background survey

### Thesis Structure (Target ~40 pages)

- `chapter01.tex` — **Introduction** (WRITTEN): Motivation, problem statement, contributions, thesis outline. ~3 pages.
- `chapter02.tex` — **Related Work** (WRITTEN): Classical control, grasp planning, RL fundamentals, sim-to-real, IL/distillation (policy distillation concept, DAgger/SafeDAgger/DexSafeDagger), dexterous manipulation, simulation frameworks. ~6 pages.
- `chapter03.tex` — **Methods** (WRITTEN, mathematical): Purely abstract/mathematical chapter. POMDP formulation, privileged vs partial observability, asymmetric actor-critic, PPO objective, reward structure formalization, ADR formulation, DAgger algorithm (with L2 and KL loss variants), SafeDAgger with safety policy and intervention mechanism, DexSafeDagger Q-value risk, multi-teacher distillation. Contains Algorithm blocks for DAgger and SafeDAgger. No implementation details — those are in Chapter 4.
- `chapter04.tex` — **Experiments & Results** (MOSTLY WRITTEN, restructured per supervisor outline): Now organized as **4.1 Experimental Setup** (4.1.1 Teacher Policy Training [Sim Env, Hardware, Object Set, Episode Structure, Obs/Action Space, Reward, Network, Training Config, ADR, Sim-to-Real Curriculum design], 4.1.2 Student Policy Distillation, 4.1.3 Evaluation Metrics), **4.2 Ablation Studies**, **4.3 Results, Graphs and Tables** (4.3.1 Teacher Training Results, 4.3.2 Distillation Results), **4.4 Summary of Findings**. Contains all implementation details and concrete numbers: PhysX/actuator tables, 13 VisDex objects, teacher obs/action tables, reward terms, LSTM 1024 architecture, PPO hyperparams, ADR ranges, student ResNet-18 + cross-attention + LSTM 512, SafeDAgger config, GSR/UER metrics with physics_instability split. Results cover teachers 9/10/11 and distillation runs 1c–11b (best student: run 10b SafeDAgger 79.2% GSR). Key findings: teacher quality dominates distillation method, sim2real teacher produces safer students, SafeDAgger more robust under ADR. Remaining placeholders: some figures, GPU specs, wall-clock times.
- `chapter05.tex` — **Discussion & Conclusion** (PLACEHOLDER ONLY): Needs to be written.
- `abstract.tex` — Still contains placeholder blind text.

### Current State

- Chapters 1-2 are **fully written** with proper citations.
- Chapter 3 is **fully written** as a mathematical/abstract methods chapter (POMDP, PPO, DAgger, SafeDAgger, DexSafeDagger). Uses `algorithm`/`algpseudocode` for algorithm blocks.
- Chapter 4 is **mostly written** and was restructured per supervisor outline (4.1 Experimental Setup → 4.2 Ablations → 4.3 Results → 4.4 Summary; see chapter list above). Concrete data from experiment logs exp_02–exp_06 plus run 9–11 distillation experiments. Best student: run 10b (SafeDAgger, 32 envs, 79.2% GSR, 92% of teacher 11 ceiling). Key findings: teacher quality dominates distillation method, sim2real teacher produces safer students, SafeDAgger degrades less than DAgger under ADR-5 distillation. Remaining placeholders: some figures, GPU model/wall-clock times.
- Chapter 5 is a **bare placeholder**.
- The `abstract.tex` still contains placeholder blind text.
- Bibliography (`literature.bib`) contains ~31 entries (including Hinton2015 for policy distillation), all `abstract`/`note` fields stripped (they caused biber/pdflatex crashes).
- `literature1.bib` is **no longer used** (commented out in main.tex); all references are in `literature.bib`.
- Front matter includes: Table of Contents, List of Figures, List of Tables, List of Abbreviations (using `acronym` package with POMDP added).
- `.gitignore` is configured to exclude LaTeX build artifacts but keep PDFs.
- `main.tex` uses `algpseudocode` (not `algorithmicx`) for algorithm pseudocode in Chapter 3.

## Build Commands

Build the PDF from the `Report/` directory:

```bash
cd Report
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

The triple `pdflatex` pass is needed to resolve cross-references and bibliography citations. `biber` (not `bibtex`) is the bibliography backend (`optBiber` class option).

**Important:** If biber fails or references show `[0]`, delete all cached files and rebuild:

```bash
cd Report
rm -f main.aux main.bbl main.bcf main.blg main.log main.out main.run.xml main.toc main.lof main.lot main.synctex.gz source/*.aux
```

### Known Build Fixes Applied in `main.tex` Preamble

- `\ExecuteBibliographyOptions{defernumbers=false}` — Fixes `[0]` citation numbers (class sets `defernumbers=true` for biber, which conflicts with `sorting=none`)
- `\ExecuteBibliographyOptions{sorting=none}` — Forces citation-order sorting (class has conflicting `sorting=nyt` and `sorting=none` settings)
- `\usepackage[printonlyused]{acronym}` — Abbreviation list support

### Known Biber Issues

- **Do NOT put HTML tags** (`<br/>`, `<b>`, etc.), Unicode math symbols, or unescaped special characters in `note` or `abstract` fields in `.bib` files. Biber passes them to the `.bbl` file and pdflatex crashes with `! Illegal parameter number in definition of \NewCount`.
- **TeXstudio config:** The bibliography tool must be set to `txs:///biber` in `Options -> Configure TeXstudio -> Build -> Default Bibliography Tool`. If set to bibtex, references won't resolve.

## Repository Structure

- `Report/main.tex` — Root document; sets class options, loads packages, includes chapters
- `Report/AIRlatex.cls` — TUM AIRlatex document class (do not edit)
- `Report/cover.tex` — Separate document for printing a physical cover
- `Report/source/` — Chapter files (`chapter01.tex` through `chapter05.tex`), `abstract.tex`, `appendix.tex`
- `Report/source/literature.bib` — Bibliography database (single active bib file, ~31 entries)
- `Report/figures/` — Images and TikZ figures (supports PDF, PNG, TikZ formats)
  - `Report/figures/trained_objects/` — Directory for training object images
- `additonal_info/` — Reference materials:
  - `Masters Thesis Expose - Carsten Oertel.pdf` — Full expose with objectives, WPs, milestones, research questions
  - `SemesterThesis-Introduction-Presentation.pdf` — Introduction presentation with SotA review, pipeline diagram, evaluation plan
  - `AR-AgileHand-Productflyer-SCREEN-en.pdf` — Agile Hand product brochure with specs (weight, DoF, joint ranges, fingertip force, velocity)
- `scripts/` — Python plotting scripts:
  - `plot_style.py` — Reusable matplotlib style (mirrors MATLAB plot_settings, academic color palette, serif font)
  - `plot_results.py` — Generates all thesis result figures to `Report/figures/plots/` (PDF + PNG)
- `.gitignore` — Excludes LaTeX build artifacts, keeps PDFs

## Key Conventions

- **Class options** are set in `main.tex`: font (Charter), black headings/refs, Biber backend, numeric bib style (`optBibstyleNumeric`), centered equations, English language.
- **Graphics path** is `figures/` — use `\includegraphics{filename}` without the directory prefix.
- **Single bib file:** `source/literature.bib` (literature1.bib is no longer used).
- Custom commands: `\code{...}` for inline code, `\degree` for degree symbol.
- The `.cls` file is auto-generated from the AIRlatex project — modifications should go in `main.tex` preamble, not the class file.
- Use `\cref{}` for cross-references (provided by cleveref via AIRlatex).
- Citation style: numeric (`[1]`, `[2]`, ...), sorted by order of first appearance.
- Use vector graphics (PDF/TikZ) over raster (PNG) whenever possible.
- Math notation: scalars italic lowercase, vectors bold lowercase, matrices bold uppercase.
- Abbreviations: use `\ac{RL}` for first use (expands to full form), `\acs{RL}` for short form only. Defined in `main.tex` abbreviation list. POMDP acronym is defined.
- Algorithm pseudocode: use `algorithm` + `algpseudocode` environments (not `algorithmicx`). See Chapter 3 for examples.

### Chapter Organization Principle

- **Chapter 3 (Methods):** Strictly mathematical and abstract. Problem formulation (POMDP), RL objectives (PPO), distillation algorithms (DAgger, SafeDAgger, DexSafeDagger). No implementation details, no specific numbers, no hardware descriptions.
- **Chapter 4 (Experiments):** All implementation details. Hardware platform, simulation environment, reward terms/weights, observation/action spaces, network architectures, training hyperparameters, ADR ranges, evaluation protocol, results with concrete numbers, ablations.

## Writing Guidelines

When writing thesis content:

- Write in **academic English**, third person, present tense for general statements, past tense for completed experiments.
- Each chapter should open with a brief paragraph stating what the chapter covers.
- Every figure and table must be referenced in the text.
- **Place figures in their corresponding subsection**, not collected at the end of a chapter or section. Each figure should appear close to the text that discusses it, so readers encounter the visual alongside the explanation.
- Keep paragraphs focused — one idea per paragraph.
- Cite sources for all claims that are not the author's own contribution.
- Use `\label{}` and `\cref{}` consistently for all numbered elements.
- Use `\blindtext` as placeholder for sections that need the author's input — add a `% PLACEHOLDER:` comment explaining what content is needed.
- When adding new bibliography entries, do NOT include `abstract` or `note` fields (they crash biber/pdflatex).

### Readability for Non-Experts

The thesis should be accessible to readers who are not specialists in dexterous manipulation or reinforcement learning. Two key rules:

**1. No em-dashes (`---`) for inline explanations.** Use proper linguistic connectors instead. Em-dashes are ambiguous and force the reader to guess the relationship between clauses.

| Instead of | Write |
|---|---|
| `term---explanation---continuation` | `term, which is explanation, continuation` |
| `concept---meaning X` | `concept, meaning X` / `concept, referring to X` |
| `method---doing X and Y` | `method, in which X and Y` |
| `result---a significant gap` | `result, which represents a significant gap` |
| `list of things---A, B, C---rest` | `list of things, such as A, B, and C, rest` / `including A, B, and C` |
| `cause---effect` | `cause, thereby effect` / `cause; effect` / `cause, as effect` |

**2. Explain non-trivial terms on first use.** When introducing a technical term or concept that a mechanical engineering student might not know, provide an inline explanation with examples. Do not assume the reader knows domain-specific jargon.

| Instead of | Write |
|---|---|
| `manipulation primitives` | `manipulation primitives, which are hand-coded motion sequences for specific subtasks such as "close fingers to power grasp" or "rotate object using thumb opposition"` |
| `force closure` | `force closure, meaning the ability to resist arbitrary external wrenches through the contact forces alone` |
| `sim-to-real gap` | `sim-to-real gap, referring to discrepancies between simulated and real physics, perception, and actuation` |

The explanation should appear at the **first mention** of the term. Subsequent uses can use the term without re-explanation.
