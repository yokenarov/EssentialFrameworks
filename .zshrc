#Android environment variables
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools  
USER=$USER
#Terminal Customization
now=$(date +"%T"-"%d/%m/%Y")  
echo "\e[36mYour current directories:\e[m" 
ls
echo "Welcome \e[36m${USER}\e[m / Current time : \e[36m$now\e[m"   

#'%F{cyan}%n%f:%F{yellow}%~%f| '


git_branch_test_color() {
  local ref=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "${ref}" ]; then
    if [ -n "$(git status --porcelain)" ]; then
      local gitstatuscolor='%F{red}'
    else
      local gitstatuscolor='%F{green}'
    fi
    echo "${gitstatuscolor} (${ref})"
  else
    echo ""
  fi
}
setopt PROMPT_SUBST
PROMPT='%F{cyan}$USER@ %~$(git_branch_test_color)%F{none} '

# add 24h time the right side
RPROMPT='%D{%k:%M:%S}'
