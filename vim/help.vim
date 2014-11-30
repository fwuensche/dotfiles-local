" Helpful Speedups
"-----------------
"
" shamelessly stolen from Chris Toomey

au filetype help call HelpFileMode()

function! HelpFileMode()
  wincmd _ " Maximze the help on open
  " Help File funtimes, <enter> to follow tag, delete for back
  nnoremap <tab> :call search('\|.\{-}\|', 'w')<cr>:noh<cr>2l
  nnoremap <S-tab> :call search('\|.\{-}\|', 'wb')<cr>:noh<cr>2l
  nnoremap <buffer><cr> <c-]>
  nnoremap <buffer><bs> <c-T>
  nnoremap <buffer>q :q<CR>
  setlocal nonumber
endfunction
