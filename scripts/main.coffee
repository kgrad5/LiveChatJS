requirejs.config 
	baseUrl: 'scripts/lib'
	shim: 
		'backbone': 
			deps: ['underscore', 'jquery']
			exports: 'Backbone'
		'underscore':
			deps: ['jquery']
			exports: '_'
	
requirejs ["backbone", "underscore", "jquery"], (Backbone, _, $) ->

	app = ($) ->
		
		Post = Backbone.Model.extend 
			initialize: (text, time) -> 
				@set text: text
				@set time: time
				return
			text: null 
			time: null 
		
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
				$('#chat-input').val('')

		# Application
		chat = new Chat
		chatView = new ChatView()
		chatInput = new ChatInput()
	
	app(jQuery)