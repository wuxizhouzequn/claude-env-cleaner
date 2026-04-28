# Claude Env Cleaner

A tiny Windows one-click tool for clearing Claude Code environment variables that can interfere with third-party Anthropic-compatible API providers.

## What It Clears

- `ANTHROPIC_AUTH_TOKEN`
- `ANTHROPIC_BASE_URL`

The tool removes user-level variables by default. If it finds system-level variables, it can relaunch with administrator permission and remove those too.

## Usage

1. Download `Clear-Claude-Anthropic-Env-OneClick.cmd`.
2. Double-click it.
3. If Windows asks for administrator permission, accept it only if you want to remove system-level variables.
4. Open a new PowerShell window before running `claude`.

## 中文说明

这是一个 Windows 一键清理工具，用于删除可能影响 Claude Code 第三方 API 配置的环境变量：

- `ANTHROPIC_AUTH_TOKEN`
- `ANTHROPIC_BASE_URL`

直接双击 `Clear-Claude-Anthropic-Env-OneClick.cmd` 即可。运行完成后，需要重新打开 PowerShell，再运行 `claude`。

## Notes

- This script does not edit Claude Code settings files.
- This script does not remove API keys from provider dashboards.
- Already-open terminals keep their old environment values. Open a new terminal after running it.

## License

MIT
