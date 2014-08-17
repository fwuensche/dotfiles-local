"define 3 custom highlight groups
hi User1 ctermbg=lightgray ctermfg=yellow guifg=orange guibg=#444444 cterm=bold gui=bold
hi User2 ctermbg=lightgray ctermfg=red guifg=#dc143c guibg=#444444 gui=none
hi User3 ctermbg=lightgray ctermfg=red guifg=#ffff00 guibg=#444444 gui=bold

set statusline= " Clear the statusline for vimrc reloads

set stl=%*                       " Normal statusline highlight
set stl+=%{InsertSpace()}        " Put a leading space in

set stl+=%1* 				     " Red highlight
set stl+=%{HasPaste()}           " Red show paste
set stl+=%*                      " Return to normal stl hilight

set stl+=%t                      " Filename

set stl+=%2* 				     " Red highlight
set stl+=%m                      " Modified flag

set stl+=%*                      " Return to normal stl hilight
set stl+=%r                      " Readonly flag
set stl+=%h                      " Help file flag

set stl+=%*                      " Set to 3rd highlight
set stl+=\ %y                    " Filetype

" Visual feedback of time since last diff
set stl+=\ \ \ \ Last\ Green:
set stl+=%*
set stl+=\ %{TimeSinceGreen('low')}
set stl+=%1*
set stl+=%{TimeSinceGreen('medium')}
set stl+=%2*
set stl+=%{TimeSinceGreen('high')}
set stl+=%3*
set stl+=%{TimeSinceGreen('na')}
set stl+=%*

set stl+=%=                      " Right align from here on
set statusline+=%{SlSpace()}     " Vim-space plugin current setting
set stl+=\ \ Col:%c              " Column number
set stl+=\ \ Line:%l/%L          " Line # / total lines
set stl+=\ \ %P%{InsertSpace()}  " Single space buffer

" set stl+=%2* 				             " Yello highlight
set stl+=%{ConflictedVersion()}           " Red show paste
" set stl+=%*                      " Return to normal stl hilight


function! SlSpace()
    if exists("*GetSpaceMovement")
        return "[" . GetSpaceMovement() . "]"
    else
        return ""
    endif
endfunc

function! InsertSpace()
    " For adding trailing spaces onto statusline
    return ' '
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/nation/', "~/", "g")
    return curdir
endfunction

"TODO Define equivalent hilights for the terminal usage
"TODO get this hooked up with run_tests func and FeedbackBar('green')
function! TimeSinceGreen(var)
    " Really ugly, but it works. See the associated ugliness in the
    " statusline section for where this gets used

    "Setup the time difference value for use in responses
    if exists('g:last_green_time')
        let current_time = strftime('%s') " Using seconds since epoch
        let diff = current_time - g:last_green_time
        let interval = 5
        let diff_minutes = diff / 6
    endif

    "Many cases for return values
    if a:var == 'low' "Check for normal time, 0-5 minutes
        if exists('g:last_green_time')
            if diff_minutes <= interval
                return diff_minutes
            else
                return ''
            endif
        else
            return ''
        endif
    elseif a:var == 'medium' "Start to get worried
        if exists('g:last_green_time')
            if diff_minutes > interval && diff_minutes <= interval * 2
                return diff_minutes
            else
                return ''
            endif
        else
            return ''
        endif
    elseif a:var == 'high' " high warning level
        if exists('g:last_green_time')
            if diff_minutes > interval * 2
                return diff_minutes
            else
                return ''
            endif
        else
            return ''
        endif
    elseif a:var == 'na'
        if exists('g:last_green_time')
            return ''
        else
            return '--'
        endif
    endif
endfunction
