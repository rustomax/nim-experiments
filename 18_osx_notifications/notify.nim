import notifications/macosx

var center = newNotificationCenter()

discard center.show("Cool notification", "Hello, world!")
echo("Notification has been displayed!")
