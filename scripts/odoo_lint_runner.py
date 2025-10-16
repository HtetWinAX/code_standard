# pylint: skip-file
#!/usr/bin/env python
import sys
import subprocess
import pkg_resources

# Check Python version
py_version = sys.version_info
if py_version < (3, 11):
    print(
        "Warning: Python < 3.11 detected. Consider using Python 3.11 for Odoo linting."
    )


# Function to install packages if missing
def install_if_missing(pkg):
    try:
        pkg_resources.get_distribution(pkg)
        print(f"{pkg} already installed")
    except pkg_resources.DistributionNotFound:
        print(f"Installing {pkg}")
        subprocess.check_call(
            [sys.executable, "-m", "pip", "install", "--upgrade", pkg]
        )


# Install required packages
for pkg in ["black", "pylint", "pylint-odoo", "pyyaml"]:
    install_if_missing(pkg)
