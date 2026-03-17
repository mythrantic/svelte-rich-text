<script lang="ts">
	import MediaPlaceHolder from '../../components/MediaPlaceHolder.svelte';
	import type { NodeViewProps } from '@tiptap/core';
	import { NodeViewWrapper } from 'svelte-tiptap';

	const { editor }: NodeViewProps = $props();
	import Video from '@lucide/svelte/icons/video';

	let fileInput = $state<HTMLInputElement | undefined>();

	function handleClick() {
		// Try to open file picker first
		if (fileInput) {
			fileInput.click();
		} else {
			// Fallback to URL input
			promptForUrl();
		}
	}

	function promptForUrl() {
		const videoUrl = prompt('Enter video URL or select a file');
		if (videoUrl) {
			editor.chain().focus().setVideo(videoUrl).run();
		}
	}

	function handleFileSelect(e: Event) {
		const input = e.target as HTMLInputElement;
		const file = input.files?.[0];

		if (file) {
			const reader = new FileReader();
			reader.onload = (event) => {
				const src = event.target?.result as string;
				if (src) {
					editor.chain().focus().setVideo(src).run();
				}
			};
			reader.readAsDataURL(file);
		}
	}
</script>

<NodeViewWrapper>
	{#if editor.isEditable}
		<MediaPlaceHolder
			class="edra-media-placeholder-wrapper"
			icon={Video}
			title="Insert a video"
			onClick={handleClick}
		/>
		<input
			bind:this={fileInput}
			type="file"
			accept="video/*"
			onchange={handleFileSelect}
			style="display: none;"
		/>
	{/if}
</NodeViewWrapper>
