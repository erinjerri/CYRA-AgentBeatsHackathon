# Dev Log

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