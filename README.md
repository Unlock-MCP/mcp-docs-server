# MCP Docs Server

A lightweight Model Context Protocol (MCP) server that provides direct access to local documentation files - a simple alternative to complex RAG pipelines for project-specific context.

## Overview

This MCP server reads a single markdown file (`context.md`) and exposes its contents through two simple tools:
- `get_context_overview()`: Lists all section titles
- `search_context(query)`: Searches content across all sections

Perfect for giving LLMs access to project documentation without the overhead of vector databases or embedding models.

## Features

- **Zero dependencies** beyond the MCP Python SDK
- **Lightning fast** - direct file access, no vector search
- **Simple setup** - works with both GUI and CLI MCP clients
- **Cross-platform** - includes shell wrapper for macOS/Linux compatibility
- **Robust error handling** - comprehensive logging and debugging support

## Installation

### Prerequisites

- Python 3.11+ 
- MCP client (Claude Desktop, cline, etc.)

### Setup

1. Clone this repository:
```bash
git clone https://github.com/unlock-mcp/mcp-docs-server.git
cd mcp-docs-server
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Create your documentation file:
```bash
# Create a context.md file in the project root with your documentation
echo "# My Project Docs\n\nThis is my documentation." > context.md
```

### Client Configuration

#### For Claude Desktop (GUI clients)

Use the shell wrapper for reliable execution:

1. Make the wrapper executable:
```bash
chmod +x run_context_server.sh
```

2. Install the server:
```bash
mcp install ./run_context_server.sh --name "docs-server"
```

#### For cline and CLI clients

Add to your MCP configuration file:

```json
{
  "mcpServers": {
    "docs-server": {
      "timeout": 60,
      "type": "stdio",
      "command": "/opt/homebrew/bin/python3.11",
      "args": [
        "/path/to/mcp-docs-server/mcp_context_server.py"
      ],
      "env": {}
    }
  }
}
```

*Note: Update the Python path to match your system (`which python3.11`)*

## Development

### Testing

Use the MCP development tools for easy testing:

```bash
mcp dev ./run_context_server.sh
```

This launches a web-based inspector for testing your server.

### Debugging

The server logs to stderr for debugging. Check your MCP client's logs if you encounter issues.

Common issues:
- **ENOENT errors**: Use the shell wrapper or specify full Python path
- **Import errors**: Ensure `mcp[cli]>=1.2.0` is installed
- **File not found**: Verify `context.md` exists in the project root

## File Structure

```
mcp-docs-server/
├── mcp_context_server.py      # Main server implementation
├── run_context_server.sh      # Shell wrapper for GUI clients
├── requirements.txt           # Python dependencies
├── context.md                 # Your documentation (create this)
└── README.md                  # This file
```

## Usage

Once configured, you can use these tools in your MCP client:

- **Get overview**: "What sections are available in the docs?"
- **Search content**: "Search for authentication in the docs"
- **Specific queries**: "How do I configure the database?"

## Tutorial

For a complete walkthrough of building this server from scratch, including common pitfalls and solutions, see the full tutorial: [Ditching RAG: Building a Local MCP Server for Your Docs](https://unlockmcp.com/guides/how-to-build-a-local-mcp-server-for-your-docs-a-complete-walkthrough/)

## Contributing

Contributions welcome! Please feel free to submit issues and pull requests.

## License

MIT License - see LICENSE file for details.

---

Built with ❤️ by the [UnlockMCP](https://unlockmcp.com) team.