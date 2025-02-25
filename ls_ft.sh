# ############################################################################ #
#                                  ls_ft BEGIN                                 #
# ############################################################################ #
# ⚠ Dependencies: eza, sed                                                    #
# ---------------------------------------------------------------------------- #
#   From current directory; lists content of current dir                      #
# Options: lsft,                                                               #
# ---------------------------------------------------------------------------- #
# This script is a collection of 4 main functionalities:                       #
# ---------------------------------------------------------------------------- #                                                                         
# list_specific_file_type_eza                                                  #
# list_files_sort_extension                                                    #
# list_files_sort_extension_hidden                                             #
# list_files_and_folders_sort_by_extensions                                    #
# ---------------------------------------------------------------------------- #
# Main aliases are listed below along with sets of alternative aliases:        #
# ############################################################################ #

# Main aliases
alias lsft="list_specific_file_type_eza" # list files by extension, requires an argument. For example: lsft .txt
alias sbft="list_files_sort_extension" # Sort by file type, also requires argument
alias lsfth="list_files_sort_extension_hidden" #Lits only files by extension including hidden files, requires argument.
alias lsfta="list_files_and_folders_sort_by_extensions" #require arguments

# Lists files by extension
alias lsfiles="list_specific_file_type_eza"
alias lsftype="list_specific_file_type_eza"
alias lsfiletype="list_specific_file_type_eza"
alias filetype="list_specific_file_type_eza"
alias ft="list_specific_file_type_eza"
alias lst="list_specific_file_type_eza"
alias lstype="list_specific_file_type_eza"

# List only files, sort by extension 
alias sortbytype="list_files_sort_extension"
alias sft="list_files_sort_extension"
alias sftype="list_files_sort_extension"
alias sftype="list_files_sort_extension"
alias lstype="list_files_sort_extension"

# List only files including hidden files, sort by extension
alias lstypeh="list_files_sort_extension_hidden"

# List files and folders and sort files by extensions
alias sortall="list_files_and_folders_sort_by_extensions"

# TODO: Add function that counts the total ammount of files of specific file
# type, and 2). Adds an appropriate icon with proper formattingo. And 3). A
# informational message  For more options do -f -a -b -c etc. 

# Formatting function as empty string is outputtet as blank line 
lsformat(){
echo ""
}

# Informational message at the end of lsf (List Files)
lsfecho() {
  echo -e "\n\033[1;37m  \033[38;5;250m Use \033[1;32mlsfa\033[38;5;250m to see hidden files.\033[0m\n"
}

# Informational message at the end of lsfh
lsfhidden(){
  echo -e "\n\033[1;37m  \033[38;5;250m Use \033[1;32mlsfh\033[38;5;250m to \033[1;4monly\033[0m hidden files.\033[0m\n"
}

# add_icons_to_files() {
#     eza_output=$(eza -1 --icons -a --only-files | sed -n '/^\./p')
#
#     while IFS= read -r file; do
#         # Use eza's output to add the correct icon to each file
#         # eza automatically displays icons based on file types, so we can capture the icon and filename
#         icon=$(echo "$file" | cut -d ' ' -f1)  # Capture the icon
#         filename=$(echo "$file" | cut -d ' ' -f2-)  # Capture the filename
#         echo "$icon $filename"  # Display the icon along with the filename
#     done <<< "$eza_output"
# }

# TODO: Write custom icon-set for each file type similar to eza 
add_icons_to_files() {
    eza -1 --icons -a --only-files | sed -n '/^\./p' | while IFS= read -r line; do
        echo "📄 $line"  # Add a custom emoji or text before each file
    done
}


# List specific file types. E.g., lsfiles .txtlsfh 
list_specific_file_type_eza() {
  if [[ -z "$1" ]]; then
    echo "Usage: listfiles <extension>"
    return 1
  fi

  # Remove leading dot if user includes it (normalize input)
  ext="${1#.}"

  # Check if any file has the given extension
  # Zsh globbing to find matching files
  matches=(*."$ext"(.N)) 

  if [[ ${#matches[@]} -eq 0 ]]; then
    echo "No files found with .$ext extension."
    return 1
  fi

  # Use eza if installed, otherwise fallback to ls
  if command -v eza &>/dev/null; then
    eza --icons --group-directories-first *."$ext"
  else
    ls -lh *."$ext"
  fi
}

# List only files (not folders nor files in folders) in current directory
list_files_sort_extension() {
  # Use eza if installed
  if command -v eza &>/dev/null; then
    eza --icons --only-files --color=always --sort=ext
  else
    # Fallback to ls + sort
    ls -lh --color=always | sort -k9 -t.
  fi
}

list_files_sort_extension_hidden() {
  # Use eza if installed
  if command -v eza &>/dev/null; then
    eza --icons --only-files --hidden --color=always --sort=ext
  else
    # Fallback to ls + sort
    ls -lh --color=always | sort -k9 -t.
  fi
}

list_files_and_folders_sort_by_extensions() {
  # Use eza if installed
  if command -v eza &>/dev/null; then
    eza --icons  --group-directories-first --color=always --sort=ext
  else
    # Fallback to ls + sort
    ls -lh --color=always | sort -k9 -t.
  fi
}

# lsfile() {
#   if [[ -z "$1" ]]; then
#     echo "Usage: listfiles <pattern>"
#     return 1
#   fi
#   printf "%s\n" *"$1"*
# }

# alias lsfall='list_all_files_in_current_directory'
# alias lsfilesall='list_all_files_in_current_directory'

# list_all_files_in_current_directory() {
#   if [[ -z "$1" ]]; then
#     echo "Usage: listfiles <pattern>"
#     return 1
#   fi
#   eza --ignore-glob="!*$1*" --icons --only-files
# }
