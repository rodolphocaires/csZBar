var argscheck = require('cordova/argscheck'),
    exec      = require('cordova/exec');

function ZBar () {};

ZBar.prototype = {

    scan: function (params, success, failure)
    {
        argscheck.checkArgs('*fF', 'CsZBar.scan', arguments);

        params = params || {};
        if(params.text_title === undefined) params.text_title = "Scan QR Code";
        if(params.camera != "front") params.camera = "back";
        if(params.flash != "on" && params.flash != "off") params.flash = "auto";

        exec(success, failure, 'CsZBar', 'scan', [params]);
    },

};

module.exports = new ZBar;
