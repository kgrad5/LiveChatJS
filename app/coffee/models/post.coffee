requirejs.config 
	baseUrl: 'app/lib'
	shim: 
		'backbone': 
			deps: ['underscore', 'jquery']
			exports: 'Backbone'
		'underscore':
			deps: ['jquery']
			exports: '_'

define ["backbone", "underscore", "jquery"], (Backbone, _, $) ->
	Post = Backbone.Model.extend 
		initialize: (text, time) -> 
			@set text: text
			@set time: time
			return
		text: null 
		time: null 
		url: "/"