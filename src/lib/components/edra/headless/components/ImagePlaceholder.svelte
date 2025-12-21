<script lang="ts">
	import MediaPlaceHolder from '../../components/MediaPlaceHolder.svelte';
	import type { NodeViewProps } from '@tiptap/core';
	import { NodeViewWrapper } from 'svelte-tiptap';

	const { editor }: NodeViewProps = $props();
	import Image from '@lucide/svelte/icons/image';

	function handleClick() {
		const imageUrl = prompt('Please enter the image URL');
		if (imageUrl) {
			editor.chain().focus().setImage({ src: imageUrl }).run();
		}
	}
</script>

<NodeViewWrapper>
	{#if editor.isEditable}
		<MediaPlaceHolder
			class="edra-media-placeholder-wrapper"
			icon={Image}
			title="Insert an image"
			onClick={handleClick}
		/>
	{/if}
</NodeViewWrapper>
