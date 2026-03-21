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

1. **Privileged Teacher Policy (RL):** Built a dexterous grasping agent in Isaac Lab using the manager-based environment API (different from DextrAH-RGB's published code). Integrated custom robot asset (Agile Hand on FR3 arm), wrote custom reward functions and environment modifications. Training works, grasping agent works.

2. **Student Policy Distillation:** The original DextrAH-RGB paper uses **DAgger** for distilling the privileged teacher into a vision-based student policy. This thesis replaces DAgger with **SafeDAgger** (Zhang & Cho 2016) / **DexSafeDagger** (Chi Zhang 2026, advisor's paper) and compares the two approaches.

**Key differences from DextrAH-RGB:**
- No Fabric-Guided Policies (FGPs) — the FGP setup had too many intricacies for the available time; standard RL policy is used instead
- Manager-based Isaac Lab environment (vs. the authors' direct environment API)
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
- **Hand:** Agile/Tekken Hand (16 DoF, thumb abduction DoF)
- **Sensors:** RGB-D (Intel RealSense D405)
- **Simulation:** Isaac Lab (manager-based environments)
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

The chapter files need to be rewritten from the current template content to thesis content:

- `chapter01.tex` — **Introduction:** Motivation (dexterous hands underused outside labs, reliability bottleneck), problem statement, scope, contribution summary
- `chapter02.tex` — **Related Work:** Dexterous grasping (UniDexGrasp++, DexGraspNet, DextrAH), policy distillation (DAgger, SafeDAgger, DexSafeDagger), sim-to-real transfer (DeXtreme, domain randomization), Isaac Lab
- `chapter03.tex` — **Methods:** System setup (Isaac Lab manager-based env, asset integration, reward design), teacher training (PPO, privileged observations), student distillation (DAgger vs SafeDAgger), evaluation protocol
- `chapter04.tex` — **Experiments & Results:** Training curves, grasp success rates, safety metrics (unsafe episodes), DAgger vs SafeDAgger comparison, ablations
- `chapter05.tex` — **Discussion & Conclusion:** Findings, limitations (no FGPs, sim-only so far), future work (finger-gaiting, thread start, real-world transfer in master's thesis)
- Additional chapters may be added (e.g., separate Background/Fundamentals chapter)

### Current State

- The report files still contain **template/example content** — none of the actual thesis content has been written yet.
- The title page in `main.tex` is configured for a Semester Thesis with the correct author/advisor/date.
- The `abstract.tex` still contains placeholder blind text.
- The `literature1.bib` file already contains most key references. Missing: UniDexGrasp++, DexGraspNet synthesis paper, some expose references.
- The Bicchi & Kumar entry in `literature1.bib` has a **missing cite key** (needs fixing).

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

## Repository Structure

- `Report/main.tex` — Root document; sets class options, loads packages, includes chapters
- `Report/AIRlatex.cls` — TUM AIRlatex document class (do not edit)
- `Report/cover.tex` — Separate document for printing a physical cover
- `Report/source/` — Chapter files (`chapter01.tex`, `chapter02.tex`, `chapter03.tex`), `abstract.tex`, `appendix.tex`
- `Report/source/literature.bib`, `Report/source/literature1.bib` — Bibliography databases
- `Report/figures/` — Images and TikZ figures (supports PDF, PNG, TikZ formats)
- `additonal_info/` — Reference materials:
  - `Masters Thesis Expose - Carsten Oertel.pdf` — Full expose with objectives, WPs, milestones, research questions
  - `SemesterThesis-Introduction-Presentation.pdf` — Introduction presentation with SotA review, pipeline diagram, evaluation plan

## Key Conventions

- **Class options** are set in `main.tex` line 2-12: font (Charter), black headings/refs, Biber, alphabetic bib style, centered equations, English language.
- **Graphics path** is `figures/` — use `\includegraphics{filename}` without the directory prefix.
- **Two bib files** are loaded: `source/literature.bib` and `source/literature1.bib`.
- Custom commands: `\code{...}` for inline code, `\degree` for degree symbol.
- The `.cls` file is auto-generated from the AIRlatex project — modifications should go in `main.tex` preamble, not the class file.
- Use `\cref{}` for cross-references (provided by cleveref via AIRlatex).
- Follow I6 citation style: alphabetic (e.g., `[BM92]`), use `\cite[page X]{key}` for direct quotes.
- Use vector graphics (PDF/TikZ) over raster (PNG) whenever possible.
- Math notation: scalars italic lowercase, vectors bold lowercase, matrices bold uppercase.

## Writing Guidelines

When writing thesis content:
- Write in **academic English**, third person, present tense for general statements, past tense for completed experiments.
- Each chapter should open with a brief paragraph stating what the chapter covers.
- Every figure and table must be referenced in the text.
- Keep paragraphs focused — one idea per paragraph.
- Cite sources for all claims that are not the author's own contribution.
- Use `\label{}` and `\cref{}` consistently for all numbered elements.
