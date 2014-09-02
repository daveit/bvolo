Router.configure
	layoutTemplate: "MasterLayout"
	loadingTemplate: "Loading"
	notFoundTemplate: "NotFound"
	routeControllerNameConverter: "camelCase"

Router.onBeforeAction "loading"

Router.map ->
	
	@route "home",
		path: "/"
		onBeforeAction:  ()->
			AccountsEntry.signInRequired(this)
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
		onBeforeAction:  ()->
			AccountsEntry.signInRequired(this)
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
		onBeforeAction:  ()->
			AccountsEntry.signInRequired(this)
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
		onBeforeAction:  ()->
			AccountsEntry.signInRequired(this)
		waitOn:->
			[
				Meteor.subscribe 'orders'
			]
		data: ->
			orders: Orders.find({},{sort:{createdAt: -1}}).fetch()
	@route "order",
		path: '/orders/:_id'
		onBeforeAction:  ()->
			AccountsEntry.signInRequired(this)
		waitOn:->
			[
				Meteor.subscribe 'orders'
			]
		data: ->
			order: Orders.findOne {_id:@params._id}
	@route "checkout",
		path: '/checkout'
		onBeforeAction:  ()->
			AccountsEntry.signInRequired(this)
	@route "marketReports",
		path: '/reports'
		onBeforeAction:  ()->
			AccountsEntry.signInRequired(this)
		waitOn: ->
			[
				Meteor.subscribe 'reports'
			]
		data: ->
			reports: Reports.find({},{sort: {createdAt: -1}}).fetch()
	@route "news",
		path: '/news'
		onBeforeAction:  ()->
			AccountsEntry.signInRequired(this)
		waitOn: ->
			[
				Meteor.subscribe 'posts'
			]
		data: ->
			posts: Posts.find({},{sort: {createdAt: -1}}).fetch()
	@route "about",
		path: '/about'
		onBeforeAction:  ()->
			AccountsEntry.signInRequired(this)
	@route "profile",
		path: "/profile"
		onBeforeAction:  ()->
			AccountsEntry.signInRequired(this)