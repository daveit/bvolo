Router.configure
	layoutTemplate: "MasterLayout"
	loadingTemplate: "Loading"
	notFoundTemplate: "NotFound"
	routeControllerNameConverter: "camelCase"

Router.onBeforeAction "loading"

Router.map ->
	
	@route "home",
		path: "/"
		waitOn: ->
			[
				Meteor.subscribe('items')
				Meteor.subscribe('categories')
			]
	@route "category",
		path: '/category/:_id'
		waitOn: ->
			[
				Meteor.subscribe('items')
				Meteor.subscribe('categories')
			]
	@route "item",
		path: '/item/:_id'
		waitOn: ->
			[
				Meteor.subscribe('items')
				Meteor.subscribe('categories')
			]
	@route "orders",
		path: '/orders'
	@route "cart",
		path: '/cart'
	@route "marketReport",
		path: '/reports'
	@route "news",
		path: '/reports'
	@route "profile",
		path: "/profile"