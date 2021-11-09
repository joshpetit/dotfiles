if exists('g:loaded_nerdtree_stuff_menu')
    finish
endif


call NERDTreeAddMenuItem({'text': '(D)rag and drop',
            \'shortcut': 'D',
            \'callback': 'DragnDrop'})

let g:loaded_nerdtree_stuff_menu = 1
