" unite source scselect

let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#scselect#define()
  return executable('scselect') ? s:source : []
endfunction

function! unite#sources#scselect#select(name)
  call unite#util#system('scselect ' . shellescape(a:name))
endfunction

let s:source = {
      \   'name': 'scselect',
      \   'description': 'Select network environment',
      \ }

function! s:source.gather_candidates(args, context)
  let choices = split(unite#util#system('scselect'), '\n')[1:]
  let choices = map(deepcopy(choices), 'substitute(v:val, "^.\\{-}(", "", "")')
  let choices = map(deepcopy(choices), 'substitute(v:val, ")$", "", "")')

  return map(copy(choices), '{
        \   "word": v:val,
        \   "source": "scselect",
        \   "kind": "command",
        \   "action__command": "call unite#sources#scselect#select(''" . v:val . "'')",
        \ }')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
