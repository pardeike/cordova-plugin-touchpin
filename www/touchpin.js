/*global cordova, module*/

module.exports = {

    store: function (domain, key, value, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "TouchPin", "store", [domain, key, value]);
    }

};