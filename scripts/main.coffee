require(["libs/jquery-1.7.2.min", "libs/underscore-min", "libs/backbone-min"], ->

	$ = jQuery

	$ ->
		
		Post = Backbone.Model.extend text: null, time: null
		Chat = Backbone.Collection.extend model: Post
		
		chat = new Chat
		
		ChatSubmit = Backbone.View.extend({
			
			el: $('#chat-submit') #attaches this.el to an existing element

			initialize: ->
				_.bindAll(@, 'submit', 'render')
				$('#chat-input').focus().select()
				@submit()

			submit: ->
				$(@el).on 'click', (e) -> 
					e.preventDefault()
					chat.add text: $('#chat-input').val(), time: new Date()
					console.log JSON.stringify chat
					$('#chat-ul').append '<li>' + $('#chat-input').val() + "<span class='timestamp'>" + 
						new Date() + "</span></li>"
					$('#chat-input').val('')
													
		})
		
		

		chatSubmit = new ChatSubmit()
)