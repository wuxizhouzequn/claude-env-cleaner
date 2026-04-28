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

## Completed Output

When the cleanup is running or has completed, the window will show messages like this:

```text
Clearing Claude/Anthropic environment variables...

Removed user variable:   ANTHROPIC_AUTH_TOKEN
Removed user variable:   ANTHROPIC_BASE_URL

Done. Open a new PowerShell window before running claude.
Press Enter to close
```

If you only see one removed variable, it usually means only that variable existed in your user environment. That is normal. The script still checks both variables.

## 中文说明

这是一个 Windows 一键清理工具，用于删除可能影响 Claude Code 第三方 API 配置的环境变量：

- `ANTHROPIC_AUTH_TOKEN`
- `ANTHROPIC_BASE_URL`

直接双击 `Clear-Claude-Anthropic-Env-OneClick.cmd` 即可。运行完成后，需要重新打开 PowerShell，再运行 `claude`。

## 运行完成时的样子

运行完成时，窗口会显示类似下面的内容：

```text
Clearing Claude/Anthropic environment variables...

Removed user variable:   ANTHROPIC_AUTH_TOKEN
Removed user variable:   ANTHROPIC_BASE_URL

Done. Open a new PowerShell window before running claude.
Press Enter to close
```

如果截图里只显示清除了 `ANTHROPIC_AUTH_TOKEN`，通常说明当前电脑上只有这个变量存在；脚本仍然会继续检查 `ANTHROPIC_BASE_URL`。清理完成后，必须重新打开 PowerShell，旧窗口里的环境变量不会自动刷新。

## Notes

- This script does not edit Claude Code settings files.
- This script does not remove API keys from provider dashboards.
- Already-open terminals keep their old environment values. Open a new terminal after running it.

## License

MIT
