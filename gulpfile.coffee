gulp = require('gulp')
nodemon = require('gulp-nodemon')
plumber = require('gulp-plumber')
livereload = require('gulp-livereload')
sass = require('gulp-ruby-sass')

gulp = require('gulp')
coffee = require('gulp-coffee')
sourcemaps = require('gulp-sourcemaps')
watch = require('gulp-watch')
gutil = require('gutil')

gulp.task 'coffee', ->
  gulp.src('./**/*.coffee')
  .pipe sourcemaps.init()
  .pipe coffee(bare: true)
  .on 'error', gutil.log
  .pipe sourcemaps.write('./')
  .pipe gulp.dest('./')

gulp.task 'sass', ->
  sass('./public/css/**/*.scss')
  .pipe gulp.dest('./public/css')
  .pipe livereload()

gulp.task 'watch', ->
  gulp.watch './public/css/*.scss', ['sass']
  gulp.run 'coffee'
  gulp.watch './**/*.coffee', ['coffee']

gulp.task 'develop', ->
  livereload.listen()
  nodemon(
    script: 'bin/www'
    ext: 'js handlebars coffee'
    stdout: false).on 'readable', ->
      @stdout.on 'data', (chunk) ->
        if /^Express server listening on port/.test(chunk)
          #noinspection JSUnresolvedVariable
          livereload.changed __dirname

      @stdout.pipe process.stdout
      @stderr.pipe process.stderr

gulp.task 'default', [
  'sass'
  'develop'
  'watch'
]
