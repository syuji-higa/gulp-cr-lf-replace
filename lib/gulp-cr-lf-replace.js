var File, through;
through = require('through2');
File = require('gulp-util').File;
module.exports = function(option) {
  var transform;
  transform = function(file, encode, callback) {
    var afterCode, afterContents, beforeCode, beforeContents, getAfterCode, getBeforeCode, replaceFile;
    getBeforeCode = function(str) {
      if (str.match('\r\n')) {
        return /\r\n/g;
      } else if (str.match('\n')) {
        return /\n/g;
      } else if (str.match('\r')) {
        return /\r/g;
      }
    };
    getAfterCode = function(code) {
      switch (code) {
        case 'CR+LF':
          return '\r\n';
        case 'LF':
          return '\n';
        case 'CR':
          return '\r';
      }
    };
    beforeContents = file.contents.toString();
    beforeCode = getBeforeCode(beforeContents);
    afterCode = getAfterCode(option.afterCode);
    afterContents = beforeContents.replace(beforeCode, afterCode);
    replaceFile = new File({
      path: file.path,
      contents: new Buffer(afterContents, 'utf-8')
    });
    this.push(replaceFile);
    return callback();
  };
  return through.obj(transform);
};
