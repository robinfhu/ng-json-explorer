(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  angular.module('nv.ui.jsonexplorer', []).directive('jsonExplorer', function() {
    return {
      restrict: 'EA',
      scope: {
        jsonData: '=jsonData'
      },
      template: '<div class="nv-ui-json-explorer"></div>',
      link: function(scope, elem, attrs) {
        var circularRefCheck, countProperties, createCollapseButton, createEllipsis, expandAll, mainContainer, processData, references;
        countProperties = function(data) {
          var count, key;
          count = 0;
          for (key in data) {
            count++;
          }
          return count;
        };
        expandAll = attrs.expand != null;

        /*
        		Show a +/- symbol which lets user expand and collapse
        		the object
         */
        createCollapseButton = function() {
          var collapser, defaultSymbol;
          collapser = angular.element(document.createElement('span'));
          defaultSymbol = expandAll ? '-' : '+';
          collapser.addClass('collapser').text(defaultSymbol);
          collapser.on('click', function(evt) {
            var collapsible, ellipsis, ellipsisElems, isPlus;
            isPlus = evt.target.innerText === '+';
            evt.target.innerText = isPlus ? '-' : '+';
            collapsible = angular.element(evt.target.parentNode.querySelector('ul.collapsible'));
            ellipsisElems = evt.target.parentNode.querySelectorAll('.ellipsis');
            ellipsis = angular.element(ellipsisElems[ellipsisElems.length - 1]);
            if (isPlus) {
              collapsible.removeClass('hide');
              return ellipsis.addClass('hide');
            } else {
              collapsible.addClass('hide');
              return ellipsis.removeClass('hide');
            }
          });
          return collapser;
        };
        createEllipsis = function(liElem) {
          if (!expandAll) {
            angular.element(liElem.find('ul')[0]).addClass('hide');
          }
          return angular.element(liElem.find('ul')[0]).after("<span class='ellipsis'>&hellip;</span>");
        };

        /*
        		Logic that checks if an object has been processed or not.
        		Without this logic, circular JSON objects would never stop processing,
        		since we use recursion.
        
        		If the object has not been seen yet, recursively process it.
         */
        references = [];
        circularRefCheck = function(val, container) {
          if (angular.isObject(val)) {
            if (__indexOf.call(references, val) < 0) {
              references.push(val);
              return processData(val, container);
            } else {
              return container.append(' #Circular Reference');
            }
          } else {
            return processData(val, container);
          }
        };

        /*
        		Recursively process a JSON object.
        		Renders a DOM structure that looks nice to the user
         */
        processData = function(data, container) {
          var index, isEmpty, isObject, key, li, numProps, ul, val, _i, _len;
          if (data instanceof Array) {
            container.append('[');
            if (data.length > 0) {
              ul = angular.element(document.createElement('ul'));
              ul.addClass('array collapsible');
              for (index = _i = 0, _len = data.length; _i < _len; index = ++_i) {
                val = data[index];
                li = angular.element(document.createElement('li'));
                isObject = angular.isObject(val);
                if (isObject) {
                  li.append(createCollapseButton());
                }
                li.append("" + index + ": &nbsp;");
                circularRefCheck(val, li);
                if (isObject) {
                  createEllipsis(li);
                }
                if (index < (data.length - 1)) {
                  li.append(',');
                }
                ul.append(li);
              }
              container.append(ul);
            }
            return container.append(']');
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
                isObject = angular.isObject(val);
                if (isObject) {
                  li.append(createCollapseButton());
                }
                li.append("<span class='prop'>" + key + "</span>");
                li.append(': &nbsp;');
                circularRefCheck(val, li);
                if (isObject) {
                  createEllipsis(li);
                }
                index++;
                if (index < numProps) {
                  li.append(',');
                }
                ul.append(li);
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
        mainContainer = elem.find('div');
        return scope.$watch('jsonData', function(newData) {
          mainContainer.empty();
          references = [];
          return processData(newData, mainContainer);
        });
      }
    };
  });

}).call(this);
