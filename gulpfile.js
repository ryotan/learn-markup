var gulp = require('gulp');
var connect = require('gulp-connect');
var styledocco = require('gulp-styledocco');

gulp.task('styledocco', function () {
  gulp.src(['source/styles/application.scss'])
    .pipe(styledocco({
      out: 'docs/styles',
      name: '\"Blog Theme\"'
    }));
});

gulp.task('watch', function () {
  gulp.watch('source/styles/**/*.scss', ['styledocco']);

  connect.server({
    root: 'docs',
    port: 9090,
    livereload: false // 何か、styledoccoで作ったドキュメントと相性悪すぎ。
  });
});

gulp.task('default', ['watch']);
