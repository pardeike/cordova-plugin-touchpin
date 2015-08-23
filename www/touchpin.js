/*global cordova, module*/

module.exports = {

    store: function (token, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "TouchPin", "storePin", [token]);
    },

	 retrieve: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "TouchPin", "retrievePin", []);
    }

};