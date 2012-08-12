define([
    'dojo/dom',
    'dojo/dom-construct',
    'dojo/dom-style',
    'dojo/dom-geometry',
    'dojox/widget/Standby',
    'dojo/_base/fx',
    'dijit/layout/BorderContainer',
    'dijit/layout/ContentPane',
    'dojo/_base/window'
	], function(dom, domConstruct, domStyle, domGeometry, Standby, baseFx, borderContainer, contentPane, win) {
		var viewPort = null,
			loadingIndicator = null,

		startup = function() {
			viewPort = buildViewPort();
			viewPort.startup();
		},

		// Set visual indicators that the ui is loading
		startLoading = function(targetNode) {
            loadingIndicator = new Standby({
            	closable: false,
            	text: 'Loading ...',
            	target: win.body(),
            	zIndex: 1000
            }, domConstruct.create('div', {id: 'loadingIndicator'}, win.body()));
            loadingIndicator.startup();
            loadingIndicator.show();
		},

		endLoading = function() {
			loadingIndicator.hide();
		},

		buildViewPort = function() {
			return new borderContainer({
				isContainer: true,
				isLayoutContainer: true
			}, domConstruct.create('div', {id: 'viewPort'}, win.body()));
		};

		return {
			init: function() {
				startLoading();
				startup();
				endLoading();
			}
		}
	});