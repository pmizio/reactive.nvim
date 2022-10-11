| Status | Request                         |
| ------ | ------------------------------- |
| ✅     | textDocument/completion         |
| ✅     | textDocument/hover              |
| ✅     | textDocument/rename             |
| ✅     | textDocument/publishDiagnostics |
| ✅     | textDocument/signatureHelp      |
| ✅     | textDocument/references         |
| ✅     | textDocument/definition         |
| ✅     | textDocument/typeDefinition     |
| ✅     | textDocument/implementation     |
| ✅     | textDocument/documentSymbol     |
| ✅     | textDocument/documentHighlight  |
| ✅     | textDocument/codeAction         |
| ✅     | textDocument/formatting         |
| ✅     | textDocument/rangeFormatting    |
| ⏳     | callHierarchy/incomingCalls     |
| ⏳     | callHierarchy/outgoingCalls     |
| ⏳     | workspace/symbol - IDK yet      |
| ❓     | workspace/applyEdit - IDK yet   |
| ❌     | textDocument/declaration - N/A  |
| ❌     | window/logMessage - N/A         |
| ❌     | window/showMessage - N/A        |
| ❌     | window/showMessageRequest - N/A |

```
 NeoVim                                                    Tsserver Magic
┌────────────────────────────────────────────┐            ┌────────────────┐
│                                            │            │                │
│  LSP Loop              Tsserver Loop       │            │                │
│ ┌─────────┐           ┌──────────────────┐ │            │                │
│ │         │           │                  │ │            │                │
│ │         │ Request   │ ┌──────────────┐ │ │            │                │
│ │         ├───────────┤►│ Translation  │ │ │            │                │
│ │         │ Response  │ │    Layer     │ │ │            │                │
│ │         ◄───────────┼─┤              │ │ │            │                │
│ │         │           │ └───┬─────▲────┘ │ │            │                │
│ │         │           │     │     │      │ │            │                │
│ │         │           │ ┌───▼─────┴────┐ │ │ Request    │                │
│ │         │           │ │   I/O Loop   ├─┼─┼────────────►                │
│ │         │           │ │              │ │ │ Response   │                │
│ │         │           │ │              ◄─┼─┼────────────┤                │
│ │         │           │ └──────────────┘ │ │            │                │
│ │         │           │                  │ │            │                │
│ └─────────┘           └──────────────────┘ │            │                │
│                                            │            │                │
└────────────────────────────────────────────┘            └────────────────┘
```
