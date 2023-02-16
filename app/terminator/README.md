# terminator
## custom commands

format: 
- `#name`  `#command`
***


Use this as a template
- `# ` `# `



- `#LS1` `#ls --all --color=yes --group-directories-first --human-readable --size --sort=size`
-  `#WC` `#wc --bytes --chars --lines --words`
- `#BASHFILELOOP1` `#f="FILE.TXT";i=0; while read L; do ((i=i+1)); ALERT "R" "$L $i"; done < $f`

- `#bashexfunc1` `#function F1(){ ARGC="$#" && if [ $ARGC != 1 ]; then echo "[-]"; else ( m="$1" && xxd -ps <<< $m ; xxd -ps -u <<< $m  ); fi ;};`
- `#BshDelmtr1` `#echo "= ""{"$(xxd -ps -u <<< "abc" | sed 's/.\{2\}/& /g')"}" #https://unix.stackexchange.com/a/5981`
- `` ``
- `` ``



