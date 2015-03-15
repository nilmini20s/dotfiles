#!/bin/bash

function dsz-simple ()
{
  ls -Rl | awk 'BEGIN {t=0} { if ($5) t++; s +=$5 } END { print t,"items",s }'
}
function dsz ()
{
    if (( $# > 0 )); then
        ls -Rl $@ | awk 'BEGIN { t=0 }
                     { if ($5) t++; s+=$5 } 
                     END { printf "%d items\t", t;
                           if (s == 0 || s < 1024 ) 
                             printf "%.2fB\n",  s;
                           else if ((s/1024) < 1024) 
                             printf "%.2fKB\n",  (s/1024); 
                           else if ((s/1048576) < 1024) 
                             printf "%.2fMB\n",  (s/1048576); 
                           else if ((s/1073741824) < 1024) 
                             printf "%.2fGB\n", (s/1073741824); 
                           else 
                             printf "%.2fTB\n", (s/1099511627776);
                         }' 
    else
        ls -Rl | awk 'BEGIN { t=0 }
                    { if ($5) t++; s+=$5 } 
                    END { printf "%d items\t", t;
                          if (s == 0 || s < 1024 ) 
                            printf "%.2fB\n",  s;
                          else if ((s/1024) < 1024) 
                            printf "%.2fKB\n",  (s/1024); 
                          else if ((s/1048576) < 1024) 
                            printf "%.2fMB\n",  (s/1048576); 
                          else if ((s/1073741824) < 1024) 
                            printf "%.2fGB\n", (s/1073741824); 
                           else 
                             printf "%.2fTB\n", (s/1099511627776);
                        }' 

    fi
}
function cdu ()
{
  cd $(echo $1 | sed "s/\./\_/g" | sed "s/\_/..\//g")
}
function lsu ()
{
  ls $(echo $1 | sed "s/\./\_/g" | sed "s/\_/..\//g")
}
function psst ()
{
  if [ $# -eq 0 ]; then
    ps aux | grep $USER
  else
    ps aux | grep $USER | grep $1
  fi
}
function find ()
{
  /usr/bin/find $@ 2>/dev/null
}
function cd ()
{
  builtin cd "$@"
  NUMFILES=$(ls -l | wc -l)
  if (( $NUMFILES < 30 )); then
    ls -l
  fi
}
function gdiff ()
{
    git diff $@ > gitdiff.output
    vim gitdiff.output
    rm -f gitdiff.output
}


#function cd ()
#{
#  if [[ "$1" =~ ^"..." ]]; then
#    CDSTR=$(echo $1 | sed "s/\./\_/g" | sed "s/\_/..\//g")
#    cd $CDSTR
#  else
#    builtin cd "$@"
#  fi
#}
