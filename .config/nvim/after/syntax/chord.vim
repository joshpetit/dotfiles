" Music Chord Highlighting
syn match Chord "[A-G][#b]\{0,1\}[m|M|maj|min]\{0,3\}[0-9]\{0,1\}\>" 

hi def link Chord SpecialComment
