Module.register("MMM-TouchHandler", {
	notificationReceived: async function (noti, payload, sender) {
		if(noti == "DOM_OBJECTS_CREATED") {
			document.body.onmousedown = () => {
				this.sendNotification("SCENES_PREV");
			};
		}

		// Handle the clock size changes
		if(noti == "SCENES_CHANGED") {
			payload.then((p) => {
				if(p.currentScene.name != "Default") { 
					document.querySelector(".clock").classList.remove('big');
					document.querySelector(".clock").classList.add('small');
				} else if (p.currentScene.name == "Default") {
					document.querySelector(".clock").classList.remove('small');
					document.querySelector(".clock").classList.add('big');
				}
			})
		}
	}
})
