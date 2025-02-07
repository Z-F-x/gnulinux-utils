A collection of shell scripts designed to automate system operations and enhance workflow within the GNU/Linux terminal environment

## Installation

### Option 1

Copy paste the content of the files into either your .bashrc or your .zshrc depending on what **shell** you are using.

### Option 2

- make a new directory in your home directory, call it `gnulinux-utils` for instance.\
  `mkdir` `~/gnulinux-utils`
- make a new file for the script; for instance:\
  `touch` `~/gnulinux-utils/mount-unmount-drives.sh`
- Copy paste and save the content of same file in this repo to said file.

### Option 3: Install a specific script only

1. Initialize a new Git repository (meaning in this context to create a new directory for the script files.)
  

```cd ~/```
```git init gnulinux-utils ```

2. Change into the repository directory
  

```cd gnulinux-utils```

3. Enable sparse-checkout mode
  

```git sparse-checkout init --cone```

4. Specify the file to check out (mount-unmount-drives.sh)
  

```git sparse-checkout set mount-unmount-drives.sh```

5. Add the remote repository
  

```git remote add origin https://github.com/Z-F-x/gnulinux-utils.git```

6. Fetch the repository content
  

```git fetch```

.7 Checkout the master branch (or another branch if needed)

```git checkout master```

8. Delete all `.sh` files except for `mount-unmount-drives.sh` (replace file name with the script/file you want installed), all other will be deleted:
  ```find . -type f -name "*.sh" ! -name "mount-unmount-drives.sh" -exec rm -f {} +```
  
9. Verify that only mount-unmount-drives.sh is left
  

`ls *.sh`

### Option 4: Install all scripts

Clone the repo in your home directory (this is the way I've set it up but you can place it wherever you like as long as you link it to the correct path in your ur `.bashrc` or your `.zshrc` i.e., your shell config files.

1. Clone the Git repository into your home directory (or any other directory just remember to link it in your script config file i.e., `.bashrc` / `.zshrc`.
  ```git clone https://github.com/Z-F-x/gnulinux-utils.git ~/```
  
2. Append source commands for all `.sh` files in the cloned directory to `.zshrc` or `.bashrc` config file:
      2.1 `echo "source $file" >> ~/.zshrc`
  or
  
      2.2 `echo " source $file" >> ~/.bashrc`
  

3. Reload `.zshrc` to apply the changes:
  ```source ~/.zshrc```
  

# Usage:

## Mount an external drive

- Enter in your terminal:
  `mount_external`
  
- Select the drive you want to mount from th `fzf` dropdown menu
  
- Provide a drive name.\
  

# Unmount

- Enter in your terminal:
  

`unmount_external`

- Select the drive you want to unmount from the fzf dropdown menu.
