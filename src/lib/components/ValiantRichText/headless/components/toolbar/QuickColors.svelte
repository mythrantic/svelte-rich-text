<script lang="ts">
	import type { Editor } from '@tiptap/core';
	import ToolbarDropdown from './ToolbarDropdown.svelte';

	interface Props {
		editor: Editor;
	}
	const { editor }: Props = $props();

	const colors = [
		{ label: 'Default', value: '' },
		{ label: 'Blue', value: '#0000FF' },
		{ label: 'Brown', value: '#A52A2A' },
		{ label: 'Green', value: '#008000' },
		{ label: 'Grey', value: '#808080' },
		{ label: 'Orange', value: '#FFA500' },
		{ label: 'Pink', value: '#FFC0CB' },
		{ label: 'Purple', value: '#800080' },
		{ label: 'Red', value: '#FF0000' },
		{ label: 'Yellow', value: '#FFFF00' }
	];

	const currentColor = $derived.by(() => editor.getAttributes('textStyle').color ?? '');
	const currentHighlight = $derived.by(() => editor.getAttributes('highlight').color ?? '');

	function handleColorChange(color: string) {
		editor.chain().focus().setColor(color).run();
	}

	function handleHighlightChange(color: string) {
		editor.chain().focus().setHighlight({ color }).run();
	}
</script>

<ToolbarDropdown
	options={colors}
	value={currentColor}
	label="Text Color"
	placeholder="Color"
	onchange={handleColorChange}
/>

<ToolbarDropdown
	options={colors}
	value={currentHighlight}
	label="Highlight Color"
	placeholder="Highlight"
	onchange={handleHighlightChange}
/>

<style>
</style>
