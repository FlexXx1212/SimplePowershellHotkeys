$Signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
    public static extern short GetAsyncKeyState(int virtualKeyCode); 
'@
Add-Type -MemberDefinition $Signature -Name Keyboard -Namespace PsOneApi
$pressed = -32767
while($true) {
    $text = ""

    for($i = 112;$i -le 123; $i++) {
        if([PsOneApi.Keyboard]::GetAsyncKeyState($i) -eq $pressed) { 
            try { 
                $filename = $i - 111
                $text = Get-Content "$PSScriptRoot\$filename.txt" -ErrorAction SilentlyContinue
                if([String]::IsNullOrWhiteSpace($text) -eq $false) {
                    $text | Set-Clipboard 
                }
            } catch {}
        }
    }    
}
