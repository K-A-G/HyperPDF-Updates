# HyperPDF Reader – GitHub Update Server

This folder is the starter content for the public repository:

`https://github.com/K-A-G/HyperPDF-Updates`

HyperPDF reads the manifest from:

`https://raw.githubusercontent.com/K-A-G/HyperPDF-Updates/main/update_manifest.json`

## First-time setup

1. Keep the repository public so HyperPDF installations can read the manifest without a GitHub account.
2. Use `main` as the default branch (or update `UPDATE_MANIFEST_URL` in HyperPDF if the branch name is different).
3. Copy `update_manifest.template.json` only as a reference; do not publish it as `update_manifest.json` because it contains placeholders.
4. Build a new installer and give the release a semantic version such as `0.1.15`.
5. Create a GitHub Release with tag `v0.1.15` and upload the installer `.exe` asset.
6. Run `generate_update_manifest.ps1` to calculate the exact SHA-256 and produce `update_manifest.json`.
7. Commit the generated `update_manifest.json` to the repository root on `main`.

**Important:** Publish the Release asset first and the manifest last. Never publish a placeholder SHA-256 or a manifest that points to a missing installer.

## Generate a manifest

Run PowerShell in this folder (or pass a full output path):

```powershell
.\generate_update_manifest.ps1 `
  -Version "0.1.15" `
  -InstallerPath "C:\HyperPDF\release\HyperPDF_Reader_Setup.exe" `
  -ReleaseNotes "Improved startup, text editor and Explorer PDF preview."
```

The installer asset URL is built as:

`https://github.com/K-A-G/HyperPDF-Updates/releases/download/v0.1.15/HyperPDF_Reader_Setup.exe`

Upload the same file under exactly that name to the Release.

## Release cadence

For each release:

- Increase `APP_VERSION` in HyperPDF's `app/config.py`.
- Keep `installer/HyperPDF.iss` `AppVersion` and `VersionInfoProductVersion` synchronized.
- Build the installer and upload it to a new GitHub Release/tag.
- Generate and commit the matching `update_manifest.json`.

HyperPDF checks automatically 10 seconds after its main window appears and then at most once per 24 hours. If a newer version exists, the app asks whether to open the updater. Downloading and installation still require explicit user confirmation. Help → Check for Updates remains available for manual checks.
