Meteor.methods
	alertOrder: (_id)->
		order = Orders.findOne {_id:_id}
		user = Meteor.users.findOne {_id:order.owner}

		#Send ordering emails
		to = Config.emails.notification
		subject = '[#'+order.reference+' - '+user.profile.companyName+'] New customer order'

		html = ""
		html += 'New order (<a href="'+Meteor.absoluteUrl('admin/Orders' + order._id ) + '">order #' + order.reference + '</a>) - ' + user.profile.companyName + '(ID: ' + user.username + ')'
		html += '<br/><br/>'
		html += 'Delivery expected: ' + dateToDateString order.deliverBy
		html += '<br/><br/>'
		if order.comments
			html += '<br/><br/>'
			html += 'Order notes: ' + order.comments
			html += '<br/><br/>'
		html += '<h2>Items</h2>'
		html += '<table><thead><th>Item</th><th>ID</th><th>Quantity</th><th>Unit</th><tbody>'

		_.each order.orderRows, (orderRow)->
			html += '<tr>'
			html += '<td>'+Items.findOne(_id:orderRow.item).name+'</td>'
			html += '<td>'+Items.findOne(_id:orderRow.item).id+'</td>'
			html += '<td>'+orderRow.quantity+'</td>'
			html += '<td>'+orderRow.unit+'</td>'
			html += '</tr>'

		html += '</tbody></table>'

		Email.send
			from: Config.emails.from
			to: Config.emails.notification
			html: html