window.addEventListener('load', function (ev) {
  var appArea = document.querySelector("#flutter_target");
  _flutter.loader.loadEntrypoint({
    serviceWorker: {
      serviceWorkerVersion: serviceWorkerVersion,
    },
    onEntrypointLoaded: function (engineInitializer) {
      engineInitializer.initializeEngine({
        hostElement: appArea,
      }).then(function (appRunner) {
        appRunner.runApp();
      });
    }
  });
});