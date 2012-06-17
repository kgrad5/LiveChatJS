// Generated by CoffeeScript 1.3.3
(function() {

  requirejs.config({
    baseUrl: 'app/lib',
    shim: {
      'backbone': {
        deps: ['underscore', 'jquery'],
        exports: 'Backbone'
      },
      'underscore': {
        deps: ['jquery'],
        exports: '_'
      }
    },
    paths: {
      js: '../js',
      model: '../js/models'
    }
  });

  requirejs(["backbone", "underscore", "jquery", "model/post"], function(Backbone, _, $, Post) {
    var app;
    app = function($) {
      var Chat, ChatInput, ChatView, chat, chatInput, chatView;
      Chat = Backbone.Collection.extend({
        model: Post
      });
      ChatView = Backbone.View.extend({
        el: $('#chat-view'),
        initialize: function() {
          _.bindAll(this, 'render');
          chat.bind('add', this.render);
        },
        render: function() {
          var post, _i, _len, _ref;
          $(this.el).html('');
          _ref = chat.models;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            post = _ref[_i];
            $(this.el).append("<li>" + (post.get("text")) + "<span class='timestamp'>" + (post.get("time")) + "</span></li>");
          }
          return this;
        }
      });
      ChatInput = Backbone.View.extend({
        el: $('#chat-submit'),
        events: {
          'click': 'submit'
        },
        initialize: function() {
          _.bindAll(this, 'submit');
          return $('#chat-input').focus().select();
        },
        submit: function(e) {
          var post;
          e.preventDefault();
          post = new Post($('#chat-input').val(), new Date());
          chat.add(post);
          post.save();
          return $('#chat-input').val('');
        }
      });
      chat = new Chat;
      chatView = new ChatView();
      return chatInput = new ChatInput();
    };
    return app(jQuery);
  });

}).call(this);