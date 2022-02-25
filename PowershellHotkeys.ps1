$key_F1 = 112
$key_F2 = 113
$key_F3 = 114
$key_F4 = 115
$key_F5 = 116
$key_F6 = 117
$key_F7 = 118
$key_F8 = 119
$key_F9 = 120
$key_F10 =121
$key_F11 =122
$key_F12 =123

# this is the c# definition of a static Windows API method:
$Signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
    public static extern short GetAsyncKeyState(int virtualKeyCode); 
'@

# Add-Type compiles the source code and adds the type [PsOneApi.Keyboard]:
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
