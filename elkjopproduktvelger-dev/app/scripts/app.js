/*
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/

(function(document) {
  'use strict';

  // Grab a reference to our auto-binding template
  // and give it some initial binding values
  // Learn more about auto-binding templates at http://goo.gl/Dx1u2g
  var app = document.querySelector('#app');
  var header;
  var results;
  app.answers = {};

  function loadTVs() {
    fetch('../json/tv.json').then(function(response) {
      return response.json();
    }).then(function(data) {
      app.tvArray = data;
      results.set('tvArray',data);
      header.numberOfTvsLeft = app.tvArray.length;
    }).catch(function() {
      loadTVs();
    });
  }
  loadTVs();

  app.filterTV = function(answers) {
    console.log(answers);
    var filteredArray = app.tvArray
    console.log(filteredArray.length);
    if (answers.price) {
      var tempArray = [];
      filteredArray.forEach(function(el, i) {
        var price = parseInt(el.price);
        if (price <= answers.price.max && price >= answers.price.min) {
          tempArray.push(el);
        }
      })
      filteredArray = tempArray;
    }
    if (answers.size) {
      var tempArray = [];
      filteredArray.forEach(function(el, i) {
        var size = parseInt(el['Skjermstørrelse (tommer/\")']);
        if (size <= answers.size.max && size >= answers.size.min) {
          tempArray.push(el);
        }
      })
      filteredArray = tempArray;
    }
    if (answers.important) {
      if(answers.important.ultrahd && answers.important.hz) {
        var tempArray = [];
        filteredArray.forEach(function(el, i) {
          var resolution = el['Høyeste støttede TV-oppløsning'];
          var hz = parseInt(el['Bildepanelfrekvens (Hz)'])
          if (resolution == "Ultra HD/4K (2160p)" && hz >= 100) {
            tempArray.push(el);
          }
        })
        filteredArray = tempArray;
      } else if (answers.important.ultrahd) {
        var tempArray = [];
        filteredArray.forEach(function(el, i) {
          var resolution = el['Høyeste støttede TV-oppløsning'];
          if (resolution == "Ultra HD/4K (2160p)") {
            tempArray.push(el);
          }
        })
        filteredArray = tempArray;
      } else if (answers.important.hz) {
        var tempArray = [];
        filteredArray.forEach(function(el, i) {
          var hz = parseInt(el['Bildepanelfrekvens (Hz)'])
          if (hz >= 100) {
            tempArray.push(el);
          }
        })
        filteredArray = tempArray;
      }
    }
    if (answers.brands) {
      var tempArray = [];
    }
    if (answers.placement) {
      var tempArray = [];
      if (answers.placement.wallmount) {
        filteredArray.forEach(function(el, i) {
          var veggfesteStandard = el['Veggfeste standard'];
          if (veggfesteStandard != undefined) {
            tempArray.push(el);
          }
        })
        filteredArray = tempArray;
      }
    }
    if (answers.screen) {
      var tempArray = [];
      if (answers.screen.oled) {
        filteredArray.forEach(function(el, i) {
          var screenType = el['Paneltype'];
          if (screenType == "OLED") {
            tempArray.push(el);
          }
        })
        filteredArray = tempArray;
      } else if (answers.screen.led) {
        filteredArray.forEach(function(el, i) {
          var screenType = el['Paneltype'];
          if (screenType == "LED" || screenType == "LCD m/LED") {
            tempArray.push(el);
          }
        })
        filteredArray = tempArray;
      } else if (answers.screen.lcd) {
        filteredArray.forEach(function(el, i) {
          var screenType = el['Paneltype'];
          if (screenType == "LCD" || screenType == "LCD m/LED") {
            tempArray.push(el);
          }
        })
        filteredArray = tempArray;
      }

    }
    if (answers.smarttv) {
      var tempArray = [];
      if (answers.smarttv.smart) {
        filteredArray.forEach(function(el, i){
          var smart = el['Støtte for nettapplikasjoner'];
          if (smart == "Ja") {
            tempArray.push(el);
          };
        })
        filteredArray = tempArray;
      }
    }
    if (answers.threed) {
      var tempArray = [];
      if (answers.threed.threed) {
        filteredArray.forEach(function(el, i){
          var threed = el['3D-klar'];
          if (threed == "Ja") {
            tempArray.push(el);
          };
        })
        filteredArray = tempArray;
      }
    }
    
    if (answers.curved) {
      var tempArray = [];
      if (answers.curved.curved) {
        filteredArray.forEach(function(el, i){
          var type = el['Skjermtype'];
          if (type == "Buet (Curved)") {
            tempArray.push(el);
          };
        })
        filteredArray = tempArray;
      }
      if (answers.curved.flat) {
        filteredArray.forEach(function(el, i){
          var type = el['Skjermtype'];
          if (type == "Flat") {
            tempArray.push(el);
          };
        })
        filteredArray = tempArray;
      }
    }
    console.log(filteredArray.length);
    results.set('tvArray',filteredArray);
    header.numberOfTvsLeft = filteredArray.length;
  }

  // Sets app default base URL
  app.baseUrl = '/';
  if (window.location.port === '') {  // if production
    // Uncomment app.baseURL below and
    // set app.baseURL to '/your-pathname/' if running from folder in production
    // app.baseUrl = '/polymer-starter-kit/';
  }

  app.displayInstalledToast = function() {
    // Check to make sure caching is actually enabled—it won't be in the dev environment.
    if (!Polymer.dom(document).querySelector('platinum-sw-cache').disabled) {
      Polymer.dom(document).querySelector('#caching-complete').show();
    }
  };

  // See https://github.com/Polymer/polymer/issues/1381
  window.addEventListener('WebComponentsReady', function() {
    header = app.$.etvApp.$.header;
    results = app.$.etvApp.$.results;
  });

  // Main area's paper-scroll-header-panel custom condensing transformation of
  // the appName in the middle-container and the bottom title in the bottom-container.
  // The appName is moved to top and shrunk on condensing. The bottom sub title
  // is shrunk to nothing on condensing.

})(document);
