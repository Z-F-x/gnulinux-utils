# #############################################################################
#                           File Operations                                   #
# #############################################################################
#                                m o v e                                      #
# #############################################################################
# Alias for mvfiles
alias move-files="mvfiles"
alias move_files="mvfiles"
alias mv-files="mvfiles"

# Move all files (not folders) in current directory to path  
mvfiles() {
  if [[ -z "$1" ]]; then
    echo "Usage: movefiles <destination_folder>"
    return 1
  fi
  find . -maxdepth 1 -type f -exec mv {} "$1" \;
}

# Alias for mvall
alias move-all="mvall"
alias mv-all="mvall"
alias move_all="mvall"

# Move all files and folders in current directory to path
mvall() {
  if [[ -z "$1" ]]; then
    echo "Usage: moveall <destination_folder>"
    return 1
  fi
  mv -- * "$1"
}

# #############################################################################
#                          File System Navigation                             #
# #############################################################################
