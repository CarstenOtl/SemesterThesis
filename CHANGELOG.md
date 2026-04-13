# Changelog

Tracks recent changes to the thesis report. Newest entries on top.

## 2026-04-13

### Chapter 4 — Experiments and Results (Chi v2 review revisions)

**Compression of implementation details (Chi: "compact format and briefly"):**
- **§4.1.1 Simulation Environment**: reduced from 30 lines to 3 lines. Removed "Direct environment API" paragraph and PhysX parameters table (`tab:physics_config`). Kept: Isaac Lab + PhysX 5, 120 Hz sim / 60 Hz control.
- **§4.1.1 Hardware Platform**: reduced from 50 lines to 8 lines. Removed sensor setup bullet list (already covered in Ch.3 `tab:ac_observations`), actuator parameters table (`tab:actuator_params`), contact physics paragraph, detailed FR3/Agile Hand specs. Kept: DoF counts, joint ranges, thumb speed constraint, hardware figure, USD asset note.

**Section reorder (Chi: "do put this at the beginning"):**
- Moved **Reward Design** from after Action Space to immediately after Hardware Platform — first substantive content the reader sees after the platform description.
- Moved **Episode Structure** (termination conditions) to after Action Space, before Object Set. New order: Sim Env → Hardware → Reward Design → Obs Space → Action Space → Episode Structure → Object Set → Network → Training Config → ADR → Sim2Real.

**Reward table with mathematical forms (Chi: "quadratic? exponential???"):**
- Replaced the old Group/Term/Purpose/Weight table with a new Term/Purpose/Form/Weight table. Each reward term now has its functional form: exponential distance ($w \cdot e^{-\alpha d}$), quadratic angle penalty ($-w \cdot \theta^2$), binary indicators ($w \cdot \mathbb{1}[\cdot]$), contact-gated exponentials ($w \cdot e^{-\alpha d} \cdot m_c$), quadratic penalties ($-w \cdot \|\Delta a\|^2$).

**PPO hyperparameters compressed (Chi: "no need"):**
- Replaced the full PPO table (`tab:ppo_hyperparams`) with a single-paragraph inline listing of all hyperparameters.

**Distillation hyperparameters as paragraph (Chi: "put this in a paragraph"):**
- Converted the 9-item bullet list to a 3-sentence paragraph. References `eq:total_loss` from Ch.3 for the combined loss.

**Evaluation metrics justified (Chi: "why do you need them?"):**
- Rewrote §4.1.3 Evaluation Metrics with explicit justification for each metric: GSR = task completion (primary objective), UER = training-time safety (core hypothesis), Real UER = hardware-relevant safety (excludes simulation artifacts). Declared "all UER values refer to real UER unless stated otherwise." Removed the Evaluation Procedure subsubsection (script names are engineering detail).

**Ablation section restructured (Chi: "ablation studies is how you design your ablation experiments and why, not the results"):**
- Renamed §4.2 from "Ablation Studies" to **"Experimental Design"**.
- Rewrote as 4 clean design-focused subsections: (1) Distillation Method Comparison (BC/DAgger/SafeDAgger — what and why), (2) Safety Threshold Sensitivity (δ sweep rationale), (3) Effect of Domain Randomization during Distillation, (4) Effect of Environment Count.
- Removed all result numbers from the ablation section — these now live only in §4.3 Results.
- **Removed**: Effect of Early Termination Penalty (merged into reward design), Effect of Teacher Strength (moved to appendix scope), LSTM Checkpoint Resume (moved to Ch.5 Discussion), Query Efficiency Analysis (TODO placeholder removed), Learning Curve Comparison (moved to results), Effect of Distillation Duration (placeholder removed).

**Teacher training results compressed (Chi: "not part of main storyline"):**
- Replaced 80-line Training Progression + Physics Stability Challenges + 3-teacher comparison with a 4-line paragraph showing only teacher 11 numbers (85.8% GSR, 12.1% real UER, ADR-14, 33k epochs, 1024 envs). Teacher 10 comparison, physics challenges table, physics timeline figure all removed from main text (appendix candidates).

**Distillation results cleaned (Chi: "where did you explain the runs?"):**
- Added experimental structure paragraph explaining what varies across experiments (method, δ, envs, ADR) and what is held constant (teacher, architecture, loss).
- Removed internal run naming (1a, 1c, 5a, 7a, 8a, 8b, 9a, 9b) and one-hot bug narrative from the results text. Clean distillation summary table now uses Method/δ/Envs/ADR/GSR/UER columns without run IDs.
- Simplified DAgger vs SafeDAgger comparison paragraph — removed "teacher quality dominates" and "one-hot bug" paragraphs (these are discussion points, not results).

**Summary of Findings trimmed:**
- Kept 4 scientific findings: (1) comparable GSR, (2) SafeDAgger produces safer students, (3) SafeDAgger degrades more gracefully under ADR, (4) δ = 2.0 optimal.
- Removed engineering findings #4 (one-hot bug), #6 (LSTM checkpoint), #7 (physics stability) per Chi's "too engineering" / "not essential" notes. Added cross-reference to Ch.5 `sec:impl_details` where these are discussed.

**Other fixes:**
- Fixed dangling `\cref{sec:safedagger}` in Ch.5 → `\cref{sec:dagger_method}`.
- Updated chapter intro paragraph to match new structure (Experimental Setup → Experimental Design → Results).

### Chapter 3 — Methods (Chi v2 review revisions)

**Continued from earlier session (same date):**
- **§3.2.1 Asymmetric Actor–Critic**: added `\cite{Pinto2018}` (Pinto et al., RSS 2018 — origin of asymmetric actor-critic). Added bib entry `@inproceedings{Pinto2018}`. Rewrote justification sentence from "This design ensures..." (unsupported claim) to factual statement grounded in Pinto et al.: critic is discarded after training, so actor already operates on realistic proprioceptive interface.
- **§3.2.1**: added actor/critic observation table (`tab:ac_observations`) with actual dimensions from codebase — actor 87D, critic 172D. Critic gets expanded hand body state (54D for 6 bodies), contact forces (3D), measured joint torques (28D). Updated surrounding text to match (replaced "per-finger contact wrenches" with accurate components).
- **§3.2.1**: changed "one-hot encoding of the target object" → "scalar object identifier that tells the agent which object it is currently manipulating" (Chi: explain for the reader) → then corrected to "scalar" after codebase check confirmed it's a single dimension, not a K-dimensional one-hot.
- **§3.2.2 Reward Structure**: added reward overview table (`tab:reward_overview`) with $r_{\text{hand}}$, $r_{\text{lift}}$, etc. notation, signs, and purpose. Updated `finger_curl` purpose to "Penalizes excessive finger curling to encourage an open-hand approach."
- **§3.3.1 DAgger and SafeDAgger**: removed standalone DAgger algorithm box (kept only SafeDAgger algorithm with blue highlights). Condensed DAgger/SafeDAgger text from ~50 lines to ~20 lines.
- **§3.3.1**: rewrote SafeDAgger algorithm box to reflect actual implementation: online per-step updates (no dataset aggregation / replay buffer), references combined loss `eq:total_loss`.
- **§3.3.1**: added combined loss equation `L = L_action + λ_aux · L_aux` with auxiliary object position regression loss $\|\hat{x}_{obj} - x_{obj}\|^2$ (confirmed in codebase: `distillation_safedagger.py`).
- **§3.3.1 Loss Function Selection**: collapsed from standalone subsection to inline paragraph. Removed L2/KL derivation. Credits DextrAH-RGB for comprehensive comparison; thesis uses weighted L2 as default without further ablation.
- **§3.3.2 RGB-Based Distillation**: condensed from ~55 lines to ~20 lines. Removed detailed ResNet tokenization, cross-attention mask itemized list, DUSt3R reference. Kept: stereo for depth, shared ResNet-18, cross-view transformer, embed token → 64D embedding, LSTM head. Trimmed figure caption. Removed "photorealistic rendering" reference from section intro.
- Removed all `\paragraph{}` headings — content now flows as normal paragraphs.
- Moved teacher training pipeline figure (`fig:teacher_training`) from Ch.4 to Ch.3 §3.2 intro.
- Moved student distillation pipeline figure (`fig:student_training`) from Ch.4 to Ch.3 §3.3 intro.

### Abstract

- Removed "and sim-to-real-aware actuator constraints" from both English and German abstracts (unnecessary detail).

### Chapter 2 — Related Work

- **§2.1.1**: replaced "open-loop grasp poses" with "static grasp configurations that are executed by a separate controller and cannot adapt if conditions differ from the assumed model" (user flagged that "open-loop" is not established terminology in this context).
- **§2.1.2**: updated transition sentence to match ("static, non-adaptive nature" instead of "open-loop nature").

### Title

- **Renamed thesis** to "Safe Privileged Policy Distillation for Vision-Based Dexterous Grasping" (German: "Sichere Destillation privilegierter Strategien für geschicktes visuelles Greifen"). Chi: "A DAgger vs. SafeDAgger Study is unnecessary." Two alternative title options kept as comments in `main.tex`.

### Abstract (Chi v2 review revisions)

- Restructured as **problem → solution → result** (Chi: "problem - solution - result. no need to relate to relevant works"). Removed references to related work. Changed "standard" to "typical" for DAgger (Chi: "DAGGER is 'typical' not standard"). Now emphasizes the safety-aware distillation pipeline as the contribution rather than a head-to-head algorithm comparison. Both English and German abstracts rewritten.

### Chapter 2 — Related Work (Chi v2 review revisions)

- **§2.1.1** renamed from "Rule-Based and Analytical Approaches" to **"Analytical and Data-Driven Grasp Planning"**. Now ends with explicit pros (interpretability, verifiable quality) and cons (intractable search space, open-loop / model dependence) motivating the shift to learning (Chi: "how is rule-based method originally done… most importantly, pros and cons").
- **§2.1.2** renamed from "Learning-Based Approaches" to **"End-to-End Reinforcement Learning"**. Opens by connecting to the limitations from §2.1.1 (Chi: "with the pros and cons of the last section, you can talk about why people shift to learning based"). Ends with the sim-to-real gap as explicit motivation for the distillation section. Tightened prose — removed extended descriptions of individual works.
- **§2.2** renamed from "Privileged Teacher–Student Distillation" to **"Privileged Policy Distillation"**. Now distinguishes knowledge distillation (Hinton et al., model compression) from imitation learning / modality transfer. Added **Mixture of Experts** mention as an alternative paradigm (Chi: "mention a comparison between distillation and Mixture of Experts"). Added a storyline justifying the path from distillation → imitation learning → DAgger (Chi: "do state the distillation storyline step by step to justify our choice").
- **§2.2.1** renamed from "Behavioral Cloning and DAgger" to **"Imitation Learning and DAgger"**. Tightened prose; changed "default" to "typical" for DAgger.
- **§2.2.2** renamed from "Safety-Aware and Mixed-Control Variants" to **"Safety-Aware Distillation"**. Removed DexSafeDagger paragraph and IBORL paragraph. Simplified SafeDAgger description to focus on the gating mechanism.
- **§2.3** renamed from "Sim-to-Real Transfer and Generalization" to **"Sim-to-Real Transfer through Domain Randomization"**. Removed the §2.3.2 System Identification subsection entirely (Chi: "system ident is not a sim2real to my understanding"). Added paragraph on **commonly randomized variables** in dexterous manipulation — object properties, actuator characteristics, kinematic perturbations, sensor noise (Chi: "why don't you introduce some of the most frequently randomized variables?"). Collapsed into a single flat section (no subsections).

### Chapter 3 — Methods (Chi v2 review revisions)

- **§3.1 Problem Formulation**: added Sutton & Barto citation (`\cite{SuttonBarto2018}`) to MDP introduction.
- **§3.2.1 Asymmetric Actor–Critic**: added a new paragraph grounding the asymmetry in our specific scenario — critic sees object pose, velocity, and per-finger contact wrenches; actor sees only proprioception + one-hot object ID — and explains that this ensures the teacher's actor already operates on a realistic proprioceptive interface for distillation.
- **§3.2.2 Reward Structure**: rewrote reward equation to include explicit `sign_i ∈ {+1, -1}` with `w_i > 0` and `r_i ≥ 0`. Added sentences explaining that positive terms incentivize desired behavior, negative terms penalize undesirable behavior, and that functional forms are in Ch.4.
- **§3.3.1 DAgger and SafeDAgger**: replaced "The simplest distillation strategy, behavioral cloning…" with neutral `\ac{BC}` phrasing (Chi: "try not to use extreme terms"). Rewrote the section to state our design directly: BC problem → DAgger fix → "this thesis adopts SafeDAgger" → our direct action-disagreement gating justification. Removed the extended discussion of the original DAgger mixing schedule and original SafeDAgger classifier (Chi: "no need to explain the original version, just state your version clearly").
- **Removed DexSafeDagger paragraph** (Chi: "no need"). The two-sentence "for completeness" paragraph citing `ChiZhang2026` is gone.
- **§3.3.3 RGB-Based Distillation**: removed the GPU rendering paragraph (Chi: "this is engineering, not scientific"). Replaced with a shorter "Visual domain randomization" paragraph that keeps the scientific content (visual sim-to-real gap, visual DR as mitigation) but drops the engineering discussion of GPU-accelerated tiled rendering.

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
