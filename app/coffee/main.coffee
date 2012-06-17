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
	
requirejs ["backbone", "underscore", "jquery", "model/post"], (Backbone, _, $, Post) ->

	app = ($) ->
		
		Chat = Backbone.Collection.extend model: Post
		
		# The chat box, displays the collection.
		ChatView = Backbone.View.extend
			el: $('#chat-view')
			
			initialize: ->
				_.bindAll(@, 'render')
				# Re-render every time something is added to the chat.
				chat.bind 'add', @render
				return
			
			render: ->
				# Clear the page
				$(@el).html('')
				
				# Re-render the entire chat. This is inefficient.
				for post in chat.models
					$(@el).append "<li>#{post.get("text")}<span class='timestamp'>#{post.get("time")}</span></li>"
				return @
		
		# The input and submit button
		ChatInput = Backbone.View.extend
			el: $('#chat-submit') 
			
			events: 
				'click': 'submit'

			initialize: ->
				_.bindAll(@, 'submit') 
				$('#chat-input').focus().select()

			submit: (e) ->
				e.preventDefault()
				post = new Post($('#chat-input').val(), new Date()) 
				chat.add(post)
				post.save()
				$('#chat-input').val('')

		# Application
		chat = new Chat
		chatView = new ChatView()
		chatInput = new ChatInput()
	
	app(jQuery)