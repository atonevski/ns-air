var application;

require("./bundle-config");

application = require("application");

application.start({
  moduleName: "views/main/main-page"
});
