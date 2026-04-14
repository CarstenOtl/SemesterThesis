# Chi Review Notes (April 2026)

Notes from advisor Chi Zhang's review of the Semester-v2 draft. Extracted from annotated PDF (`additonal_info/Semester-v2-chi-reviewed .pdf`) and verbal follow-up conversation.

## Core Principle

**"This is a research thesis, not a lab report or a diary. Your goal is to follow the equation of finding a problem - design a solution - run experiments - analyze the data - draw a conclusion - create a future plan. Everything that deviates from this equation is irrelevant!!!!!"**

## Fundamental Reframing (verbal feedback)

1. **This thesis is NOT about DAgger vs. SafeDAgger comparison.** It is about setting up the full pipeline: privileged teacher training + RGB-based policy distillation. The safety-aware distillation is one component, not the central narrative.

2. **The core contribution is a NEW RL pipeline for privileged teacher policy training with a custom dexterous hand**, which serves as a means to an end for the RGB distillation. The pipeline itself (environment, reward, ADR, asset integration) is the contribution.

3. **Real UER must be defined properly** -- not just mentioned in discussions. Needs a clear, upfront definition.

4. **Ablation studies section = experimental design, not results.** Explain what the experiments are, the design choices, why these metrics were chosen, and how design choices were made.

5. **Teacher policy comparison (teacher 10 vs teacher 11) is not part of the main storyline.** Only need to show that the teacher works. The two-teacher comparison should move to appendix. The important distinction is training -> distillation, not teacher A vs teacher B.

6. **Ablations on 3 distillation methods:** DAgger, SafeDAgger, and **Behavioral Cloning (to be added as a new baseline)**. Need to explain experiment setup and justify why experiments are designed as they are. Three metrics:
   - Global lift success
   - Average unsafe episode rate
   - Per-object failure mode comparison for DAgger, SafeDAgger, and BC
   Emphasize objects that show better unsafe episode rates during training time. Move remaining plots to appendix.

## PDF Annotations (sticky notes, verbatim)

### Page 1 (Title)
- "please polish this: A DAgger vs. SafeDAgger Study is unnecessary, something like rl based teacher policy training + policy distillation of an agile robotics dexterous hand...... Maybe: towards safe exploration......"
- "this is a research thesis, not a lab report or a diary. your goal is to follow the equation of finding a problem - design a solution - run experiments - analyze the data - draw a conclusion - create a future plan. Everything that deviates from this equation is irrelevant!!!!!"

### Page 7 (Abstract)
- "problem- solution- result. no need to relate to relevant works. DAGGER is 'typical' not standard."

### Page 9 (Ch.2, Sim-to-Real)
- "sim2real methods normally fall into domain randomization and domain adaptation. system identification are not commonly considered as a sim2real approach"

### Page 10 (Ch.2, Section titles)
- "polish the titles"

### Page 23 (Ch.2, 2.1.1 Rule-Based)
- "how is rule-based method originally done, and to what direction later works extend the methods to? most importantly, pros and cons."

### Page 24 (Ch.2, 2.1.2 Learning-Based)
- "with the pros and cons of the last section, you can talk about why people shift to learning based approaches more these days. also pros and cons."

### Page 24 (Ch.2, 2.2 Distillation)
- "distillation has a purpose originally to reduce model size, and what you are talking about is imitation learning. distillation tend to borrow the imitation learning methods. mention a comparison between distillation and Mixture of Experts. do state the distillation storyline step by step to justify our choice to go down this path."

### Page 26 (Ch.2, Domain Randomization)
- "why don't you introduce some of the most frequently randomized variables in the dex manipulation area?"

### Page 27 (Ch.2, System Identification)
- "system ident is not a sim2real to my understanding."

### Page 29 (Ch.3, Methods intro)
- "cite Sutton" (on "Reinforcement learning")
- "Section Methods is about explaining how you did your job!!!!! Mathematically and theoretically!!! Plainly state your design and justify it!"

### Page 30 (Ch.3, Asymmetric Actor-Critic)
- "do talk a little bit on our scenario"

### Page 31 (Ch.3, Reward / DAgger)
- "you should distribute a sign for each of these terms" (reward terms need +/- signs)
- "not really, try not to use extreme terms" (on calling BC "the simplest distillation strategy")
- "no need to explain the original version, just state your version clearly." (on DAgger/SafeDAgger)

### Page 32 (Ch.3, DexSafeDagger paragraph)
- "no need" (remove the DexSafeDagger completeness paragraph)

### Page 36 (Ch.3, GPU rendering)
- "this is engineering, not scientific" (remove from Ch.3)

### Page 37 (Ch.4, Simulation Environment / Hardware)
- "implementation details should be stated in compact format and briefly."

### Page 41 (Ch.4, Observation Space)
- "what really matters for RL pipelines are observation spaces, action spaces, termination conditions etc."

### Page 42 (Ch.4, Reward Design)
- "do put this at the beginning page of the section" (move reward design earlier)
- "you should explain this" (Teacher one-hot)
- "how is each term defined mathematically? is it a quadratic function? or is it exponential???" (reward terms need math definitions)

### Page 44 (Ch.4, Training Configuration)
- "no need" (cut or compress PPO hyperparameters)

### Page 46 (Ch.4, Distillation hyperparameters)
- "put this in a paragraph" (not bullet list)

### Page 47 (Ch.4, Ablation Studies / Evaluation Metrics)
- "why do you need them? justify them." (evaluation metrics)
- "ablation studies is how you design your ablation experiments and why!!! not the results."

### Page 50 (Ch.4, Results, run naming)
- "where did you explain the runs? also how do you run the experiments should be in the experiments section."

### Page 59 (Ch.4, Summary Finding #4)
- "too engineering" (on "Correct teacher-student object mapping is critical")

### Page 60 (Ch.4, Summary Findings #6-7)
- "these findings are not essential, you can discuss them in discussion." (LSTM checkpoint and physics stability findings)

## Revision Status

- [x] Title -- renamed to "Safe Privileged Policy Distillation for Vision-Based Dexterous Grasping"
- [x] Abstract -- restructured as problem-solution-result, "typical" not "standard"
- [x] Ch.2 -- pros/cons flow, distillation/MoE distinction, removed sysid section, added DR variables
- [ ] Ch.3 -- cite Sutton, state OUR design, remove DexSafeDagger paragraph, remove GPU rendering, add reward term signs, don't explain original DAgger
- [ ] Ch.4 -- restructure around pipeline (teacher -> distillation), move teacher comparison to appendix, add BC baseline, define real UER upfront, math for reward terms, compress implementation details, redesign ablation section
- [ ] Ch.5 -- reframe around pipeline findings, absorb engineering findings from Ch.4 summary
- [ ] Appendix -- add teacher comparison, extra per-object plots
- [ ] New experiment -- run BC baseline for 3-way comparison

