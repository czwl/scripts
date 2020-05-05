ffmpeg -y -i  -c:v libx264 -pix_fmt yuv420p -level 4.0 -refs 1 -x264opts b-pyramid=0:bluray-compat=1:interlaced=1:nal-hrd=vbr:aud=1 -maxrate 20M -bufsize 30M -c:a ac3 -b:a 128k
