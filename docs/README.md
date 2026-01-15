# CYRA-AgentBeatsHackathon
Create Your Reality Agent - App - v1 prototype for AgentBeats Hackathon - 2025-2026 - Green Agent

# Abstract
Create Your Reality Agent (CYRA): Spatial Computing / AR–VR Agent Benchmark

Create Your Reality Agent (CYRA) is a spatial-computing-native Green Agent benchmark built to evaluate embodied agent behavior in immersive AR/VR environments, following the design principles outlined in Establishing Best Practices for Building Rigorous Agentic Benchmarks (Zhu et al., 2025) and the AgentBeats Agentified Agent Assessment (AAA) framework.

Existing agent benchmarks such as OSWorld, WebArena, and τ-bench primarily evaluate agents through browser-based or API-centric tasks. CYRA extends this evaluation paradigm into spatial computing, measuring how agents perceive, reason, and act within 3D, multimodal interfaces while introducing spatial task competency as a first-class evaluation dimension.

CYRA is implemented initially on Apple Vision Pro (visionOS), combining:
	•	Swift-based spatial UI for immersive/Windowed spaces
	•	WebKit-constrained task scaffolds
	•	Speech-driven function calling for voice intent
	•	CoreML/VisionKit for visual context capture
	•	SwiftData/CoreData as the local persistent state layer
	•	Swift AppIntents as a native tool interface
	•	FastAPI as a backend bridge to coordinate state, telemetry, and A2A-compliant interactions with the AgentBeats platform

Structured task representations, agent actions, and full-trace telemetry are persisted via lambda.ai cloud storage, enabling reproducible replay, deterministic scoring, and post-hoc analysis. The system is designed with cross-platform abstractions, with Meta Quest devices supported in the second phase of the hackathon to enable Purple Agent evaluations beyond Vision Pro.

The hackathon proceeds in two phases:
	•	Phase 1 — Green Agent: CYRA evaluates productivity-focused workflows, such as task creation, task completion, document summarization, and spatial organization. The Green Agent acts as the environment manager, proctor, and evaluator, ensuring deterministic execution and reproducible scoring.
	•	Phase 2 — Purple Agent: A competing agent interacts with the Green Agent to execute finance-oriented or transactional workflows, including AP2-inspired simulated app purchases and structured reasoning tasks. This phase emphasizes cross-platform compatibility and A2A protocol interoperability.

Each benchmark run captures complete telemetry across:
	•	Speech input
	•	Vision/intent parsing
	•	Function-call sequences
	•	Spatial interactions
	•	Local and cloud state transitions

Evaluation is performed using state-matching rubrics comparing persisted app state, ledger entries, and task outcomes against explicit goal states. Metrics include task success rate, spatial accuracy, function-call correctness, latency, error recovery, and robustness across repeated trials.

CYRA, together with its complementary Purple Assessor Agent, forms a reusable, extensible benchmark template for evaluating agentic performance in embodied, multimodal, and cross-platform AR/VR environments. Developed under a rapid hackathon timeline, the project emphasizes transparency, modularity, and clearly documented limitations, while providing a foundation for future benchmarks in spatial computing and immersive AI systems.

# Overview CYRA Tree

├── visionOS_App/                   # --- [SPATIAL ENVIRONMENT (SWIFT)] ---
│   ├── SpatialAgentApp.swift       # Entry point; initializes DataHandler & ImmersiveSpace [7]
│   ├── ImmersiveControlSpace.swift # 3D environment for agentic "Computer Use" visualization [8]
│   ├── Models/                     # --- SwiftData / Persistence Layer ---
│   │   ├── TaskModel.swift         # PRIMARY: Schema for Daily Tasks (ID, Title, Priority, Status) [6]
│   │   └── TransactionModel.swift  # ROADMAP: Schema for Financial Records (Amount, AP2 Status) [9]
│   ├── DataBridge/                 # --- Networking & A2A Synchronization ---
│   │   ├── AgentStateSyncService.swift # Bi-directional bridge to sync SwiftData with FastAPI [2, 3]
│   │   └── AP2PaymentHandler.swift # ROADMAP: Manages AP2/Ampersend transaction signing
│   └── Views/                      # --- Immersive UI Components ---
│       ├── MainDashboardView.swift # Central 2D window for calendar/to-do monitoring
│       ├── TaskDetailView.swift    # View for inspecting specific agent-created tasks
│       └── FinanceOverlayView.swift# ROADMAP: Secure spatial window for payment confirmation
│
├── backend/                        # --- [DATA HANDLER & A2A SERVER (FASTAPI)] ---
│   ├── main.py                     # Entry point; wraps app with AgentBeats Controller [7, 10]
│   ├── api/                        # REST/WebSocket endpoints for visionOS state sync
│   └── services/                   # Pydantic-based business logic for "World State"
│
├── agent_bench/                    # --- [EVALUATION ENGINE (AGENTBEATS)] ---
│   ├── primary_assessor/           # GREEN AGENT: The Task Creator Evaluator [11, 12]
│   │   ├── executor.py             # Multi-round reasoning and user simulation logic [13, 14]
│   │   └── prompts.py              # System prompts for "Daily Task" agentic scenarios [13, 15]
│   ├── secondary_assessor/         # ROADMAP: The Finance Evaluator (AP2/Ampersend)
│   ├── rubrics/                    # --- Programmatic Success Metrics ---
│   │   ├── state_matching.py       # Compares visionOS DB to annotated goal states [4, 5]
│   │   └── action_assertions.py    # Verifies tool-use correctness via MCP [16]
│   └── data_gen/                   # Synthetic scenario generation for tasks [5, 16]
│
├── tools/                          # --- [TOOL LAYER] ---
│   └── mcp_server.py               # MCP server for dynamic discovery of app functions [13, 17]
│
├── config/                         # --- [METADATA] ---
│   ├── agent_card.toml             # Required for AgentBeats Registry discovery [2, 18]
│   └── ap2_settings.yaml           # ROADMAP: Credentials for Ampersend SDK
│
├── requirements.txt                # Python dependencies (earthshaker, fastapi, google-adk) [10]
├── run.sh                          # CLI: pip install earthshaker && python main.py run [10]
├── Procfile                        # DEPLOYMENT: web: agentbeats run_ctrl [19]
└── README.md                       # Documentation on Tech Stack & agentic reasoning

# To-Do List
# AgentBeats Hackathon — To‑Do Timeline (Green Agent + LedgerFlow)

| Time Slot | Task Description | Check-off |
|----------|------------------|-----------|
# AgentBeats Hackathon — To‑Do Timeline (Green Agent + LedgerFlow)

Repo: https://github.com/erinjerri/CYRA-AgentBeatsHackathon

| Time Slot                                           | Task Description                                                                                                                                                                                                                                                                                                                                                                      | Check-off |
|-----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| Day 1 (1.5 hrs)                                    | Refactor architecture to match updated project tree. Define the two core interaction modalities: STT → Task creation; Image capture (VisionKit/CoreML) → Task creation. Update Mermaid diagrams to reflect A2A protocol + state matching. Set up local FastAPI backend with in-memory/file telemetry store. Test endpoints with curl/Postman.                                          | [x]       |
| Part 1                                             | Implement STT → Task creation pipeline in Swift. Implement VisionKit/CoreML → Task creation pipeline. Add OpenAI + Apple Foundation Models hooks for intent extraction. Test both flows locally (no backend yet).                                                                                                                                                                      | [ ]       |
| Part 1                                             | Deploy FastAPI backend to Lambda.ai. SSH, install deps, run server. Connect Swift → backend (AgentStateSyncService.swift). Test end-to-end: speech/image → task JSON → backend → local state file.                                                                                                                                                                                     | [ ]       |
| Part 1                                             | Implement A2A protocol v1: Assessor simulates user/merchant; Multi-round reasoning (executor.py); Prompts for daily task scenarios. Add `/evaluate` endpoint for state matching. Run sample benchmarks (tasks.json).                                                                                                                                                                   | [ ]       |
| Part 1                                             | Update README + `benchmark_design.md` with: A2A protocol; State matching; Action assertions; STT + CV multimodal flows. Commit/push.                                                                                                                                                                                                                                                  | [ ]       |
| Part 1                                             | Breakfast + review. Spin up Lambda.ai instance.                                                                                                                                                                                                                                                                                                                                       | [ ]       |
| Optional – Finance Agent                           | Build LedgerFlow (iOS finance agent). Integrate Ampersend SDK (mock AP2 handshake). Implement: Check Balance; Signature Request; Pending Transaction. Test simulated purchase flow (no real Apple Pay).                                                                                                                                                                              | [ ]       |
| Part 2                                             | Implement rubrics: `state_matching.py` (visionOS DB vs goal state); `action_assertions.py` (tool-use correctness). Run multi-trial benchmarks for Green Agent + LedgerFlow.                                                                                                                                                                                                           | [ ]       |
| Part 2                                             | Spatial enhancements: `ImmersiveControlSpace.swift`; Gesture/gaze stubs. Test on Vision Pro simulator/device. If Vision Pro fails → fallback to Meta Quest (WebXR + WebKit logging).                                                                                                                                                                                                  | [ ]       |
| Part 2                                             | Finalize architecture diagrams + `system.mmd`. Update README with: A2A protocol; AP2 handshake simulation; Multimodal task creation; Evaluation rubric.                                                                                                                                                                                                                               | [ ]       |
| Part 2                                             | End-to-end testing: Green Agent (task creation via STT + CV); LedgerFlow (AP2/Ampersend mock purchase). Collect telemetry + evaluation results. Shut down instance.                                                                                                                                                                                                                   | [ ]       |
| Part 3                                             | Run full benchmark suite across trials. Test edge cases: Declined card; Invalid AP2 signature; Missing balance check. Fix bugs.                                                                                                                                                                                                                                                       | [ ]       |
| Part 3 – Jan 15, 11:30 AM–12:30 PM (1 hr)          | Record 3‑min demo video: 1 min abstract + architecture; 1 min Green Agent demo (STT + CV task creation); 1 min LedgerFlow AP2 handshake simulation. Screen record Xcode simulator + backend logs.                                                                                                                                                                                    | [ ]       |
| Part 3 – Jan 15, 12:30–1:00 PM (0.5 hr)            | Upload video to YouTube (unlisted). Add link to README + submission form.                                                                                                                                                                                                                                                                                                             | [ ]       |
| Part 3 – Jan 15, 2:00–4:00 PM (2 hrs)              | Fill hackathon form: Abstract; GitHub link; Video URL. Double-check requirements. Shut down instance.                                                                                                                                                                                                                                                                                 | [ ]       |
| Jan 15, 4:00–11:59 PM                              | Buffer for last-minute fixes + final submission.                                                                                                                                                                                                                                                                                                                                      | [ ]       |