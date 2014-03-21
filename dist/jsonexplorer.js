(function() {
  angular.module('gd.ui.jsonexplorer', []).directive('jsonExplorer', function() {
    return {
      restrict: 'EA',
      scope: {
        jsonData: '=jsonData'
      },
      template: '<div class="gd-ui-json-explorer"></div>',
      link: function(scope, elem, attrs) {
        var countProperties, mainContainer, processData;
        mainContainer = elem.find('div');
        countProperties = function(data) {
          var count, key;
          count = 0;
          for (key in data) {
            count++;
          }
          return count;
        };
        processData = function(data, container) {
          var index, isEmpty, key, li, numProps, ul, val;
          if (data instanceof Array) {
            return container.text('[]');
          } else if (data instanceof Object) {
            numProps = countProperties(data);
            isEmpty = numProps === 0;
            container.append('{');
            if (!isEmpty) {
              ul = angular.element(document.createElement('ul'));
              ul.addClass('obj collapsible');
              index = 0;
              for (key in data) {
                val = data[key];
                li = angular.element(document.createElement('li'));
                ul.append(li);
                li.append("<span class='prop'>" + key + "</span>");
                li.append(': &nbsp;');
                processData(val, li);
                index++;
                if (index < numProps) {
                  li.append(',');
                }
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
        return processData(scope.jsonData, mainContainer);
      }
    };
  });

}).call(this);
