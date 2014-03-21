(function() {
  angular.module('gd.ui.jsonexplorer', []).directive('jsonExplorer', function() {
    return {
      restrict: 'EA',
      scope: {
        jsonData: '=jsonData'
      },
      template: '<div class="gd-ui-json-explorer"></div>',
      link: function(scope, elem, attrs) {
        var container, data;
        data = scope.jsonData;
        container = elem.find('div');
        if (data instanceof Array) {
          return container.text('[]');
        } else if (data instanceof Object) {
          return container.text('{}');
        }
      }
    };
  });

}).call(this);
