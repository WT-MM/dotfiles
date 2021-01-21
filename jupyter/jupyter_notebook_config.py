# Configuration file for ipython-notebook.

import platform
from pathlib import Path


# ----------------
# Helper functions
# ----------------


def set_notebook_directory(directory: str) -> None:
    path = Path(directory).expanduser()
    path.mkdir(exist_ok=True)
    c.NotebookManager.notebook_dir = c.NotebookApp.notebook_dir = str(path)


# -----
# MacOS
# -----


def jupyter_notebook_config_macos() -> None:
    set_notebook_directory("~/Notebooks")
    c.NotebookApp.port = 9905


# -----
# Linux
# -----


def jupyter_notebook_config_linux() -> None:
    set_notebook_directory("~/notebooks")
    c.NotebookApp.open_browser = False
    c.NotebookApp.port = 9906


system = platform.system()
if system == "Linux":
    jupyter_notebook_config_linux()
elif system == "Darwin":
    jupyter_notebook_config_macos()
else:
    raise RuntimeError(f"System config not supported: {system}")