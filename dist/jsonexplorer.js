(function() {
  angular.module('gd.ui.jsonexplorer', []).directive('jsonExplorer', function() {
    return {
      restrict: 'EA',
      scope: {
        jsonData: '=jsonData'
      },
      template: '<div class="gd-ui-json-explorer"></div>',
      link: function(scope, elem, attrs) {}
    };
  });

}).call(this);
