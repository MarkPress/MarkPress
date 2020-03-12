@ECHO OFF
setlocal DISABLEDELAYEDEXPANSION
SET BIN_TARGET=%~dp0/../kzykhys/ciconia/bin/ciconia
php "%BIN_TARGET%" %*
