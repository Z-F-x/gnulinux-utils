# gnulinux-utils
A collection of shell scripts designed to automate system operations and enhance workflow within the GNU/Linux terminal environment.

> [!IMPORTANT]  
> - `ls_dynamic` and `cdw` from `cdw.sh` and/or `ls_dynamic.sh` needs to be present in your shell config file in order to run the scripts to run.
> - Proper keybindings must also be set up for `ls` and `cd` to run `ls_dynamic` and `cdw` respectively.

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)

## Introduction
- `audio-and-video-playback` – 
Play audio and video directly in (audio) from (video) terminal.
- `cdw` – 
Track the 25 most used file paths.
- `ls_dynamic` – 
Adds the `ls_dynamic` function when navigating with `cd`. It clears screen and runs eza with icons, which displays content of current path—relieving the user from having to run `dir`, `tree`, or `ls` manually to see the content of the navigated directory.
- `ls_ft` –
 List the content of current directory by file extension.
- `ls_open` –
A function that displays all navigable subdirectories within the current directory. 
- `mount-unmount-drives` – 
Mount and unmount external drives.
- `mv_files` –
shorthand for bulk moving all files and folders, all folders or all files respectively.
- `terminal_bookmarks` – 
Bookmark file paths and navigate set bookmarks with the F1-F12-keys.

---


## Installation

### Option 1 Copy and paste into shell config file

Copy paste the content of the files into either your `.bashrc` or your `.zshrc` depending on what **shell** you are using.

### Option 2 import scripts into shell config file

- make a new directory in your home directory, call it `gnulinux-utils`, for instance.\
  `mkdir` `~/gnulinux-utils`
- make a new file for the script; for instance:\
  `touch` `~/gnulinux-utils/mount-unmount-drives.sh`
- Copy paste and save the content of same file in this repo to said file.

### Option 3: Install a specific script only

1. Initialize a new Git repository (meaning in this context to create a new directory for the script files.)\
```cd ~/```\
```git init gnulinux-utils ```

2. Change into the repository directory\
```cd gnulinux-utils```

3. Enable sparse-checkout mode\
```git sparse-checkout init --cone```

4. Specify the file to check out (mount-unmount-drives.sh)\
```git sparse-checkout set mount-unmount-drives.sh```

5. Add the remote repository\
```git remote add origin https://github.com/Z-F-x/gnulinux-utils.git```

6. Fetch the repository content\
```git fetch```

7. Checkout the master branch (or another branch if needed)\
```git checkout master```

8. Delete all `.sh` files except for `mount-unmount-drives.sh` (replace file name with the script/file you want installed), all other will be deleted:\
  ```find . -type f -name "*.sh" ! -name "mount-unmount-drives.sh" -exec rm -f {} +```
  
9. Verify that only mount-unmount-drives.sh is left\
`ls *.sh`

### Option 4: Install all scripts by appending all files in repo 

Clone the repo in your home directory (this is the way I've set it up but you can place it wherever you like as long as you link it to the correct path in your ur `.bashrc` or your `.zshrc` i.e., your shell config files.

1. Clone the Git repository into your home directory (or any other directory just remember to link it in your script config file i.e., `.bashrc` or `.zshrc`.\
  ```git clone https://github.com/Z-F-x/gnulinux-utils.git ~/```\
  1.1  Change directory to repository\
     `cd` `gnulinux-utils`
  
2. Append source commands for all `.sh` files in the cloned directory to `.zshrc` or `.bashrc` config file. 

For **.zshrc**:

      2.1 `echo "for file in ~/gnulinux-utils/*.sh; do source \$file; done" >> ~/.zshrc`

For **.bashrc**:
  
      2.2 `echo "for file in ~/gnulinux-utils/*.sh; do source \$file; done" >> ~/.bashrc`
  
4. Reload `.zshrc` to apply the changes:\
  ```source ~/.zshrc```


<hr style="height: 0.5px;">

## Usage:

### 1. **audio-and-video-playback**

#### Audio playback
- Enter `play` `audioFileName.mp3`
- Enter `play` in a path that contains audio files and select an audio file from fzf dropdown

NOTE: Valid audio file formats are: `.wma`, `.mp3`, `.wav`, `.ogg`.


#### Video playback 
- Enter `vlc` `videoFileName.mp4`
- Enter `vlc` and press **tab** to cycle select video files
- Enter `vlc` and select vido file from fzf dropdown

##### NOTE: Valid video file formats are: `.mp4'`, `.mkv`, `.avi`, `.mov`.

___


### 2. **cdw**
enter `cdw` in terminal to view and select logged file paths. Paths are logged automatically with `cd`

![image](https://github.com/user-attachments/assets/0a03737d-9b00-4c0d-afe9-fe3bda0e2efe)


### 3. **ls_dynamic**
Enter `cd` as you would normally. 

Expected result: 
`clear` is ran screen and displays the content of file with `eza --icons`: 
![image](https://github.com/user-attachments/assets/94e0246a-297b-4199-834f-0b8f9838ffeb)

___


### 4. **ls_ft**

alias lsft="list_specific_file_type_eza" # list files by extension, requires an argument. For example: lsft .txt
alias sbft="list_files_sort_extension" #c
alias lsfth="list_files_sort_extension_hidden" #Lits only files by extension including hidden files, requires argument.
alias lsfta="list_files_and_folders_sort_by_extensions" #require arguments

#### Lists files by extension
`lsft` `.txt`

#### List only files, sort by extension 
`sbft` `.txt`

#### List only files including hidden files, sort by extension
`lsfth` `.txt`

#### List files and folders and sort files by extensions
`lsfta` `.txt`

NOTE: See all aliases for this functionality in the script file.
___


### 5. **ls_open**

- Enter in your terminal:\
  `ls_open`

![image](https://github.com/user-attachments/assets/864afff5-2c47-45c0-af8c-8a009dbf7c18)
- Hit enter to navigate

Alernatively: `lsnav`, `nav`, `open`, `opendir`, `dopen`, `diropen`, `navigate`, `folder`

___

### 6. **mount-unmount-drives**

#### `mount_external` and `unmount_external`

##### Mount
- Enter in your terminal:\
  `mount_external`

![image](https://github.com/user-attachments/assets/ccbf6a0b-5795-44f1-a623-4d6b8e60debe)
  
- Select the drive you want to mount from th `fzf` dropdown menu

  ![image](https://github.com/user-attachments/assets/eb653863-102b-4d0f-a857-7ac2030160d3)

- Provide a drive name.

  ![image](https://github.com/user-attachments/assets/fd6bc936-7ca9-4dbe-9364-236ade6a3316)

- Drive uccessfully mounted

![image](https://github.com/user-attachments/assets/df1602c3-5ae0-48b0-8acd-4098d45fef53)

##### Unmount

![image](https://github.com/user-attachments/assets/0bc4fd75-184d-4191-a58a-dec2d5ad21af)

- Enter in your terminal:

`unmount_external`

- Select the drive you want to unmount from the fzf dropdown menu.

![image](https://github.com/user-attachments/assets/96533b55-bcfe-4655-84dc-227f86879bc0)

- Unmounted
![image](https://github.com/user-attachments/assets/47ab7f00-a8f5-4fe2-9dd4-716cc2d9a81c)


___

### 7. **mv_files**

Move all files, excluding folders
`mvfiles`

Move all files and folders
`mvall`


### 8. **terminal_bookmarks**

#### Set bookmark at current directory
```bookmark set 1```

![image](https://github.com/user-attachments/assets/1db9a700-a8ee-4146-b539-353a5130651e)



NOTE: valid set options are `1` through `12` setting the set bookmark to the corresponding F-key.

#### Go to bookmark via command
```bookmark 1```

#### See list of set bookmarks
```bookmark```

![image](https://github.com/user-attachments/assets/a787bc80-668b-4399-9ee6-499947ab681a)
<!-- TODO: Fix this issue -->
- NOTE: Known Issue.  Formatting is not pretty.  Will be fixed.

#### Go to bookmark via function-key(s)
`F1`, `F2`, `F3`, `F4`, `F5`, `F6`, `F7`, `F8`, `F9`, `F10`, `F11`, and `F12`.

___
