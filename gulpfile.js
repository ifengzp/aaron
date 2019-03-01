var gulp = require('gulp');
var cleanCSS = require('gulp-clean-css');
var uglify = require('gulp-uglify');
var htmlmin = require('gulp-htmlmin');
var babel = require('gulp-babel');

gulp.task('minify-css', () => {
    return gulp.src('./public/**/*.css')
        .pipe(cleanCSS({
          compatibility: 'ie8',
          rebase: false
        }))
        .pipe(gulp.dest('./public'));
});

gulp.task('minify-html', () => {
    return gulp.src('./public/**/*.html')
      .pipe(htmlmin({ 
          collapseWhitespace: true,
          minifyJS: true,
          minifyCSS: true,
          minifyURLs: true,
        }))
      .pipe(gulp.dest('./public'))
  });

gulp.task('minify-js', function () {
    return gulp.src(['./public/**/*.js', '!./public/**/*.min.js'])
        .pipe(babel({
          ignore: [
            './public/**/jquery/*.js',
            './public/**/scrollspy.js',
            './public/**/affix.js',
          ]
        }))
        .pipe(uglify())
        .pipe(gulp.dest('./public'));
});

gulp.task('default', gulp.series('minify-html', 'minify-css', 'minify-js'));