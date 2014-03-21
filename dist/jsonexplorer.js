(function() {
  angular.module('gd.ui.jsonexplorer', []).directive('jsonExplorer', function() {
    return {
      restrict: 'EA',
      scope: {
        jsonData: '=jsonData'
      },
      template: '<div class="gd-ui-json-explorer"></div>',
      link: function(scope, elem, attrs) {
        var data, mainContainer, processData;
        data = scope.jsonData;
        mainContainer = elem.find('div');
        processData = function(data, container) {
          var isEmpty, key, li, ul, val;
          if (data instanceof Array) {
            return container.text('[]');
          } else if (data instanceof Object) {
            isEmpty = JSON.stringify(data) === '{}';
            container.append('{');
            if (!isEmpty) {
              ul = angular.element(document.createElement('ul'));
              ul.addClass('obj collapsible');
              for (key in data) {
                val = data[key];
                li = angular.element(document.createElement('li'));
                ul.append(li);
                li.append("<span class='prop'>" + key + "</span>");
                processData(val, li);
              }
              container.append(ul);
            }
            return container.append('}');
          } else if (typeof data === 'number') {
            return container.append("<span class='num'>" + data + "</span>");
          } else if (typeof data === 'string') {
            return container.append("<span class='string'>\"" + data + "\"</span>");
          } else if (typeof data === 'boolean') {
            return container.append("<span class='bool'>" + data + "</span>");
          } else if (data == null) {
            return container.append("<span class='null'>null</span>");
          }
        };
        return processData(data, mainContainer);
      }
    };
  });

}).call(this);
