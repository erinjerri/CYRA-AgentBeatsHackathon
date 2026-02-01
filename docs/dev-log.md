# Dev Log

## Repo tree snapshot (from terminal)

```text
├── agent.toml
├── backend
│   ├── __init__.py
│   ├── __pycache__
│   │   ├── __init__.cpython-313 2.pyc
│   │   ├── __init__.cpython-313.pyc
│   │   └── main.cpython-313.pyc
│   ├── api
│   │   ├── __init__.py
│   │   ├── __pycache__
│   │   └── tasks.py
│   ├── dockerfile
│   ├── main.py
│   ├── storage
│   │   ├── __pycache__
│   │   ├── storage.py
│   │   ├── tasks
│   │   └── telemetry
│   └── venv
│       ├── bin
│       ├── include
│       ├── lib
│       └── pyvenv.cfg
├── current_tree.txt
├── cyra-agentbeats
│   ├── Packages
│   │   └── RealityKitContent
│   ├── cyra-agentbeats
│   │   ├── AgentStateSyncService.swift
│   │   ├── AppModel.swift
│   │   ├── Assets.xcassets
│   │   ├── BackendConfig.swift
│   │   ├── BackendTask.swift
│   │   ├── ImmersiveView.swift
│   │   ├── Info.plist
│   │   ├── MainDashboard.swift
│   │   ├── SpatialAgentApp.swift
│   │   ├── TaskModel.swift
│   │   ├── TaskService.swift
│   │   └── cyra_agentbeatsApp.swift
│   ├── cyra-agentbeats.xcodeproj
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace
│   │   ├── xcshareddata
│   │   └── xcuserdata
│   └── cyra-agentbeatsTests
│       └── cyra_agentbeatsTests.swift
├── docs
│   ├── CYRA-agentbeats-architecture.md
│   ├── README.md
│   ├── agent.toml
│   ├── benchmark-design.md
│   ├── cyra-system-design-IA-diagram-mermaid-figma-v2.png
│   ├── dev-log.md
│   ├── telemetry-spec.md
│   └── to-do-list.md
├── requirements.txt
└── venv
    ├── bin
    │   ├── Activate 2.ps1
    │   ├── Activate.ps1
    │   ├── activate
    │   ├── activate.csh
    │   ├── activate.fish
    │   ├── dotenv
    │   ├── fastapi
    │   ├── pip
    │   ├── pip3
    │   ├── pip3.13
    │   ├── python -> python3.13
    │   ├── python3 -> python3.13
    │   ├── python3.13 -> /Library/Frameworks/Python.framework/Versions/3.13/bin/python3.13
    │   ├── uvicorn
    │   ├── watchfiles
    │   └── websockets
    ├── include
    │   └── python3.13
    ├── lib
    │   └── python3.13
    └── pyvenv.cfg
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