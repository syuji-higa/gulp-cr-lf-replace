through = require 'through2'
{ File } = require 'gulp-util'
{ assign, clone } = require 'lodash'

defOpts =
  changeCode: 'LF'

module.exports = (opts) ->

  { changeCode } = assign clone(defOpts), opts

  transform = (file, encode, callback) ->

    getBeforeCode = (str) ->
      if str.match '\r\n'
        /\r\n/g
      else if str.match '\n'
        /\n/g
      else if str.match '\r'
        /\r/g

    getAfterCode = (code) ->
      switch code
        when 'CR+LF'
          '\r\n'
        when 'LF'
          '\n'
        when 'CR'
          '\r'

    beforeContents = file.contents.toString()

    beforeCode = getBeforeCode beforeContents
    afterCode = getAfterCode changeCode

    afterContents = beforeContents.replace beforeCode, afterCode

    file.contents = new Buffer afterContents, 'utf-8'

    @push file
    callback()

  # flush = (callback) ->
  #   callback()

  return through.obj transform#, flush
