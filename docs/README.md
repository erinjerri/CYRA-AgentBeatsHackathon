# CYRA AgentBeats Hackathon
## Abstract 
Create Your Reality Agent (CYRA) is a spatial-computing-native Green Agent benchmark built to evaluate embodied agent behavior in immersive AR/VR environments, following the design principles outlined in Establishing Best Practices for Building Rigorous Agentic Benchmarks (Zhu et al., 2025) and the AgentBeats Agentified Agent Assessment (AAA) framework.

Existing agent benchmarks such as OSWorld, WebArena, and τ-bench primarily evaluate agents through browser-based or API-centric tasks. CYRA extends this evaluation paradigm into spatial computing, measuring how agents perceive, reason, and act within 3D, multimodal interfaces while introducing spatial task competency as a first-class evaluation dimension.

CYRA is implemented initially on Apple Vision Pro (visionOS), combining: • Swift-based spatial UI for immersive/Windowed spaces • WebKit-constrained task scaffolds • Speech-driven function calling for voice intent • CoreML/VisionKit for visual context capture • SwiftData/CoreData as the local persistent state layer • Swift AppIntents as a native tool interface • FastAPI as a backend bridge to coordinate state, telemetry, and A2A-compliant interactions with the AgentBeats platform

Structured task representations, agent actions, and full-trace telemetry are persisted via lambda.ai cloud storage, enabling reproducible replay, deterministic scoring, and post-hoc analysis. The system is designed with cross-platform abstractions, with Meta Quest devices supported in the second phase of the hackathon to enable Purple Agent evaluations beyond Vision Pro.

The hackathon proceeds in two phases: • Phase 1 — Green Agent: CYRA evaluates productivity-focused workflows, such as task creation, task completion, document summarization, and spatial organization. The Green Agent acts as the environment manager, proctor, and evaluator, ensuring deterministic execution and reproducible scoring. • Phase 2 — Purple Agent: A competing agent interacts with the Green Agent to execute finance-oriented or transactional workflows, including AP2-inspired simulated app purchases and structured reasoning tasks. This phase emphasizes cross-platform compatibility and A2A protocol interoperability.

Each benchmark run captures complete telemetry across: • Speech input • Vision/intent parsing • Function-call sequences • Spatial interactions • Local and cloud state transitions

Evaluation is performed using state-matching rubrics comparing persisted app state, ledger entries, and task outcomes against explicit goal states. Metrics include task success rate, spatial accuracy, function-call correctness, latency, error recovery, and robustness across repeated trials.

CYRA, together with its complementary Purple Assessor Agent, forms a reusable, extensible benchmark template for evaluating agentic performance in embodied, multimodal, and cross-platform AR/VR environments. Developed under a rapid hackathon timeline, the project emphasizes transparency, modularity, and clearly documented limitations, while providing a foundation for future benchmarks in spatial computing and immersive AI systems.

## tl;dr - Description

CYRA is a visionOS-native agent evaluation framework designed for the AgentBeats Hackathon. The system pairs a deterministic "green agent" referee with a purpose-built "purple agent" challenger to stress-test the AgentBeats judging rubric through verifiable multi-modal evaluations.  

**Key Features:**  
- Vision-native sensing: visionOS client streams speech, vision, and SwiftData context into the FastAPI referee for synchronized multi-modal processing.  
- FastAPI referee core: Backend endpoints orchestrate task dispatch, evaluation triggers, and JSON state persistence to keep traces auditable.  
- Deterministic scoring: Green agent assessor enforces state matching plus action assertions to meet verifiable evaluation criteria.  
- Purple agent stress test: Purpose-built purple agent probes A2A/MCP integrations while the green referee logs every scoring decision.  
- Traceable judging trail: Trace logging bridges both agents so judges can replay tool calls, scores, and mismatches directly on AgentBeats.  

## System Architecture

### Green Agent (Referee)

The green agent serves as the deterministic evaluation spine, validating visionOS streams, enforcing task rules, and logging traceable scores.

```mermaid
flowchart TB
    subgraph Client["visionOS Client"]
        STT["Speech-to-Text"]
        VK["VisionKit / CoreML"]
        UI["visionOS UI"]
        SD["SwiftData State"]
    end

    subgraph Backend["FastAPI Backend"]
        API["/process + /tasks"]
        Eval["/evaluate (Green)"]
        Store["Local JSON Storage"]
    end

    subgraph EvalLayer["Green Agent Assessor"]
        Assessor["State Matching + Action Assertions"]
    end

    STT --> UI
    VK --> UI
    UI --> SD
    SD --> API
    API --> Store
    Store --> Assessor
    Assessor --> Eval
```

**Green Agent Responsibilities:**
- **Sensing tier**: Speech-to-text, VisionKit/CoreML, and SwiftData surfaces feed a cohesive visionOS UI that captures operator intent and environment context
- **Control tier**: FastAPI routes /process and /tasks endpoints synchronize state, trigger evaluations, and persist JSON artifacts for auditability
- **Scoring tier**: State-matching plus action assertions convert observations into pass/fail decisions with explainable logs

**Flow:**
1. Capture multi-modal cues on visionOS and persist via SwiftData
2. Forward context to FastAPI for task orchestration and storage
3. Route triggers through the green assessor to verify state and actions
4. Emit evaluation verdicts back to the client and judging platform

### Purple Agent (Assessee)

The purple agent simulates the challenger agent that the green referee evaluates, exercising A2A/MCP integrations and providing stress-test scenarios.

```mermaid
flowchart TB
    subgraph PurpleAgent["Purple Agent (Assessee)"]
        Reason["Reasoning Loop"]
        Tools["Tool Calls (A2A/MCP)"]
        Memory["Short-Term Memory"]
    end

    subgraph Assessor["Assessor Agent (Green Winner)"]
        Kickoff["Kickoff Script"]
        Score["Scoring Logic"]
        Trace["Trace Logging"]
    end

    subgraph Platform["AgentBeats Platform"]
        A2A["A2A Server"]
        MCP["MCP Tool Layer"]
        Registry["Agent Registry"]
    end

    Kickoff --> PurpleAgent
    PurpleAgent --> Tools
    Tools --> MCP
    PurpleAgent --> Assessor
    Assessor --> Score
    Score --> Trace
    PurpleAgent --> Registry
```

**Purple Agent Responsibilities:**
- **Reasoning core**: Reasoning loop formulates plans, selects tools, and updates short-term memory to mimic real agent behavior
- **Tooling**: A2A/MCP tool calls stress-test platform integrations while feeding the judge with execution traces
- **Registry & scoring**: Agent registry registration and trace logging enable the green winner to score every interaction

**Flow:**
1. Kickoff script seeds the purple agent with evaluation objectives
2. Reasoning loop iterates, invoking tools through A2A/MCP layers
3. Interactions stream to the assessor for scoring and trace capture
4. Registry entry plus trace log closes the loop for judges

## Project Structure

```
CYRA-AgentBeatsHackathon/
├── README.md
├── docs/
│   ├── architecture.md
│   ├── evaluation-rubric.md
│   └── api-reference.md
├── client/
│   ├── visionOS/
│   │   ├── ContentView.swift
│   │   ├── SpeechManager.swift
│   │   ├── VisionManager.swift
│   │   └── SwiftDataModels.swift
│   └── shared/
│       ├── Models.swift
│       └── Networking.swift
├── backend/
│   ├── app/
│   │   ├── main.py
│   │   ├── api/
│   │   │   ├── __init__.py
│   │   │   ├── process.py
│   │   │   ├── tasks.py
│   │   │   └── evaluate.py
│   │   ├── core/
│   │   │   ├── __init__.py
│   │   │   ├── assessor.py
│   │   │   ├── scoring.py
│   │   │   └── storage.py
│   │   └── models/
│   │       ├── __init__.py
│   │       ├── task.py
│   │       ├── evaluation.py
│   │       └── trace.py
│   ├── requirements.txt
│   └── Dockerfile
├── agents/
│   ├── green/
│   │   ├── __init__.py
│   │   ├── referee.py
│   │   ├── validators/
│   │   │   ├── __init__.py
│   │   │   ├── state_matcher.py
│   │   │   └── action_assertions.py
│   │   └── scoring/
│   │       ├── __init__.py
│   │       └── deterministic_scorer.py
│   └── purple/
│       ├── __init__.py
│       ├── challenger.py
│       ├── reasoning/
│       │   ├── __init__.py
│       │   ├── planner.py
│       │   └── memory.py
│       └── tools/
│           ├── __init__.py
│           ├── a2a_client.py
│           └── mcp_tools.py
├── evaluation/
│   ├── datasets/
│   │   ├── visionos_scenarios.json
│   │   └── task_definitions.json
│   ├── scripts/
│   │   ├── run_evaluation.py
│   │   └── generate_report.py
│   └── results/
│       └── .gitkeep
├── tests/
│   ├── unit/
│   │   ├── test_assessor.py
│   │   ├── test_scoring.py
│   │   └── test_agents.py
│   ├── integration/
│   │   ├── test_api.py
│   │   └── test_e2e.py
│   └── fixtures/
│       ├── sample_tasks.json
│       └── mock_traces.json
└── scripts/
    ├── setup.sh
    ├── run_locally.sh
    └── deploy.sh
```

## Installation

```bash
# Clone the repository
git clone https://github.com/erinjerri/CYRA-AgentBeatsHackathon.git
cd CYRA-AgentBeatsHackathon

# Setup backend
cd backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt

# Setup visionOS client (requires Xcode 15+ and visionOS simulator)
cd ../client/visionOS
open CYRA.xcodeproj
```

## Usage

### Running the Backend
```bash
cd backend
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### Running the visionOS Client
1. Open `CYRA.xcodeproj` in Xcode
2. Select the visionOS simulator as target
3. Build and run (Cmd+R)

### Running Evaluations
```bash
cd evaluation
python scripts/run_evaluation.py --dataset visionos_scenarios.json
```

## Evaluation Rubric

The CYRA framework evaluates agents across these dimensions:

1. **State Matching Accuracy** - How well the agent state aligns with expected checkpoints
2. **Action Compliance** - Validity and safety of tool usage and timing
3. **Trace Completeness** - Quality and completeness of execution logs
4. **Multi-modal Integration** - Effective use of speech, vision, and context data
5. **Deterministic Scoring** - Consistency and verifiability of evaluation outcomes

# To-Do List
## 🟩 Part 1 — Green Agent Hackathon (Current Submission)

| Time / Part                                        | Task Description                                                                                                                                                                                                                                                                                                                                 | Done |
|----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------|
| Part 1                                  | Refactor architecture to match updated project tree. Define STT → Task creation and VisionKit/CoreML → Task creation. Update Mermaid diagrams to reflect A2A protocol + state matching. Set up local FastAPI backend with file telemetry store. Test endpoints with curl/Postman.                                                               |  ✅
Completed |
| Part 1                                             | Implement STT → Task creation pipeline in Swift. Implement VisionKit/CoreML → Task creation pipeline. Add OpenAI + Apple FM hooks for intent extraction. Test both flows locally.                                                                                                                                                                |      |
| Part 1                                             | Deploy FastAPI backend to Lambda.ai. Install deps, run server. Connect Swift → backend (AgentStateSyncService.swift). Test end-to-end: speech/image → task JSON → backend → local state file.                                                                                                                                                    |      |
| Part 1                                             | Implement A2A protocol v1: Assessor simulates user; multi-round reasoning; prompts for daily task scenarios. Add `/evaluate` endpoint for state matching. Run sample benchmarks.                                                                                                                                                                 |      |
| Part 1                                             | Update README + `benchmark_design.md` with: A2A protocol; State matching; Action assertions; STT + CV multimodal flows. Commit/push.                                                                                                                                                                                                             |      |
| Part 1                                             | Implement rubrics: `state_matching.py`; `action_assertions.py`. Run multi-trial benchmarks for Green Agent.                                                                                                                                                                                                                                      |      |
| Part 1                                             | Spatial enhancements: `ImmersiveControlSpace.swift`; gesture/gaze stubs. Test on Vision Pro simulator.                                                                                                                                                                                                                                          |      |
| Part 1                                             | Finalize architecture diagrams + `system.mmd`. Update README with: A2A protocol; multimodal task creation; evaluation rubric.                                                                                                                                                                                                                    |      |
| Part 1          | Record 3‑min demo video: 1 min abstract + architecture; 1 min Green Agent demo (STT + CV task creation). Screen record Xcode simulator + backend logs.                                                                                                                                                                                           |      |
| Part 1             | Upload video to YouTube (unlisted). Add link to README + submission form.                                                                                                                                                                                                                                                                         |      |
| Part 1               | Fill hackathon form: Abstract; GitHub link; Video URL. Double-check requirements. Shut down instance.                                                                                                                                                                                                                                             |      |
| Jan 15, 4:00–11:59 PM                              | Buffer for last-minute fixes + final submission.                                                                                                                                                                                                                                                                                                  |      |

# To-Do List - Purple Agent (2nd half of hackathon)
## 🟪 Part 2 — Purple Agent (Post‑Hackathon Expansion)

| Component                                           | Task Description                                                                                                                                                                                                                                                                                                                                 | Done |
|-----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------|
| Purple Agent — Architecture                        | Define Purple Agent role: assessee agent competing against top Green Agents. Review A2A protocol requirements (input modes, output modes, tool-call structure). Identify which Green Agent tasks your Purple Agent must solve.                                                                                                                    |      |
| Purple Agent — Assessee Agent Impl                 | Implement Purple Agent as an A2A-compatible assessee agent. Add reasoning loop, memory, and tool-use stubs. Ensure compatibility with AgentBeats assessor agents.                                                                                                                                                                                  |      |
| Purple Agent — Assessor Agent Impl                 | Implement assessor agent for your chosen evaluation track. Add kickoff logic, scoring logic, and multi-step evaluation flow. Ensure it can run assessments end-to-end.                                                                                                                                                                             |      |
| Purple Agent — Kickoff Script                      | Build kickoff script to send initial message to assessor agent. Include task_config, environment selection, user strategy, and model provider. Validate that Purple Agent responds with READY.                                                                                                                                                     |      |
| Purple Agent — Tooling (MCP / A2A Tools)           | Add MCP tool definitions (if needed). Ensure Purple Agent can request tools via A2A-compliant `<tool>` and `<args>` tags. Validate tool-call correctness.                                                                                                                                                                                         |      |
| Purple Agent — Evaluation Metrics                  | Implement scoring: state matching, action correctness, multi-step reasoning quality, tool-use correctness. Align with AgentBeats rubric expectations (reproducible, deterministic, multi-level trace logging).                                                                                                                                     |      |
| Purple Agent — Reproducibility                     | Add auto-reset, deterministic seeds, and trace logging. Ensure assessments can be replayed. Package logs in `.eval_sessions` format.                                                                                                                                                                                                              |      |
| Purple Agent — Hosting & Deployment                | Package Purple Agent for hosting on AgentBeats platform. Add agent card TOML, expose via A2A server, ensure remote accessibility. Validate with A2A Inspector.                                                                                                                                                                                    |      |
| Purple Agent — Agent Registry Submission           | Prepare agent card metadata (name, description, capabilities, skills). Submit Purple Agent to AgentBeats Agent Registry. Validate that your agent appears in registry and can be discovered by assessor agents.                                                                                                                                     |      |
| Purple Agent — Integration Testing                 | Run full assessment: kickoff → assessee agent → assessor agent → scoring → trace logs. Validate multi-step reasoning, tool calls, and final metrics.                                                                                                                                                                                               |      |
| Purple Agent — Leaderboard Prep                    | Ensure your Purple Agent produces valid metrics for ranking. Test on hosted environment. Validate that your agent can compete on public leaderboard.                                                                                                                                                                                               |      |
| Purple Agent — Documentation                       | Update README with: Purple Agent architecture, A2A interface, MCP tools, evaluation rubric, reproducibility guarantees, hosting instructions, registry link.                                                                                                                                                                                       |      |
| Purple Agent — Final Submission                    | Prepare final submission: GitHub repo, agent card, hosted endpoint, registry link, demo video. Submit by Feb 22–23 deadline.                                                                                                                                                                                                                       |      |
## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- AgentBeats Hackathon organizers for the evaluation framework.
- Apple visionOS team for the platform and tools.
- OpenAI for the agent evaluation insights.
- Lambda.ai for the sponsored cloud storage

## Citation

If you use CYRA in your research, please cite:

```bibtex
@software{cyra_agentbeats_2025,
  title={CYRA: Vision-Native Agent Evaluation Framework for AgentBeats},
  author={Erin Jerri},
  year={2025},
  url={https://github.com/erinjerri/CYRA-AgentBeatsHackathon}
}
```

---

> [!NOTE]  
> This README follows GitHub's best-practice recommendations for structure, clarity, and completeness. <CitationPill url="https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes" />
>