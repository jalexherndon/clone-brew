var dojoConfig = {
	baseUrl: "/assets/",
	tlmSiblingOfDojo: false,
    isDebug: true,
    parseOnLoad: true,
    async: true,
	packages: [{
		name: "dojo",
		location: "dojotoolkit/1.7.3/dojo"
	}, {
		name: "dijit",
		location: "dojotoolkit/1.7.3/dijit"
	}, {
		name: "dojox",
		location: "dojotoolkit/1.7.3/dojox"
	}, {
		name: "Brew",
		location: ".",
		main: "App"
	}]
};
