syn match vimChatMsg 	/^\[[-0-9: ]*\].\{-}:/	contains=vimChatDateTime,vimChatMe
syn match vimChatDateTime  	/\[[-0-9: ]*\]/   contained contains=vimChatDate,vimChatTime nextgroup=vimChatMe
syn match vimChatDate  	/\(\d\d\d\d-\d\d-\d\d \)\?/			contained nextgroup=vimChatTime
syn match vimChatTime  	/[\[ ]\@=\d\d\(:\d\d\)\{0,2\}/			contained
syn match vimChatMe  	/Me:/		 			contained

" Comment, Type, String, Statement
hi link vimChatMsg		Comment
hi link vimChatDateTime		String
hi link vimChatDate		NonText
hi link vimChatTime		Comment
hi link vimChatMe		Type
