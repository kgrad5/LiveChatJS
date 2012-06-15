require(["libs/jquery-1.7.2.min", "libs/underscore-min", "libs/backbone-min"], ->

	$ = jQuery

	$ ->
		ListView = Backbone.View.extend({
			
			el: $('body') #attaches this.el to an existing element

			initialize: ->
				_.bindAll(@, 'render')
				@render()

			render: ->
				$(@el).append("<ul id='main-list'> <li>hello world</li><ul>")
		})

		listView = new ListView()
)