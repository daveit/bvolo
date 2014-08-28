AdminConfig =
    adminEmails: ['benjaminpeterjonesesquire@gmail.com','craig.w.griffin@gmail.com']
    fromEmail: 'noreply@app.com'
    collections : 
        Posts: {
            icon: 'pencil'
        }

if Meteor.isClient
	window.AdminConfig = AdminConfig

if Meteor.isServer
	global.AdminConfig = AdminConfig