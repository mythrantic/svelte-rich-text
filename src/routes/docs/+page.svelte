<script>
	import { browser } from '$app/environment';
	import { EdraEditor } from '$lib/components/edra/headless/index.js';
	import defaultContent from '$lib/default_content.js';

	// Editor states
	let content = $state();
	let editor = $state();

	$effect(() => {
		console.log('[DEBUG] Content', content);
		localStorage.setItem('edra-content', JSON.stringify(content));
	});

	if (browser) {
		const rawDataString = localStorage.getItem('edra-content');

		if (rawDataString === null) {
			content = defaultContent;
		} else {
			const rawData = JSON.parse(rawDataString);
			content = rawData;
		}
	}

	function onUpdate() {
		content = editor?.getJSON();
	}
</script>

<h1 class="mb-6 mt-12 text-center text-3xl font-bold">Simple Demo</h1>
<div class="bg-background z-50 mx-auto mt-12 size-full max-w-5xl rounded-md border border-dashed">
	<div class="h-[30rem] overflow-y-scroll border pr-2 pl-6">
		<EdraEditor bind:editor {content} {onUpdate} />
	</div>
</div>