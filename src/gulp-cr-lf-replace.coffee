through = require 'through2'
{ File } = require 'gulp-util'

module.exports = (option) ->

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
    afterCode = getAfterCode option.afterCode

    afterContents = beforeContents.replace beforeCode, afterCode

    replaceFile = new File
      path: file.path
      contents: new Buffer afterContents, 'utf-8'

    @push replaceFile
    callback()


  # flush = (callback) ->
  #   callback()

  return through.obj transform#, flush
