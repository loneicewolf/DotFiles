## NOTE; caveat: if not found;
## HIST_SEARCH abccbbc
###  cat: '/home/YOU/HISTFILES/*': No such file or directory
### (...) 

## TODO: question: ADD  history?
## TODO: question: ADD  more files contain history?
#v0 function HIST_SEARCH () { if [ $# != 1 ]; then     echo "input err,  input 1=keyword";  else  kw="$1" && ( cat /home/YOU/{HISTFILES/*,.bash_history} ) | grep --color=auto -i "$kw";     fi; } 

#v1
function HIST_SEARCH () { if [ $# != 1 ]; then echo "input 1=keyword"; else  kw="$1" && ( cat /home/YOU/{HISTFILES/*,.bash_history}  ; history  ) | grep --color=auto -i "$kw"; fi; } 



ALERT(){
  case "$1" in
    R) col="\033[101m\033[30m";;
    G) col="\033[102m\033[30m";;
    Y) col="\033[103m\033[30m";;
    B) col="\033[104m\033[30m";;
    *) col="";;
  esac
  /bin/echo -ne "$col $2 \033[0m"
  [ -n "$3" ] && /bin/echo -n " ($3)"
  /bin/echo
}

