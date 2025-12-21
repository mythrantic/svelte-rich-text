<script>
	// custom
	import Main from '$lib/components/core/main.svelte';
	import { ValiantRichText, getData } from '$lib/index';

	// mdvex
	import { browser } from '$app/environment';
	import { EdraEditor, EdraToolBar } from '$lib/components/edra/headless/index.js';
	import defaultContent from '$lib/default_content.js';

	// Editor states
	let content = $state();
	let editor = $state();

	$effect(() => {
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

<div class="container">
	<div class="section">
		<h1>Rich Text Editor - Custom</h1>

		<ValiantRichText
			initialData={[
				{
					id: '123',
					name: 'paragraph',
					data: { text: 'hello im a paragraph' }
				},
				{
					id: '12',
					name: 'header',
					data: { text: 'hello im a header', level: 1 }
				},
				{
					id: '14',
					name: 'quote',
					data: { text: 'my quote', owner: 'me' }
				}
			]}
		/>
		<button
			class="save-button"
			onclick={() => {
				console.log(getData());
			}}
		>
			save
		</button>
	</div>

	<div class="section">
		<h1>Rich Text Viewer - mdvex</h1>
						<EdraEditor bind:editor {content} {onUpdate} editable={false} />

		<div class="bg-background z-50 mx-auto mt-12 size-full max-w-5xl rounded-md border border-dashed">
			<div class="h-[30rem] overflow-y-scroll border pr-2 pl-6">
			</div>
		</div>
	</div>

	<div id="commento" class="section"></div>
</div>

<style>
	.container {
		display: flex;
		flex-wrap: wrap;
		justify-content: center;
		background-color: var(--background, #d0bd79);
		z-index: 50;
		margin: 3rem;
		gap: 2rem;
	}

	.section {
		width: 100%;
		max-width: 56rem;
	}

	h1 {
		text-align: center;
		margin-bottom: 1.5rem;
	}

	.save-button {
		margin-top: 1rem;
		padding: 0.5rem 1rem;
		background-color: #3b82f6;
		color: white;
		border: none;
		border-radius: 0.25rem;
		cursor: pointer;
		display: block;
		margin-left: auto;
		margin-right: auto;
	}

	.save-button:hover {
		background-color: #2563eb;
	}

	@media screen and (width < 768px) {
		.container {
			width: 95vw;
			margin: 1rem;
		}
	}
</style>
