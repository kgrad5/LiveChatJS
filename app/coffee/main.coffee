requirejs.config 
	baseUrl: 'app/lib'
	shim: 
		'backbone': 
			deps: ['underscore', 'jquery']
			exports: 'Backbone'
		'underscore':
			deps: ['jquery']
			exports: '_'
	paths:
		js: '../js'
		model: '../js/models'
		view: '../js/views'
	
requirejs ["backbone", "underscore", "jquery", "model/post", "view/chatInput", "view/chatView"], (Backbone, _, $, Post, ChatInput, ChatView) ->

	app = ($) ->
		
		Chat = Backbone.Collection.extend model: Post
		
		# Application
		chat = new Chat()
		
		chatlog = ''
		$.get '/chat', (data) ->
			data = data.split('}')
			data.pop() #remove the empty last element from the end
			for hash in data
				hash = JSON.parse(hash + '}')
				post = new Post(hash.text, hash.time)
				chat.add(post)
			
		chatView = new ChatView(chat)
		chatInput = new ChatInput("chat-submit", "chat-input", chat)
	
	app(jQuery)