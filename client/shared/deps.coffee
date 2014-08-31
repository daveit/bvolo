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
						recent.push Items.findOne {_id:orderRow.item}
				else
					# console.log 'no category'
					recent.push Items.findOne {_id:orderRow.item}

				# console.log orderRow
		# console.log typeof order.createdAt
	recent

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
