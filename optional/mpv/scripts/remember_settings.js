var DATA_PATH = '~~state/remember_settings.json';

var PROPERTIES = [
    'volume',
    'brightness',
    'contrast',
    'saturation',
    'gamma',
];

/**
 * @typedef Settings
 * @property {number} volume
 * @property {number} brightness
 * @property {number} contrast
 * @property {number} saturation
 * @property {number} gamma
 */

/**
 * @returns {Settings|null}
 */
function loadSettings() {
    try {
        var content = mp.utils.read_file(DATA_PATH);
        var config = JSON.parse(content);
        for (var keyIndex in PROPERTIES) {
            var key = PROPERTIES[keyIndex];
            var value = config[key];
            if (value !== undefined) {
                mp.set_property(key, value);
            }
        }
    } catch (e) {
        // do nothing
    }
}

function onShutdown() {
    var settings = {};
    for (var keyIndex in PROPERTIES) {
        var key = PROPERTIES[keyIndex];
        var value = mp.get_property(key);
        settings[key] = value;
    }
    var content = JSON.stringify(settings);
    mp.utils.write_file('file://' + DATA_PATH, content);
}

function main() {
    loadSettings();
    mp.register_event('shutdown', onShutdown);
}

main();
