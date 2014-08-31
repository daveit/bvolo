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
			tableColumns: [
				{label: 'Reference',name:'reference'}
				{label:'Client',name:'owner',collection:'Users',collection_property: 'companyName'}
			]
		}
		Posts: {
			tableColumns: [
				{label: 'Title',name:'title'}
			]
		}
		Reports: {
			tableColumns: [
				{label: 'Title',name:'title'}
			]
		}

if Meteor.isClient
	window.AdminConfig = AdminConfig
else if Meteor.isServer
	global.AdminConfig = AdminConfig