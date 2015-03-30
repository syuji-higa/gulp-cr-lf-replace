var File, assign, clone, defOpts, ref, through;
through = require('through2');
File = require('gulp-util').File;
ref = require('lodash'), assign = ref.assign, clone = ref.clone;
defOpts = {
  changeCode: 'LF'
};
module.exports = function(opts) {
  var changeCode, transform;
  changeCode = assign(clone(defOpts), opts).changeCode;
  transform = function(file, encode, callback) {
    var afterCode, afterContents, beforeCode, beforeContents, getAfterCode, getBeforeCode;
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
    afterCode = getAfterCode(changeCode);
    afterContents = beforeContents.replace(beforeCode, afterCode);
    file.contents = new Buffer(afterContents, 'utf-8');
    this.push(file);
    return callback();
  };
  return through.obj(transform);
};
