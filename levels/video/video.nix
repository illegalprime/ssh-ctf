{ runCommand, ffmpeg, flag }:

runCommand "flag-video" {} ''
  mkdir -p $out

  ${ffmpeg}/bin/ffmpeg \
    -f lavfi \
    -i color=c=blue:s=1920x1080:d=5 \
    -i ${./believe.png} \
    -filter_complex "\
      [0:v][1:v] overlay, \
      drawtext=fontsize=60:x=(w-text_w)/2:y=25:box=1:text=${flag}" \
    $out/flag.mp4
''
