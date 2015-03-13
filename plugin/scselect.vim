" plugin/scselect.vim

command! -bar -nargs=? -complete=customlist,scselect#complete Scselect
      \ call scselect#command(<q-args>)
