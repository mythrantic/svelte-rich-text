<script>
	import { browser } from '$app/environment';
	import { ValiantRichText } from '$lib/index.js';
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

<h1 class="demo-title">Simple Demo</h1>
<div class="demo-wrapper">
	<div class="editor-container">
		<ValiantRichText bind:editor {content} {onUpdate} />
	</div>
</div>

<style>
	.demo-title {
		margin-bottom: 1.5rem;
		margin-top: 3rem;
		text-align: center;
		font-size: 1.875rem;
		font-weight: 700;
	}

	.demo-wrapper {
		background-color: var(--color-background, #ffffff);
		z-index: 50;
		margin: 3rem auto;
		width: 100%;
		max-width: 80rem;
		border-radius: 0.375rem;
		border: 1px dashed;
	}

	.editor-container {
		overflow-y: scroll;
		border: 1px solid;
		padding-right: 0.5rem;
		padding-left: 1.5rem;
	}
</style>