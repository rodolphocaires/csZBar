var argscheck = require('cordova/argscheck'),
    exec = require('cordova/exec');

function ZBar() { };

ZBar.prototype = {

    scan: function (params, success, failure) {
        argscheck.checkArgs('*fF', 'CsZBar.scan', arguments);

        params = params || {};
        if (!params.text_title) params.text_title = "Scan QR Code";
        if (!params.camera || params.camera !== "front") params.camera = "back";
        if (params.flash !== "on" && params.flash !== "off") params.flash = "auto";
        if (!params.preferred_orientation) params.preferred_orientation = "landscape";
        if (!params.header_alpha) params.header_alpha = 'ff';
        if (!params.header_color) params.header_color = '004a87';

        exec(success, failure, 'CsZBar', 'scan', [params]);
    },

};

module.exports = new ZBar;
