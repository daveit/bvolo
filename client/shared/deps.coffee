getRecent = ->
	orders = Orders.find().fetch()
	recent = []
	_.each orders, (order)->
		# console.log new Date().getTime()
		# console.log order.createdAt.getTime()
		# console.log order.createdAt.getTime() > (new Date().getTime() - (86400000 * Config.recentDays))
		if order.createdAt.getTime() > (new Date().getTime() - (86400000 * Config.recentDays))
			_.each order.orderRows, (orderRow)->
				if Session.get 'category'
					# console.log 'category'
					if Session.equals('category',Items.findOne({_id:orderRow.item}).category)
						recent.push orderRow.item
				else
					recent.push orderRow.item
	recent = _.uniq recent
	recent.map (_id)->
		Items.findOne {_id:_id}

Deps.autorun ->
		Meteor.subscribe 'items'
		Meteor.subscribe 'categories'
		Meteor.subscribe 'orders'

		if Session.get 'item'
			Session.set 'item_doc', Items.findOne {_id : Session.get 'item'}
		else
			Session.set 'item_doc', null

		if Session.get 'category'
			Session.set 'filter', { $and: [ { unavailable: false }, {category: Session.get 'category'} ] }
		else
			Session.set 'filter', { unavailable: false }

		Session.set 'recent', getRecent()

		if Meteor.userId() and not _.isNull(Router.current()) and Router.current().route.name == 'entrySignIn'
			Router.go 'home'