# ############################################################################ #
#                                ls_dynamic BEGIN                              #
# ############################################################################ #
# ⚠ This set of scripts needs to be installed into your main shell config      #
# otherwise it will not work.                                                  #
# ---------------------------------------------------------------------------- #
#   Lists content of files with icons in-between each cd command.             #
# ---------------------------------------------------------------------------- #
# NOTE: Dependencies are the included cdw which tracks the list of 25 most     #
# recently used directories, and eza which is a modernization of the ls        #
# command.                                                                     #
# ############################################################################ #

# Set ls to clear screen and point to the ls_dynamic function
alias ls='clear; ls_dynamic'

# Navigation functionality that overwrites normal functionality of the `cd`
# command. Clears screen inbetween each navigational step. Uses eza.
ls_dynamic() {
    # Set the directory you want to check (use the current directory by default)
    DIR="${1:-.}"
    
    # Count the total number of files and directories (including hidden ones)
    item_count=$(find "$DIR" -maxdepth 1 -mindepth 1 | wc -l)

    # Debugging output: show the item count
    echo "Item count: $item_count"

    # Check if the item count is more than 20
    if [ "$item_count" -gt 20 ]; then
        # Just run eza without column formatting
        eza -a --icons  --group-directories-first "$DIR"
#clear; eza -a --icons -1 "$DIR"

    else
        # Run eza with icons and format the output with column
        eza -a --icons -1 --group-directories-first "$DIR" 
    fi
}

# Function to handle selecting and opening files or directories
open_ls() {
    # Use eza (or ls) for listing files and folders


    local selected=$(eza -1 --icons "$DIR" | fzf --height=40% --border --prompt="Select a file or folder: ")

    # Strip enclosing single quotes if present
    selected=$(echo "$selected" | sed "s/^'//;s/'$//")

    # Check if selection is valid
    if [ -n "$selected" ]; then
        if [ -d "$selected" ]; then
            # Navigate into the directory
            cd "$selected" || echo "Failed to navigate to '$selected'"
            echo "You are now in: $(pwd)"
            eza -1 --icons  # Optionally list the contents of the new directory
        elif [ -f "$selected" ]; then
            # Open the file in nvim
            nvim "$selected"
        else
            echo "Error: '$selected' is neither a file nor a folder."
        fi
    else
        echo "No selection made."
    fi
}


# ############################################################################ #
#                                  cdw begins
# ############################################################################ #
#   Set of scripts to keep track of top 25 most used file system paths        #
# ############################################################################ #


remove_duplicates_and_update_visits() {
    local cd_history_file=~/.cd_history
    local cd_visits_file=~/.cd_visits

    [[ -f "$cd_history_file" ]] || touch "$cd_history_file"

    update_cd_visits "$cd_history_file" "$cd_visits_file"

    # Remove duplicates while keeping latest entries
    tac "$cd_history_file" | awk '!seen[$0]++' | tac > "${cd_history_file}.tmp"
    mv "${cd_history_file}.tmp" "$cd_history_file"

    # Normalize paths
    replace_dot_slash_with_tilde "$cd_history_file"
}

replace_dot_slash_with_tilde() {
    local file="$1"
    sed -i 's|^\./|~|g' "$file"
}

update_cd_visits() {
    local cd_master_log="$1"
    local cd_visits_file="$2"

    # Ensure the master log exists
    [[ -f "$cd_master_log" ]] || touch "$cd_master_log"

    # Count occurrences and store the top 25
    awk '{ count[$0]++ } END { for (dir in count) print count[dir], dir }' "$cd_master_log" \
        | sort -nr \
        | head -n 25 \
        > "$cd_visits_file"
}

cd() {
    builtin cd "$1" || return
    local cd_history_file=~/.cd_history
    local cd_master_log=~/.cd_master_log
    local cd_visits_file=~/.cd_visits
    local current_dir=$(pwd)

    [[ -f "$cd_history_file" ]] || touch "$cd_history_file"
    [[ -f "$cd_master_log" ]] || touch "$cd_master_log"

    # Normalize home directory paths
    [[ "$current_dir" == "$HOME" ]] && current_dir="~"

    echo "$current_dir" >> "$cd_history_file"
    echo "$current_dir" >> "$cd_master_log"

    update_cd_visits "$cd_master_log" "$cd_visits_file"

    ls_dynamic "$current_dir"
}

ls_dynamic() {
    clear
    local DIR="${1:-$(pwd)}"

    [[ "$DIR" == "~" ]] && DIR="$HOME"

    item_count=$(find "$DIR" -maxdepth 1 -mindepth 1 | wc -l)
    echo "Item count: $item_count"

    if [ "$item_count" -gt 20 ]; then
        eza -a --icons --group-directories-first "$DIR"
    else
        eza -a --icons -1 --group-directories-first "$DIR"
    fi
}

cdw() {
    local cd_visits_file=~/.cd_visits
    [[ -f "$cd_visits_file" ]] || touch "$cd_visits_file"

    local dir=$(cut -d' ' -f2- "$cd_visits_file" | fzf --height 20 --reverse --prompt="Select directory: ")

    if [[ -n "$dir" ]]; then
        echo "cd $dir"
        eval cd "$dir"
    else
        echo "No directory selected."
    fi
}
