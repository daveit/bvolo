AdminConfig =
	adminEmails: ['benjaminpeterjonesesquire@gmail.com','dave.southperth@gmail.com']
	fromEmail: 'noreply@app.com'
	collections :
		Items: {
			tableColumns: [
				{label: 'Name',name:'name'}
				{label:'Category',name:'category',collection:'Categories',collection_property: 'name'}
				{label:'Out of stock',name:'unavailable'}
			]
			auxCollections: ['Categories']
		}
		Categories: {
			tableColumns: [
				{label: 'Name',name:'name'}
			]
		}
		Orders: {
			auxCollections: ['Items','Categories']
		}
		Posts: {}

if Meteor.isClient
	window.AdminConfig = AdminConfig
else if Meteor.isServer
	global.AdminConfig = AdminConfig