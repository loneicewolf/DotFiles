#REPLACE ALL "YOU" with your username
#and optionally your path to whatever object.


# TO ADD
## FILE AND COMMAND
## root and ZSH and all other
##### history >> /home/YOU/HISTFILES/$(date +"%Y-%m-%d").command.log

alias DATE='date;timedatectl'
alias DATE_simple='$(echo date +"%Y-%m-%d")'
alias TR='tr --squeeze-repeats " \t\n\v"'

alias NANO_APT='nano      /home/YOU/Desktop/APT.TXT'
alias NANO_CHANGES='nano  /home/YOU/Desktop/CHANGES.TXT'
alias NANO_PROBLEMS='nano /home/YOU/Desktop/PROBLEMS_SOLUTIONS_THEORIES_QUESTIONS.txt'
alias NANO_RCS='nano      /home/YOU/.bashrc'
alias NANO_ALIAS='nano    /home/YOU/.bash_aliases'

alias CHTREE_SEP='printf "~~~~~~~~~~\n~~~~~~~~~~\n"'

alias GREP_IPS_1='ip a | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"'
alias GREP_IPS_2='ip a | grep -Eio "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"'
alias GREP_URL='grep -Eio "(http|https)://[a-zA-Z0-9./?=_%:-]*"'


alias PY3_HTTP_1234='python3 -m http.server 1234'


alias CD_APPS='cd /RESEARCH/APPS'
alias CD_APPS_FEROX='cd /RESEARCH/APPS/W/FEROX'
alias CD_APPS_W_Fx='cd /RESEARCH/APPS/W/firefox/firefox/'
alias CD_CODE='cd /RESEARCH/CODE/'
alias CD_TMP='cd /tmp/'
alias CD_RESEARCH_OPS='cd /RESEARCH/OP/ops/'























