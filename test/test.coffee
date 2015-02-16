CrLfReplace = require '../lib/gulp-cr-lf-replace'
{ File } = require 'gulp-util'
{ PassThrough } = require 'stream'
{ join } = require 'path'
fs = require 'fs'

createFile = (path) ->
  path = join __dirname, './fixtures', path
  new File
    path: path
    contents: fs.readFileSync path

describe 'gulp-cr-lf-replace', ->

  it "replace line feed code", (done) ->
    stream = CrLfReplace
      afterCode: 'CR+LF'
    stream.on 'data', (file) ->
      fs.writeFile file.path, file.contents, 'binary', (err) ->
        if err then console.log err
    stream.on 'end', ->
      done()
    stream.write createFile 'index.html'
    stream.end()