gulp-cr-lf-replace
===============

```
gulp = require 'gulp'
crLfReplace = require 'gulp-cr-lf-replace'

gulp.task 'cr-lf-replace', ->
  gulp
    .src './htdocs/**/*.html'
    .pipe crLfReplace
      afterCode: 'CR+LF' # CR+LF, LF, CR
    .pipe gulp.dest './'
```
