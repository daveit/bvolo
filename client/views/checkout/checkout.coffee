Template.checkout.events
	'click .remove': (e,t) ->
		item = $(e.currentTarget).data('item')
		unit = $(e.currentTarget).data('unit')
		quantity = $(e.currentTarget).data('quantity')
		orderRow =
			item: item
			unit: unit
			quantity: quantity
		Cart.remove orderRow
	'change input.quantity': (e,t) ->
		item = $(e.currentTarget).data('item')
		unit = $(e.currentTarget).data('unit')
		quantity = $(e.currentTarget).val()
		orderRow =
			item: item
			unit: unit
			quantity: quantity
		Cart.update orderRow
	'click #reset': ->
		Cart.reset()
	'click #confirm': ->
		console.log 'ordering'
		order = {}
		order.owner = Meteor.userId()
		order.deliverBy = new Date $('[name="deliverBy"]').val()
		order.comments = $('[name="comments"]').val()
		order.orderNumber = $('[name="orderNumber"]').val()
		order.orderRows = Session.get 'cart'
		Orders.insert order, (e,r)->
			console.log e
			console.log r
			unless e
				Meteor.call 'alertOrder', r
				Router.go 'home'
		false