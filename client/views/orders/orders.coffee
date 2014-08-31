Template.orders.events
	'click .reorder': (e,t) ->
		order = Orders.findOne {_id : $(e.currentTarget).data('id')}
		Session.set 'cart', order.orderRows
		Router.go 'checkout'