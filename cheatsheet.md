################
#   SUBLIME    #
################

'dired - FileBrowser', https://packagecontrol.io/packages/FileBrowser

`f1`           -> Open in window
`C-x+d`        -> open file browser as bar on the right
M-o            -> open file (iOpener), https://github.com/rosshemsley/iOpener
C-M-P          -> Switch sublime projects
C-;            -> Go to word
C-left         -> toggle sidebar
C-\            -> undo
C-Shift-\      -> redo
REPL           -> start repl for python, elrang, etc ...

log commands: sublime.log_commands(True)
https://github.com/grundprinzip/sublemacspro/blob/master/Default.sublime-keymap

# Unix, SSH, Bash #
###################


`lsb_release -a` -> check ubuntu version

scp file.txt wfaction:/remote/directory
scp -r somedir/ wfaction:/remote/directory


`grep -l "some_thing" *.html`   (look inside the current directory for html files containing (inside the file) the string "some*thing".  Output filename)
`grep -l "some*thing" ./*/*.html`   (look one level down for html files containing (inside the file) the string "some_thing".  Output filenames)

`Ctrl-Alt-F2` to console mode # WARNING GOES TO CLI
`Ctrl-Alt-F7` to GUI mode. #brings you back

# LOOPS
for f in *.jpg; do echo "converting $f file"; convert $f "$f.pdf"; done


## Tmux

`tmux list-sessions`  which sessions are running?
`tmux attach`  attach to only running session
`tmux attach -t <nrsession>` attach to session number nrsession
`Ctrl+b d` detach
`Ctrl+b PgUp` scroll, exit with **q**

##########
# SCREEN #
##########

I created a .screenrc where I changed the default
CTRL-a with CRTL-o (letter "o")
C-a ESC           -> `scroll in the screen terminal`

## GIF Recording

byzanz-record --duration=15 --x=200 --y=300 --width=700 --height=400 out.gif
byzanz-record --duration=10 --delay=4 --x=480 --y=300 --width=600 --height=400 out.gif


## Imagemagik & PDF

identify -verbose file.pdf | grep Color # shows color space (RGB, CYMK, etc)
convert -delay 2 si*png -loop 0 anim2.gif
for file in *png; do echo resizing $file ...; convert $file -resize 55% small_`basename $file .png`.png; done
file naming:  %03d.png (3 digit with a leading zero: 001, 002, 003, ..., 234.

## ImageMagik - Optimize for web
for file in *png;
do echo resizing $file ...;
convert -strip -interlace Plane -quality 90% $file small_`basename $file`;

## PDF manipulation
pdftk scan.pdf burst  `#(split a pdf)`
pdftk file1.pdf file2.pdf cat output mergedfile.pdf `# Merge pdf files`


## Wifi problems with 11n
sudo modprobe iwlwifi 11n_disable=1 # try this
# this to go back: sudo modprobe iwlwifi 11n_disable=0 # or not?
 sudo echo "options iwlwifi 11n_disable=1" >> /etc/modprobe.d/iwlwifi.conf
sudo modprobe -r iwldvm
sudo modprobe -r iwlwifi


## Finding files and text
ack-grep 'renooble' renooble/templates/pages/landing/

## Cron / Crontab
http://v1.corenominal.org/howto-setup-a-crontab-file/
crontab -l `list the cron jobs`
crontab -e `edit crontab file`

#############
### EMACS ###
#############

Using Yasnippet + Zencoding
http://www.youtube.com/watch?v=u2r8JfJJgy8


-ctrl o c           -> create new window
-ctrl o A           -> set window name
-ctrl o w           -> show all window
-ctrl o 1|2|3|      -> switch to window n
-ctrl o "           -> choose window
-ctrl o ctrl o      -> switch between window
-ctrl o d           -> detach window
-ctrl o ?           -> help
-ctrl o [           -> start copy, move cursor to the copy location, press ENTER, select the chars, press ENTER to copy the selected characters to the buffer
-ctrl o ]           -> paste from buffer
                    -> Justify paragraph

C-f /sudo:: (to access a directory as sudo)

# record a macro:
-ctrl+x (          -> Start recording a macro
Perform any actions inside the Emacs editor that you would like to record.
-ctrl+x )          -> Stop recording by pressing
-ctrl+x e          -> Play the last recorded macro

#######################
##  IPYTHON Notebook ##
#######################

https://github.com/tkf/emacs-ipython-notebook
M-x ein:notebooklist-open

##############
###  GIT   ###
##############


git branch -a                        ->  show all branches
git checkout name_local_branch       ->  move to local branch
git fetch + git merge                ->  same as git pull

git add -A                           ->  stages All
git add .                            ->  stages new and modified, without deleted
git add -u                           ->  stages modified and deleted, without new

############
# TODO.txt #
############
[Link to Gina Trapani formatting guide](https://github.com/ginatrapani/todo.txt-cli/wiki/The-Todo.txt-Format)

1. Priorities
(A) Save the world
(B) Backup laptop
(D) Buy new phone

0. Alias and commands
`t add '(B) laundry'` -> add a new item
`t ls` -> list tasks
`t lsp` -> list by priorities
`t ls @email` -> list tasks done by email
`t ls +travel @email` -> list tasks related to travel done by email
`t ls peter` -> list tasks containing the word *peter*
`t pri 3 A` -> give task number **(3)** priority **(A)**
`t do 3` -> mark task **3** as done.

2.  Date
(A) 2011-03-02 Call Mom  (created on Feb 3rd 2011)
(A) 2011-03-02 due:2011-03-03 Call Mom (due one day after creation)

3. My Contexts:

@t:  phone
@e:  email
@pc: computer
@shop:shopping
@out: outdoors
@w: work

4. My Projects:
+friends
+family
+travel
+home
+wedding
+network
+finance
+renooble-dev
+renooble-sales
+renooble-funding
+renooble-legal
+renooble-ops
+learn

5. Complete:
x (A) 2014-03-31 Call Peter @tel

#######
# IRC #
#######

/nick alphydan
/help
/join #somechannel  ;join a channel
/names              ;find names of people connected



##############
# Anti Virus #
##############

`sudo freshclam`  # Update definitions
`clamscan -r --bell -i / `  # To check all files on the computer, but only display infected files and ring a bell when found:
