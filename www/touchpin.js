module.exports = {

    store: function (key, token, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "TouchPin", "storePin", [key, token]);
    },

	 retrieve: function (key, text, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "TouchPin", "retrievePin", [key, text]);
    }

};
