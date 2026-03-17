<script lang="ts">
	import { Editor } from '@tiptap/core';
	import ToolbarDropdown from './ToolbarDropdown.svelte';

	interface Props {
		editor: Editor;
	}

	const { editor }: Props = $props();

	const FONT_SIZE = [
		{ label: 'Tiny', value: '0.7rem' },
		{ label: 'Smaller', value: '0.75rem' },
		{ label: 'Small', value: '0.9rem' },
		{ label: 'Default', value: '' },
		{ label: 'Large', value: '1.25rem' },
		{ label: 'Extra Large', value: '1.5rem' }
	];

	let currentSize = $derived.by(() => editor.getAttributes('textStyle').fontSize || '');

	function handleFontSizeChange(value: string) {
		editor.chain().focus().setFontSize(value).run();
	}
</script>

<ToolbarDropdown
	options={FONT_SIZE}
	value={currentSize}
	label="Font Size"
	placeholder="Size"
	onchange={handleFontSizeChange}
/>
