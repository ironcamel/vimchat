syn match vimChatMsg 	/^\[\d\d\(:\d\d\)\{0,2\}].\{-}:/	contains=vimChatTime,vimChatMe
syn match vimChatTime  	/\[\d\d\(:\d\d\)\{0,2\}]/			contained nextgroup=vimChatMe
syn match vimChatMe  	/Me:/		 			contained

" Comment, Type, String, Statement
hi link vimChatMsg		Comment
hi link vimChatTime		String
hi link vimChatMe		Type
