# GitHub Secret Sync

Sync environment variable file (.env) to GitHub Secrets.
This CLI tool only automate GitHub CLI commands.
This tool is not affiliated with GitHub.

## Install
Clone this repo 😇

## Requirement
You have to install GitHub CLI and login to you account.

## Usage
### Basic
Sync `.env` in the current folder with secrets in the specified GitHub repository.

```bash
 ./sync_secrets.rb --repo username/your_repo
 ```
### Custom
Options:
- `--file`: specify file path 
- `--prefix`: add a prefix to each env var
```bash
 ./sync_secrets.rb --file .env --repo username/your_repo --prefix DEV_
 ```