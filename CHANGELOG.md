# Changelog

Tracks recent changes to the thesis report. Newest entries on top.

## 2026-04-09

### Title and Title Page

- **Thesis title set** in `main.tex`. English: "On the Training-Time Safety of Privileged Policy Distillation for Dexterous Grasping: A DAgger vs.\ SafeDAgger Study". German: "Trainingssicherheit bei der Destillation privilegierter Strategien für geschicktes Greifen: Ein Vergleich von DAgger und SafeDAgger". `Policy`, `DAgger`, and `SafeDAgger` are wrapped in `\mbox{}` to prevent line-breaking inside the title.
- **School override**: added `\renewcommand{\AIRlangSchool}{\AIRlangSchoolMW}` in the preamble to switch the title page from the class default (TUM School of Computation, Information and Technology) to the **TUM School of Engineering and Design**.
- **Title page header**: repositioned the Agile Robots logo to sit directly underneath the TUM logo on the right (NorthEast 2cm/3.6cm), and added an "In collaboration with Agile Robots SE" annotation under the TUM tercet on the left, anchored at NorthWest 2.5cm/5.5cm to align both with the TUM/School text block (at 2.5cm) and with the body text margin (also 2.5cm per `\geometry` in the class). Font is Helvetica (`phv`, 10pt) in black to match the corporate-design header.

### Chapter 5 — Discussion and Conclusion

- Wrote first full draft of Ch.5, replacing the bare placeholder. Sections: **Discussion** (revisits RQ1–RQ3 with the actual numbers from Ch.4: teacher 85.8% GSR / 12.1% UER, SafeDAgger 72.7% vs DAgger 71.7%, run 10b at 79.2% / ~92% of teacher ceiling, ADR degradation $-15.3$ vs $-22.9$ pp; subsections on why teacher quality dominates the distillation algorithm and on the outsized impact of low-level implementation details such as the one-hot bug fix), **Limitations** (sim-only, single hand/arm/task, action-disagreement gating instead of a learned classifier, limited scale, no fabric-guided policies), **Conclusion**, and **Future Work** (real-robot validation + sysid, finger-gaiting and fine tool use, learned classifier / Q-value gating à la `ChiZhang2026`, integrating geometric fabrics). Cites `ChiZhang2026` for DexSafeDagger.

### Chapter 4 — Experiments and Results
- **§4.1.1 Hardware Platform**: reordered so Hardware Platform precedes Asset Integration (Asset Integration and Contact Physics moved to be the *last* paragraphs of Hardware Platform instead of living under Simulation Environment).
- **§4.1.1 Sensor Setup**: replaced the placeholder with an honest description of the three sensing channels, grounded in the `fr3_agilehand` codebase observation space: proprioception (everywhere), joint-torque + simulator-only contact wrenches (*privileged critic only* — Agile Hand has no real contact sensors), and vision (student only via the stereo encoder; teacher never sees images). Explicitly frames the asymmetry as the reason for the privileged teacher–student split.
- **§4.2.5 Safety Threshold Sensitivity**: added a visible yellow `\todo` note requesting a β_safe-over-training-iteration plot across the δ sweep runs (1c, 3a, 5a, 6a, 7a, 8a, 9a). Loaded `todonotes` package in `main.tex`.
- Fixed spelling: **"Adaptive" → "Automatic" Domain Randomization** (per OpenAI 2020) in Ch.3, Ch.4, and the abstract. Matches the `\acro{ADR}` definition in `main.tex`.

### Chapter 3 — Methods
- **§3.3.3 RGB-Based Distillation**: rewrote as a detailed theoretical walkthrough of the DextrAH-RGB stereo encoder, including the Siamese ImageNet-pretrained ResNet-18 fine-tuned end-to-end, the last-two-layer removal, the 128×128 tokenization, the learnable `[embed]` token, the 2-layer transformer with strictly cross-view attention mask, and the LSTM(512) control head. Added a combined two-panel figure (`fig:stereo_full`) with (a) the stereo encoder diagram (TikZ-overlaid `I_left`/`I_right` labels) and (b) the cross-attention mask, both constrained to equal height. New bib entries: `He2016`, `Dosovitskiy2020`, `Wang2024DUSt3R`.
- **§3.3.2 Loss Function Selection**: added the **inverse-variance-weighted L2 loss** (`eq:wl2_loss`) as the loss actually used in this thesis, derived as a simplification of the forward KL between two diagonal Gaussians. Flags the discrepancy with Singh et al. 2025 (who recommend KL) and explains that this thesis follows the DextrAH-RGB codebase rather than the paper.
- **§3.3.1 DAgger pseudocode**: rewritten to match Ross et al. 2011 verbatim (including "Initialize π̂_1 to any policy in Π"); Π is defined in the surrounding text.
- **§3.3.1 SafeDAgger**: rewritten to use *direct action-disagreement gating* instead of a learned safety classifier (the classifier is redundant in the distillation setting because the teacher is already queried every step). Algorithm box and intervention equation updated accordingly.
- **§3.2.2 PPO Objective**: removed — implementation detail, hyperparameters belong in Ch.4.
- **§3.1 Problem Formulation**: opens with a plain-language MDP introduction (states, actions, transitions, reward, discount, Markov property, agent loop) before extending to the POMDP.

### Chapter 2 — Related Work
- **§2.3.1 Domain Randomization figure**: restored the illustration, corrected attribution from Tobin et al. 2017 to **Lilian Weng's 2019 blog post** (the actual source). Added `@online{Weng2019DR}` to `literature.bib`.
- **§2.3.2 System Identification**: dropped the Isaac Lab/Isaac Gym paragraph (belongs to simulator choice, not sysid; already in Ch.4). Replaced the misleading "this thesis follows the hybrid philosophy" sentence with an honest note that no sysid was performed; FR3 uses vendor-provided actuator/inertia values as-is, Agile Hand parameters come straight from the URDF, and residual uncertainty is absorbed by the ADR curriculum.

### Abstract
- Replaced placeholder blind text with a concise English + German abstract covering the problem framing, the DAgger vs. SafeDAgger comparison, teacher numbers (85.8% GSR / 12.1% UER), student numbers (72.7% vs. 71.7%, up to 79.2%), and the two headline findings (teacher quality dominates; SafeDAgger degrades more gracefully under hard ADR).

### Chapter 2 — Related Work
- Restored the domain randomization figure in §2.3.1 with caption + `\cref`; corrected attribution from the Tobin et al. paper to Lilian Weng's 2019 blog post, added `@online{Weng2019DR}` to `literature.bib`.
- §2.3.2 (System Identification): dropped the Isaac Lab/Isaac Gym paragraph (not about sysid; already covered in Ch.4). Replaced the misleading "this thesis follows the hybrid philosophy" sentence with an honest note that no system identification was performed in this work, FR3 uses vendor-provided actuator/inertia values as-is, Agile Hand parameters come straight from the URDF, and residual uncertainty is absorbed by the ADR curriculum.

### Chapter 3 — Methods
- Removed §3.2.2 PPO Objective (implementation detail; PPO hyperparameters live in Ch.4).
- Added a plain-language MDP introduction before the POMDP definition in §3.1 so the reader sees states/actions/transitions/reward/discount + Markov property before the partial-observability extension.

### Chapter 4 — Experiments and Results
- **§4.1.1 Reward Design**: replaced the stylized reward table with an accurate one reflecting the actual `fr3_agilehand` codebase. Organized into Shaping / Task / Regularization groups, 12 terms with code-names, purpose, and weights; ADR-swept weights (`finger_curl`, `lift`) marked with star and shown as endpoint ranges.
- **§4.1.1 Episode Structure**: added the formal termination equation `T = min{t | I_unsafe(s_t)=1 ∨ t ≥ T_max}` and expanded the termination list into a proper table covering all 9 codebase conditions, distinguishing penalty-eligible ones. Noted that the same conditions are reused as SafeDAgger unsafe-event signals during distillation.
- Added `\usepackage{multirow}` to `main.tex` preamble for the grouped reward rows.

### Repo
- Moved AIRlatex template example figures into `Report/figures/examples/`; tracked `.claude/settings.local.json`; gitignored `Report/cover.pdf`.

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
