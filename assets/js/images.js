	// Change this to your site's baseurl (same as in _config.yml)
	const baseurl = "{{ site.baseurl }}"; // This is a Liquid variable you must inject in your template

	document.addEventListener("DOMContentLoaded", () => {
		const images = document.querySelectorAll("img");

		images.forEach(img => {
			const src = img.getAttribute("src");
			if (src && !src.startsWith("http") && !src.startsWith(baseurl)) {
				// If src is relative and doesn't already start with baseurl, prefix it
				img.src = baseurl + (src.startsWith("/") ? "" : "/") + src;
			}
		});
	});