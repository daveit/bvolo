Deps.autorun ->
		Meteor.subscribe 'items'
		Meteor.subscribe 'categories'
		Meteor.subscribe 'orders'

		if Session.get 'item'
			Session.set 'item_doc', Items.findOne {_id : Session.get 'item'}
		else
			Session.set 'item_doc', null

		if Session.get 'category'
			Session.set 'filter', {category: Session.get 'category'}
		else
			Session.set 'filter', {}
