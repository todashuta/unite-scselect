" unite source scselect

let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#scselect#define()
  return executable('scselect') ? s:source : []
endfunction

let s:source = {
      \   'name': 'scselect',
      \   'description': 'Select network environment',
      \ }

function! s:source.gather_candidates(args, context)
  return map(copy(scselect#get_candidates()), '{
        \   "word": v:val,
        \   "source": "scselect",
        \   "kind": "command",
        \   "action__command": "call scselect#select(''" . v:val . "'')",
        \ }')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
