# sh
''
  # Store initial shell level only if not already set
  [[ -z "''$_INITIAL_SHLVL" ]] && export _INITIAL_SHLVL=''${SHLVL:-1}

  # Track if we've shown our first prompt yet
  [[ -z "''$_PROMPT_COUNT" ]] && export _PROMPT_COUNT=0

  function add_line_before_prompt() {
    (( _PROMPT_COUNT++ ))

    # Skip first prompt
    [[ ''$_PROMPT_COUNT -eq 1 ]] && return
    # Skip after clear
    [[ "''$LAST_COMMAND" == "clear" ]] && return
    # Skip nested shell first prompt
    [[ ''${SHLVL:-1} -gt ''${_INITIAL_SHLVL:-1} && ''$_PROMPT_COUNT -eq 1 ]] && return

    echo ""
  }

  function track_command() {
    LAST_COMMAND="''$1"
  }

  # Only add to function arrays if not already present
  [[ " ''${precmd_functions[*]} " =~ " add_line_before_prompt " ]] || precmd_functions+=(add_line_before_prompt)
  [[ " ''${preexec_functions[*]} " =~ " track_command " ]] || preexec_functions+=(track_command)
''
