# Multi-Agent RL for Grid2Op – Design Notes

File: `sandboxes/multi_agent/README.md`

## 1. What "multi-agent" realistically means in Grid2Op

**Grid2Op is inherently single-agent.**  
The environment exposes **one global observation** and expects **one global `Action`** per timestep.  
There is **no native multi-agent API**. Any multi-agent logic must be implemented **outside** the environment via a wrapper.

Realistic multi-agent patterns we can use:

### 1) Multiple agents controlling zones / subsets of the grid
- A **master controller** wraps Grid2Op:
  - Splits the global observation into local/regional observations.
  - Calls local agents (RL or heuristics) for *proposed regional actions*.
  - Merges them into one Grid2Op `Action`, resolving conflicts and masking unsafe operations.

**Variants:**
- **Disjoint regions** → simplest merging (no conflicting switches).  
- **Overlapping regions** → require arbitration rules (priority, safety checks, action pruning).

### 2) Hierarchical control (coordinator + local agents)
- **High-level agent**:
  - Chooses *which region* or *which intervention type* (e.g., topology vs redispatch).
- **Low-level agents**:
  - Select concrete actions within their restricted action sets.

This reflects hierarchical MARL from recent Grid2Op research and scales better for large action spaces.

### 3) Independent vs. shared policies (parameter sharing)
- **Independent policies**:  
  - Each region has a separate RL model.  
  - Flexible but significantly more complex and harder to train.

- **Shared policy (recommended)**:  
  - One policy network for all regions, with region-specific observations + action masks.  
  - Lower complexity, better sample efficiency, widely used in modern MARL literature.

---

## 2. Constraints and limitations

### 2.1 Grid2Op limitations
- **Single-agent core** — cannot step multiple agents independently.  
- **One global action** — multi-agent proposals must be merged.  
- **No built-in region slicing** — we must define:
  - How to extract local observations.
  - Which actions belong to each region.
  - How to mask illegal or unsafe actions.

### 2.2 Complexity vs. team capacity
Multi-agent control adds significant overhead:
- Custom environment wrapper.
- Conflict resolution logic.
- More complicated debugging (several policies acting simultaneously).
- MARL is harder to tune and less stable than single-agent RL.

Given our current timeline and available capacity, multi-agent is **non-trivial** and should not be the first target.

### 2.3 Potential benefits for our use case
- **Scalability**:  
  - Splitting the grid reduces each agent’s action space → more stable training in large networks.

- **Robustness**:  
  - Local failures do not necessarily break the whole system.

- **Experimentation flexibility**:  
  - Easier to test different control types (topology, redispatch, storage) independently.

---

## 3. Multi-agent vs. single-agent for our project

### Pros of multi-agent
- Better scalability for large topological action spaces.
- Natural alignment with power system structure (zones, substations).
- Modular experimentation (easier to replace or specialize agents).

### Cons of multi-agent
- Higher implementation complexity.
- Requires careful coordination and conflict handling.
- Harder and less stable training (MARL instability).
- Risk of derailing the MVP (too many moving parts).

### Pros of single-agent (baseline)
- Simpler, faster to implement.
- Easier to debug.
- Strong baseline for later comparisons.
- Fits within current MVP scope.

### Cons of single-agent
- May struggle with very large action spaces.
- Harder to incorporate domain-specific decomposition (e.g., regional decisions).

---

## 4. Recommendation for MVP

**Recommendation: _maybe_, but not as the core of the MVP.**

### For MVP:
- Stick to **single-agent PPO/SAC** as the primary controller.  
- Structure the code so that multi-agent can be added later (clean interfaces, regional slicing utilities, action masking functions).

### Multi-agent as a future extension:
If time allows after a stable baseline:

**Preferred design direction:**
1. **Hierarchical MARL with parameter sharing**
   - **Coordinator agent** (may be heuristic at first).
   - **Shared-policy regional agents**, each acting on a masked subset of actions.
   - **CTDE (centralized training, decentralized execution)**:  
     - Training uses global observations.  
     - Execution uses local/regional observations.

2. **Start with disjoint regions** to avoid complex conflict resolution.

**Summary:**  
- **MVP → single-agent** for speed and stability.  
- **Multi-agent → optional extension**, best implemented as **hierarchical + shared-policy regional agents**.

