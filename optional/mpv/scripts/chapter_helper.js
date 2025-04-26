/**
 * The format of external chapters file is as simple as a JSON array of time position numbers.
 * @example
 * [
 *   123.456,
 *   234.567
 * ]
 */

/**
 * @typdef ChapterNode
 * @property {string} title
 * @property {number} time
 */

/**
 * The external chapter time positions for current playing file.
 * @type {number[]|null}
 */
var chapterTimePositions = null;

/**
 * Remove the duplicate time positions and sort them.
 * @param {number[]} timePositions
 */
function _normalizeTimePositions(timePositions) {
    return timePositions.filter(function (v, i) {
        return timePositions.indexOf(v) === i;
    }).sort(function (a, b) {
        return a - b;
    });
}

function _updateMpvChapterList() {
    /** @type {ChapterNode[]} */
    var chapterNodes = [];
    for (var index in chapterTimePositions) {
        chapterNodes.push({
            title: "Chapter " + index,
            time: chapterTimePositions[index],
        });
    }
    mp.set_property_native("chapter-list", chapterNodes);
}

/**
 * @returns {string|null}
 */
function _getCurrentVideoBasePath() {
    var path = mp.get_property("path");
    if (!path) {
        return null;
    }
    return path.replace(/\.[^/.]+$/, "");
}

/**
 * Load external chapters from file (if it exists), which name is `${VideoFileBaseName}.chapters.json`.
 * @param {boolean} showOsdMessage
 */
function loadChaptersFromExternalFile(showOsdMessage) {
    chapterTimePositions = null; // reset

    var basePath = _getCurrentVideoBasePath();
    if (basePath === null) {
        if (!showOsdMessage) {
            mp.osd_message("Not playing any file!");
        }
        return;
    }

    var chapterPath = basePath + ".chapters.json";
    try {
        var chapterFileContent = mp.utils.read_file(chapterPath);
        var timePositions = JSON.parse(chapterFileContent);
        chapterTimePositions = _normalizeTimePositions(timePositions);
    } catch (e) {
        // do nothing
    }
    _updateMpvChapterList();
    if (!showOsdMessage) {
        mp.osd_message("External chapters loaded.");
    }
}

function saveChaptersToExternalFile() {
    var basePath = _getCurrentVideoBasePath();
    if (basePath === null) {
        mp.osd_message("Not playing any file!");
        return;
    }
    if (chapterTimePositions === null) {
        mp.osd_message("No chapter information to save!");
        return;
    }
    var chapterPath = basePath + ".chapters.json";
    var fileContent = JSON.stringify(chapterTimePositions, null, 2);
    mp.utils.write_file('file://' + chapterPath, fileContent);
    mp.osd_message("External chapters saved.");
}

/**
 * Add a new chapter at current playback position.
 */
function addChapter() {
    var pos = mp.get_property_number("time-pos/full");
    if (pos === null) {
        mp.osd_message("Not playing any file!");
        return;
    }
    if (chapterTimePositions === null) {
        chapterTimePositions = [pos];
        return;
    }
    if (chapterTimePositions.indexOf(pos) !== -1) {
        mp.osd_message("A chapter already exists at current position!");
        return;
    }
    chapterTimePositions.push(pos);
    chapterTimePositions.sort(function (a, b) {
        return a - b;
    });
    _updateMpvChapterList();
    mp.osd_message("Chapter added at current position.");
}

/**
 * Remove the last chapter.
 */
function removeChapter() {
    if (chapterTimePositions === null) {
        mp.osd_message("No chapter information to remove!");
        return;
    }
    chapterTimePositions.pop();
    _updateMpvChapterList();
    mp.osd_message("Last chapter removed.");
}

mp.add_hook("on_preloaded", 50, function () {
    loadChaptersFromExternalFile(true);
});

mp.register_script_message("load", function () {
    loadChaptersFromExternalFile(false);
});
mp.register_script_message("save", saveChaptersToExternalFile);
mp.register_script_message("add", addChapter);
mp.register_script_message("remove", removeChapter);
