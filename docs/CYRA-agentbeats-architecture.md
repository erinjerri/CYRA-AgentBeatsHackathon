# System architecture 

Graphic using Mermaid.js

config:
  layout: dagre
---
flowchart TB
 subgraph Client_Spatial_Env["visionOS Client Environment"]
        User(("User"))
        STT["Speech-to-Text <br>Voice Transcription"]
        VK["VisionKit / CoreML <br>Visual Context Capture"]
        VP["visionOS App UI <br>Immersive/Windowed Spaces"]
        SD[("SwiftData Persistence <br>Local World State")]
        AI["Swift AppIntents <br>Native Tool Interface"]
  end
 subgraph AgentBeats_Platform["Evaluation & Control Layer"]
        Green["Green Agent <br>Assessor / Judge"]
        Purple["Purple Agent <br>Assessee / Solver"]
        Ctrl["AgentBeats Controller <br>SDK / Earthshaker"]
  end
 subgraph Backend_Bridge["Infrastructure & Tooling Layer"]
        FastAPI["FastAPI Backend <br>A2A Server Interface"]
        MCP["MCP Server <br>Dynamic Tool Discovery"]
        Ampersend["Ampersend SDK <br>Edge &amp; Node Finance"]
  end
 subgraph Cloud_Telemetry["Lambda.ai Cloud"]
        TeleStore[("Lambda.ai Store <br>JSON Trajectory Logs")]
  end
    User -- Voice/Visual Intent --> STT & VK
    STT -- Raw Context --> VP
    VK -- Raw Context --> VP
    VP <-- Internal State --> SD
    SD <-- "3. State Sync: JSON" --> FastAPI
    AI --- VP