#!/bin/bash
# Shell wrapper for MCP docs server
# Executes the MCP server script with the correct Python interpreter

# Find the directory this script is in
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Try to find Python 3.11+ in common locations
PYTHON_CMD=""

# Check common locations for Python
for cmd in python3.11 python3.12 python3.13 python3.10 python3; do
    if command -v "$cmd" &> /dev/null; then
        # Verify it's Python 3.10+
        if "$cmd" -c "import sys; exit(0 if sys.version_info >= (3, 10) else 1)" 2>/dev/null; then
            PYTHON_CMD="$cmd"
            break
        fi
    fi
done

# If no suitable Python found, try absolute paths
if [ -z "$PYTHON_CMD" ]; then
    for path in /opt/homebrew/bin/python3.11 /usr/local/bin/python3.11 /usr/bin/python3.11 /opt/homebrew/bin/python3 /usr/local/bin/python3; do
        if [ -x "$path" ]; then
            if "$path" -c "import sys; exit(0 if sys.version_info >= (3, 10) else 1)" 2>/dev/null; then
                PYTHON_CMD="$path"
                break
            fi
        fi
    done
fi

# Error if no Python found
if [ -z "$PYTHON_CMD" ]; then
    echo "ERROR: Could not find Python 3.10+ interpreter" >&2
    echo "Please install Python 3.10+ or update this script with the correct path" >&2
    exit 1
fi

# Execute the MCP server
exec "$PYTHON_CMD" "$SCRIPT_DIR/mcp_context_server.py" "$@"