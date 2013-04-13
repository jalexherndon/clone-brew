basePath = '../../../';

files = [
  JASMINE,
  JASMINE_ADAPTER,
  'public/lib/angular/angular.js',
  'public/lib/angular/angular-*.js',
  'spec/webapp/lib/angular/angular-mocks.js',
  'public/lib/requirejs/requirejs.js',
  'webapp/**/*.coffee',
  'spec/webapp/unit/**/*.coffee'
];

autoWatch = true;

browsers = ['Chrome'];

junitReporter = {
  outputFile: 'spec_out/unit.xml',
  suite: 'unit'
};
