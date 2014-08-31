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
		cart = []
		Session.set 'cart',cart
		Router.go 'home'
	orderLength: ->
		cart = Session.get 'cart'
		cart.length
	orderRows: ->
		Session.get 'cart'
	update: (update)->
		cart = Session.get 'cart'
		_.each cart, (orderRow,i)->
			if orderRow.item == update.item && orderRow.unit == update.unit
				console.log update.quantity
				console.log parseFloat(update.quantity)
				if !isNaN parseFloat(update.quantity)
					cart[i].quantity = update.quantity
					Session.set 'cart',cart
				else
					alert 'Not a valid number'
	remove: (remove)->
		cart = Session.get 'cart'
		_.each cart, (orderRow,i)->
			if orderRow.item == remove.item && orderRow.unit == remove.unit
				cart.splice(i,1)
		Session.set 'cart',cart


if Meteor.isClient
	window.Cart = Cart
else if Meteor.isServer
	global.Cart = Cart


UI.registerHelper 'Cart', ->
	Cart