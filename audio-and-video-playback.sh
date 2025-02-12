# ########################################################################### #
#                Media Playback Functions with fzf Selection                  #
# ########################################################################### #
# Requires fzf, cvlc, and ffpplay (FFmpg)

# Function to play video files using cvlc (VLC's command-line version)
vlc() {
  # If no argument is provided, launch fzf to select a video file.
  if [[ $# -eq 0 ]]; then
    # Find common video file types only in the current directory
    local file
    file=$(find . -maxdepth 1 -type f \( -iname '*.mp4' -o -iname '*.mkv' -o -iname '*.avi' -o -iname '*.mov' \) 2>/dev/null | fzf --prompt="Select a video file: ")
    # If a file was selected, play it.
    if [[ -n "$file" ]]; then
      cvlc --play-and-exit "$file"
    fi
  else
    # Otherwise, play the specified file(s) directly.
    cvlc --play-and-exit "$@"
  fi
}

# Function to play audio files using ffplay
play() {
  # If no argument is provided, launch fzf to select an audio file.
  if [[ $# -eq 0 ]]; then
    # Find common audio file types (including .wma) only in the current directory
    local file
    file=$(find . -maxdepth 1 -type f \( -iname '*.wma' -o -iname '*.mp3' -o -iname '*.wav' -o -iname '*.ogg' \) 2>/dev/null | fzf --prompt="Select an audio file: ")
    # If a file was selected, play it.
    if [[ -n "$file" ]]; then
      ffplay -nodisp -autoexit "$file"
    fi
  else
    # Otherwise, play the specified file(s) directly.
    ffplay -nodisp -autoexit "$@"
  fi
}

# ########################################################################### #
#                        Media Playback Functions END                         #  
# ########################################################################### #
