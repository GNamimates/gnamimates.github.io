function storageAvailable(type) {
	let storage;
	try {
		storage = window[type];
		const x = "__storage_test__";
		storage.setItem(x, x);
		storage.removeItem(x);
		return true;
	} catch (e) {
		return (
			e instanceof DOMException &&
			e.name === "QuotaExceededError" &&
			// acknowledge QuotaExceededError only if there's something already stored
			storage &&
			storage.length !== 0
		);
	}
}

var theme = 0;

if (storageAvailable("localStorage")) {
	// exists
}else{
	if (window.matchMedia) {
		const isDarkMode = () => window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
		if (isDarkMode()) {
			theme = 1;
		}else{
			theme = 0;
		}
	}
}

const themes = [
	{
		name: "Light",
		background: "var(--white)",
		backgroundBorder: "var(--light-gray)",
		heroText: "var(--white)",
		text: "var(--black)",
		image: "url('img/hero.jpg')"
	},
	{
		name: "Dark",
		background: "var(--dark-gray)",
		backgroundBorder: "var(--gray)",
		heroText: "var(--white)",
		text: "var(--white)",
		image: "url('img/hero-dark.jpg')"
	}
]


function applyTheme(id) {
	var themeData = themes[id];
	document.documentElement.style.setProperty('--color-background', themeData.background);
	document.documentElement.style.setProperty('--color-background-border', themeData.backgroundBorder);
	document.documentElement.style.setProperty('--color-text', themeData.text);
	document.documentElement.style.setProperty('--color-hero-text', themeData.heroText);
	document.documentElement.style.setProperty('--image-hero', themeData.image);
}

applyTheme(1)