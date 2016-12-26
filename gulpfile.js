var gulp = require('gulp');
var connect = require('gulp-connect');

gulp.task('watch', function () {
  gulp.watch('source/styles/**/*.scss');

  connect.server({
    root: 'docs',
    port: 9090,
  });
});

gulp.task('default', ['watch']);
