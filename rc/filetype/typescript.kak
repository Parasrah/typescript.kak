# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.]tsx %{
  set-option buffer filetype typescriptreact
}

hook global BufCreate .*[.]jsx %{
  set-option buffer filetype javascriptreact
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=(javascriptreact|typescriptreact) %{
  require-module javascript

  hook window ModeChange pop:insert:.* -group "%val{hook_param_capture_1}-trim-indent" javascript-trim-indent
  hook window InsertChar .* -group "%val{hook_param_capture_1}-indent" javascript-indent-on-char
  hook window InsertChar \n -group "%val{hook_param_capture_1}-indent" javascript-indent-on-new-line

  hook -once -always window WinSetOption filetype=.* "
    remove-hooks window %val{hook_param_capture_1}-.+
  "
}


hook -group javascriptreact-highlight global WinSetOption filetype=javascriptreact %{
  add-highlighter window/javascriptreact ref javascript
  hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/javascriptreact }
}

hook -group typescriptreact-highlight global WinSetOption filetype=typescriptreact %{
  add-highlighter window/typescriptreact ref typescript
  hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/typescriptreact }
}
