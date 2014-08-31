Router.configure
	layoutTemplate: "MasterLayout"
	loadingTemplate: "Loading"
	notFoundTemplate: "NotFound"
	routeControllerNameConverter: "camelCase"

Router.onBeforeAction "loading"

Router.map ->
	
	@route "home",
		path: "/"
		data: ->
			{
				items: Items.find(Session.get 'filter').fetch()
				categories: Categories.find().fetch()
			}
		action: ->
			if @ready()
				Session.set 'category', null
				Session.set 'item', null
				@render()
	@route "category",
		path: '/category/:_id'
		template: 'home'
		data: ->
			{
				items: Items.find(Session.get 'filter').fetch()
				categories: Categories.find().fetch()
			}
		action: ->
			if @ready()
				Session.set 'category', @params._id
				Session.set 'item', null
				@render()

	@route "item",
		path: '/item/:_id'
		template: 'home'
		data: ->
			{
				items: Items.find(Session.get 'filter').fetch()
				categories: Categories.find().fetch()
			}
		action: ->
			if @ready()
				Session.set 'item', @params._id
				@render()
	@route "orders",
		path: '/orders'
		waitOn:->
			[
				Meteor.subscribe 'orders'
			]
		data: ->
			orders: Orders.find({},{sort:{createdAt: -1}}).fetch()
	@route "checkout",
		path: '/checkout'
	@route "marketReports",
		path: '/reports'
		waitOn: ->
			[
				Meteor.subscribe 'reports'
			]
		data: ->
			reports: Reports.find({},{sort: {createdAt: -1}}).fetch()
	@route "news",
		path: '/news'
		waitOn: ->
			[
				Meteor.subscribe 'posts'
			]
		data: ->
			posts: Posts.find({},{sort: {createdAt: -1}}).fetch()
	@route "about",
		path: '/about'
	@route "profile",
		path: "/profile"