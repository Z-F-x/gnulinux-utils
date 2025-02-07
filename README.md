# A collection of shell scripts designed to automate system operations and enhance workflow within the GNU/Linux terminal environment

## Installation
### Option 1
Copy paste the content of the files into either your .bashrc or your .zshrc depending on what **shell** you are using.

### Option 2
- make a new directory in your home directory, call it `gnulinux-utils` for instance.\
`mkdir` `~/gnulinux-utils`
- make a new file for the script; for instance:\
`touch` `mount-unmount-drives.sh`
- Copy paste the content of same file in this repo to said file.

### Option 3: Install a specific script only 
# Initialize a new Git repository (meaning in this context to create a new directory for the script files.)
git init gnulinux-utils 

# Change into the repository directory
cd gnulinux-utils

# Enable sparse-checkout mode
git sparse-checkout init --cone

# Specify the file to check out (mount-unmount-drives.sh)
git sparse-checkout set mount-unmount-drives.sh

# Add the remote repository
git remote add origin https://github.com/Z-F-x/gnulinux-utils.git

# Fetch the repository content
git fetch

# Checkout the master branch (or another branch if needed)
git checkout master

# Delete all .sh files except for mount-unmount-drives.sh 
(replace with the script/file you want installed), all other will be deleted\
find . -type f -name "*.sh" ! -name "mount-unmount-drives.sh" -exec rm -f {} +

# Verify that only mount-unmount-drives.sh is left
ls *.sh


### Option 4: Install all scripts  
Clone the repo in your home directory (this is the way I've set it up but you can place it wherever you like as long as you link it to the correct path in your ur `.bashrc` or your `.zshrc` i.e., your shell config files.
```git clone https://github.com/Z-F-x/gnulinux-utils.git/mount-unmount-drives.sh ~/

```bash
# Step 1: Clone the Git repository into your home directory
git clone https://github.com/Z-F-x/gnulinux-utils.git ~/

# Step 2: Append source commands for all .sh files in the cloned directory to .zshrc
for file in ~/your-repo-name/*.sh; do
  echo "source $file" >> ~/.zshrc
done

# Step 3: Reload .zshrc to apply the changes
source ~/.zshrc


# Mount an external drive 
Usage:\
`mount_external`
Provide a drive name.\
