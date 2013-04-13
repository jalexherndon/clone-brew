basePath = '../../../';

files = [
  ANGULAR_SCENARIO,
  ANGULAR_SCENARIO_ADAPTER,
  'spec/webapp/e2e/**/*.coffee',
  'spec/webapp/e2e/**/*.js'
];

autoWatch = false;

browsers = ['Chrome'];

singleRun = true;

proxies = {
  '/': 'http://localhost:3030/'
};

junitReporter = {
  outputFile: 'spec_out/e2e.xml',
  suite: 'e2e'
};
