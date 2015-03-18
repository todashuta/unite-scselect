" autoload/scselect.vim

let s:P = vital#of('scselect').import('Process')

function! scselect#system(...)
  return call(s:P.system, a:000)
endfunction

function! s:parse_env_name(str)
  " Better way??
  let ret = substitute(a:str, '^.\{-}(', '', '')
  let ret = substitute(ret, ')$', '', '')
  return ret
endfunction

function! scselect#get_current_env()
  let lines = split(scselect#system('scselect'), '\n')[1:]
  let lines = filter(copy(lines), 'v:val =~ "^\\s\\*\\s"')
  return s:parse_env_name(lines[0])
endfunction

function! scselect#select(value)
  return '[scselect] ' . scselect#system('scselect ' . shellescape(a:value))
endfunction

function! scselect#get_candidates()
  let lines = split(scselect#system('scselect'), '\n')[1:]
  let lines = map(copy(lines), 's:parse_env_name(v:val)')
  return lines
endfunction

function! scselect#command(arg)
  if a:arg == ''
    echo '[scselect] Current: ' . scselect#get_current_env()
  else
    call scselect#select(a:arg)
  endif
endfunction

function! scselect#complete(arglead, cmdline, cursorpos)
  let candidates = scselect#get_candidates()
  return filter(candidates, 'v:val =~? "^" . a:arglead')
endfunction
