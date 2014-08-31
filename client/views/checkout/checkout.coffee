# AutoForm.hooks
# 	updateProfile:
# 		onSuccess: ->
# 			Router.go('home')

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