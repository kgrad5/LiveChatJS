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

define ["backbone", "underscore", "jquery", "model/post"], (Backbone, _, $, Post) ->
	# The input and submit button
	ChatInput = Backbone.View.extend
		events: 
			'click': 'submit'
	
		initialize: (submit_id, input_id, collection) ->
			@submit_id = submit_id
			@input_id = input_id
			@chat = collection
			@setElement $('#'+@submit_id)
			_.bindAll(@, 'submit') 
			$('#' + @input_id).focus().select()
	
		submit: (e) ->
			e.preventDefault()
			post = new Post($('#' + @input_id).val(), new Date()) 
			@chat.add(post)
			post.save()
			$('#' + @input_id).val('')