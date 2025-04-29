Module.register('MMM-Games', {
	// Default config
	defaults: {
		name: 'MMM-Games',
		desiredFrameRate: 5,
	},

	// MM start function
	start: function() {
		Log.info(`Starting module: ${this.name}`);
		this.sanitizeConfig();
	},

	// Used by MM when getting the module's DOM
	getDom: function() {
		const wrapper = document.createElement('div');
		wrapper.id = 'gameWrapper';

		return wrapper;
	},

	// Used by MM when getting the module's scripts
	// This loads in p5 to use its functions
	// Also loads all the function files
	getScripts: function() {
		return [
			'https://cdn.jsdelivr.net/npm/p5@1.11.3/lib/p5.min.js', // p5
		];
	},

	// MM hook for when a notification is received
	notificationReceived: function(notification) {
		// The module is fully loaded, so start the program
		if (notification === 'DOM_OBJECTS_CREATED') {
			Log.info('DOM objects are created. Starting P5 …');

			const sketch = this.makeSketch(this.config);
			new p5(sketch, 'gameWrapper');
		}
	},

	// Sanitizes the config
	sanitizeConfig: function() {
		if (this.config.desiredFrameRate < 1) this.config.desiredFrameRate = 1;
	},

	// Creates the p5 sketch
	makeSketch: function(conf) {
		return function(pFive) {
			const desiredFrameRate = conf.desiredFrameRate;
			const zoom = 0.95; // Should be equal to the value in custom.css
			const width = window.innerWidth / zoom;
			const height = window.innerHeight / zoom;

			pFive.setup = function() {
				pFive.frameRate(desiredFrameRate);
				pFive.createCanvas(width, height);

				pFive.background(167, 199, 231);
			};

			pFive.draw = function() {
				pFive.circle(width / 20, height / 20, 20);
			};
		};
	},
});
