# Cordova TouchPin Plugin

A plugin that stores a secret in the iOS keychain protected by Touch ID.

## Using
Clone the plugin

    $ git clone https://github.com/pardeike/cordova-plugin-touchpin.git

Create a new Cordova Project

    $ cordova create touchpin net.pardeike.touchpinapp TouchPin

Install the plugin

    $ cd touchpin
    $ cordova plugin add ../cordova-plugin-touchpin


Edit `www/js/index.js` and add the following code inside `onDeviceReady`

```js
	touchpin.store("mykey", "mysecret", function(result) {
		alert(result);
	}, function() {
		alert("Error calling TouchPin");
	});
	touchpin.retrieve("mykey", "Please authenticate yourself", function(result) {
		alert(result);
	}, function() {
		alert("Error calling TouchPin");
	});
```

Install iOS platform

    cordova platform add ios

Run the code

    cordova run

## More Info

For more information on setting up Cordova see [the documentation](http://cordova.apache.org/docs/en/4.0.0/guide_cli_index.md.html#The%20Command-Line%20Interface)

For more info on plugins see the [Plugin Development Guide](http://cordova.apache.org/docs/en/4.0.0/guide_hybrid_plugins_index.md.html#Plugin%20Development%20Guide)
