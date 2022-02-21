""
" @plugin Poiekolon A very configurable neovim plugin to add or toggle a char at the end of a line.
"
" @mappings
" See README.md for configuration in lua.
"
" @command :Poiekolon {function} {char}
"
" Runs {function} with char {char}.
"
" Functions are:
"
" ```
" do_default              -> Invoke configured default action with <char> (default: add_char)
" add_char                -> Add <char> to the end of the line unless it exists.
" force_add_char          -> Add <char> to the end of the line even if it exists.
" toggle_char             -> Toggle <char> at the end of the line.
" add_char_newline        -> Add <char> to the end of the line unless it exists, and add a newline after.
" force_add_char_newline  -> Add <char> to the end of the line even if it exists, and add a newline after.
" toggle_char_newline     -> Toggle <char> at the end of the line, and add a newline after.
" ```

if exists('g:loaded_poiekolon') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

function! ColonCompletion(lead, cmd, cursor)
    let valid_args = ['default', 'add', 'force', 'toggle', 'add_newline', 'force_newline', 'toggle_newline']
    let l = len(a:lead) - 1
    if l >= 0
        let filtered_args = copy(valid_args)
        call filter(filtered_args, {_, v -> v[:l] ==# a:lead})
        if !empty(filtered_args)
            return filtered_args
        endif
    endif
    " TODO: figure out how to return [] after first arg has been entered
    return []
    " return valid_args
endfunction
command! -nargs=1 -complete=customlist,ColonCompletion Poiekolon :lua require('poiekolon').do_thing(<f-args>)

let g:loaded_poiekolon = 1

let &cpo = s:save_cpo
unlet s:save_cpo
