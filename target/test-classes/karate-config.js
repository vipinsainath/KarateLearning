function fn() {
  var env = karate.env;
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'prod';
  }

  var config = {
    env: env,
    myVarName: 'hello karate',
    baseUrl: 'https://gorest.co.in'
  };
  if (env == 'dev') {
    config.baseUrl = 'https://dev.gorest.co.in';
    config.authToken = 'dev-token-123';
  } else if (env == 'e2e') {
    config.baseUrl = 'https://e2e.gorest.co.in';
    config.authToken = 'e2e-token-xyz';
  } else if (env == 'prod') {
    config.baseUrl = 'https://gorest.co.in';
    config.authToken = 'prod-token-secure';
  }

  return config;
}
