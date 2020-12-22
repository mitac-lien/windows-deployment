
$bin_dir = "$env:USERPROFILE\bin"
$mjpeg_server_bin = "$bin_dir\MJPEGServer.exe"
$ffmpeg_bin = "$bin_dir\ffmpeg-N-100449-g28aedc7f54-win64-gpl\bin\ffmpeg.exe"

if ( -not (Test-Path "$mjpeg_server_bin") ) {
    $zip_path = "$env:TMP\mjpeg-server-windows-amd64.zip"
    
    if (-not (Test-Path "$zip_path")) {
        $bin_url = "https://github.com/blueimp/mjpeg-server/releases/download/v1.3.0/mjpeg-server-windows-amd64.zip"
        Invoke-Webrequest -Uri "$bin_url" -OutFile "$zip_path"
    }
    
    Expand-Archive -LiteralPath "$zip_path" -DestinationPath "$bin_dir"
    Remove-item "$zip_path"
}

if ( -not (Test-Path "$ffmpeg_bin") ) {
    $zip_path = "$env:TMP\ffmpeg-N-100449-g28aedc7f54-win64-gpl.zip"
    
    if (-not (Test-Path "$zip_path")) {
        $bin_url = "https://github.com/BtbN/FFmpeg-Builds/releases/download/autobuild-2020-12-21-12-38/ffmpeg-N-100449-g28aedc7f54-win64-gpl.zip"
        Invoke-Webrequest -Uri "$bin_url" -OutFile "$zip_path"
    }
    
    Expand-Archive -LiteralPath "$zip_path" -DestinationPath "$bin_dir"
    Remove-item "$zip_path"
}

# -r fps
# -q qscale(VBR)

& "$mjpeg_server_bin" -- "$ffmpeg_bin" `
  -loglevel error `
  -probesize 32 `
  -fpsprobesize 0 `
  -analyzeduration 0 `
  -fflags nobuffer `
  -f dshow `
  -rtbufsize 100M `
  -r 10 `
  -video_size 1280x720 `
  -i video="Logitech HD Webcam C310" `
  -f mpjpeg `
  -q 2 `
  -