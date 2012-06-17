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
		model: '../js/models'

define ["backbone", "underscore", "jquery"], (Backbone, _, $) ->
	# The chat box, displays the collection.
	ChatView = Backbone.View.extend
		el: $('#chat-view')
		
		initialize: (collection) ->
			@chat = collection
			_.bindAll(@, 'render')
			# Re-render every time something is added to the chat.
			@chat.bind 'add', @render
			return
		
		render: ->
			# Clear the page
			$(@el).html('')
			
			# Re-render the entire chat. This is inefficient.
			for post in @chat.models
				$(@el).append "<li>#{post.get("text")}<span class='timestamp'>#{post.get("time")}</span></li>"
			return @