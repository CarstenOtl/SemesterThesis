# Changelog

Tracks recent changes to the thesis report. Newest entries on top.

## 2026-04-08

### Chapter 4 — Experiments and Results (restructure per supervisor outline)

- Reorganized into the supervisor's three-section layout:
  - **4.1 Experimental Setup** — now wraps three subsections:
    - **4.1.1 Teacher Policy Training** (new): Simulation Environment, Hardware Platform, Object Set, Episode Structure, Observation/Action Space, Reward Design, Network Architecture, Training Configuration, ADR, **Sim-to-Real Curriculum** (moved here from old §4.8 design portion).
    - **4.1.2 Student Policy Distillation** (was §Student Policy Implementation).
    - **4.1.3 Evaluation Metrics** (was §Evaluation Protocol; "Metrics" → "Definition").
  - **4.2 Ablation Studies** — moved to come **before** results, per supervisor.
  - **4.3 Results, Graphs and Tables** (new wrapper) — contains 4.3.1 Teacher Training Results and 4.3.2 Distillation Results as subsections.
  - **4.4 Summary of Findings** (unchanged).
- Swapped order: **Simulation Environment now precedes Hardware Platform**.
- Deleted standalone `\section{Teacher Policy Implementation}`; its children are now subsubsections under 4.1.1.
- Updated chapter intro `\cref` list to match new structure (`sec:teacher_implementation` removed; `sec:teacher_training_setup` and `sec:results` added).

### Chapter 3 — Methods (restructure per supervisor outline)
- **3.1 Problem Formulation**: collapsed POMDP definition, objective, and the privileged-vs-partial-observability discussion into a single tighter section. The "privileged vs. partial" subsection was dropped as a standalone heading; its content now motivates the asymmetric actor–critic in §3.2.
- **3.2 Privileged Teacher Training**: kept Asymmetric Actor–Critic, PPO Objective, Reward Structure (kept short), and ADR (kept short). Reward and ADR explicitly forward to Ch.4 for concrete numbers.
- **3.3 Policy Distillation**: reorganised into three subsections per supervisor outline:
  - **3.3.1 DAgger and SafeDAgger** — SafeDAgger folded in as a `\paragraph` under DAgger rather than its own top-level subsection. DexSafeDagger demoted to a single sentence noting it as unpublished related work that motivated the SafeDAgger choice but is not part of this thesis.
  - **3.3.2 Loss Function Selection** — new subsection explicitly contrasting L2 (\cref{eq:l2_loss}) and KL (\cref{eq:kl_loss}) imitation losses, with the choice flagged as a design parameter for Ch.4.
  - **3.3.3 RGB-Based Distillation** — new subsection covering visual encoder, in-loop photorealistic rendering, and visual domain randomization on top of the dynamics ADR.
- Fixed dangling cross-ref `eq:beta_safedagger` in Ch.4 (removed in Ch.3 restructure).

### Chapter 2 — Related Work (full restructure)
- Reorganized from 6 textbook-style sections (classical control → grasp planning → RL → sim2real → IL → dexterous → simulators) into **3 thematic sections** focused on what others have done, per supervisor feedback:
  - **2.1 Dexterous Grasping with Multi-Fingered Hands** (rule-based vs. learning-based)
  - **2.2 Privileged Teacher–Student Distillation** (BC/DAgger vs. safety-aware variants)
  - **2.3 Sim-to-Real Transfer and Generalization** (DR/ADR vs. system identification)
- **Cut:** standalone Classical Robot Control section (PD/impedance content moves to Ch.4 hardware), RL primer (MDP/PPO definitions belong in Ch.3 Methods), standalone Simulation Frameworks section (folded into 2.3).
- Added explicit positioning sentences ("This thesis…") at the end of each subsection so the supervisor can see where the work sits relative to each thread.

### Chapter 1 — Introduction
- **Problem Statement** rewritten to articulate the *general* problem emerging from the current situation (dexterous hands hardware-ready but no scalable recipe for policies that are both deployable and safe to train), instead of jumping directly into the DextrAH-RGB / SafeDAgger methodology. Methodological specifics now live in Contributions and Chapter 4. (Supervisor feedback on first draft.)
