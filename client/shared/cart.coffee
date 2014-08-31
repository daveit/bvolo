Template.home.events
	'click #add-to-cart': () ->
		quantity = parseFloat($('#quantity').val())
		unit = $('#unit').val()
		if !isNaN(quantity) && quantity != ''
			orderRow =
				item: Session.get 'item'
				unit: unit
				quantity: quantity
			Cart.add orderRow
			$('#quantity').val('')

		else
			alert 'Invalid number'

Deps.autorun ->
		Session.setDefault 'cart', []

Cart =
	add: (newOrderRow)->
		cart = Session.get 'cart'
		duplicate = false
		_.each cart, (orderRow,i)->
			if newOrderRow.item == orderRow.item && newOrderRow.unit == orderRow.unit
				cart[i].quantity += newOrderRow.quantity
				duplicate = true
		if not duplicate
			cart[cart.length] = newOrderRow
		Session.set 'cart',cart
	reset: ->
		cart = Session.get 'cart'
		cart.orderRows = []
		Session.set 'cart',cart
	orderLength: ->
		cart = Session.get 'cart'
		cart.length
	orderRows: ->
		Session.get 'cart'

if Meteor.isClient
	window.Cart = Cart
else if Meteor.isServer
	global.Cart = Cart


UI.registerHelper 'Cart', ->
	console.log Cart
	Cart