<script lang="ts">
	import MediaPlaceHolder from '../../components/MediaPlaceHolder.svelte';
	import type { NodeViewProps } from '@tiptap/core';
	import { NodeViewWrapper } from 'svelte-tiptap';

	const { editor }: NodeViewProps = $props();
	import Video from '@lucide/svelte/icons/video';

	function handleClick() {
		const videoUrl = prompt('Please enter the video URL');
		if (videoUrl) {
			editor.chain().focus().setVideo(videoUrl).run();
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
	{/if}
</NodeViewWrapper>
