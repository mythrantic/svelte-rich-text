<script lang="ts">
	import { onDestroy, onMount } from 'svelte';
	import type { EdraEditorProps } from '../types.js';
	import initEditor from '../editor.js';
	import { focusEditor } from '../utils.js';
	import '../editor.css';
	import './style.css';
	import '../onedark.css';
	import { ImagePlaceholder } from '../extensions/image/ImagePlaceholder.js';
	import ImagePlaceholderComp from './components/ImagePlaceholder.svelte';
	import { ImageExtended } from '../extensions/image/ImageExtended.js';
	import ImageExtendedComp from './components/ImageExtended.svelte';
	import { VideoPlaceholder } from '../extensions/video/VideoPlaceholder.js';
	import VideoPlaceHolderComp from './components/VideoPlaceholder.svelte';
	import { VideoExtended } from '../extensions/video/VideoExtended.js';
	import VideoExtendedComp from './components/VideoExtended.svelte';
	import { AudioPlaceholder } from '../extensions/audio/AudioPlaceholder.js';
	import { AudioExtended } from '../extensions/audio/AudiExtended.js';
	import AudioPlaceHolderComp from './components/AudioPlaceHolder.svelte';
	import AudioExtendedComp from './components/AudioExtended.svelte';
	import { IFramePlaceholder } from '../extensions/iframe/IFramePlaceholder.js';
	import { IFrameExtended } from '../extensions/iframe/IFrameExtended.js';
	import IFramePlaceHolderComp from './components/IFramePlaceHolder.svelte';
	import IFrameExtendedComp from './components/IFrameExtended.svelte';
	import CodeBlockLowlight from '@tiptap/extension-code-block-lowlight';
	import { all, createLowlight } from 'lowlight';
	import { SvelteNodeViewRenderer } from 'svelte-tiptap';
	import CodeBlock from './components/CodeBlock.svelte';
	import TableCol from './menus/TableCol.svelte';
	import TableRow from './menus/TableRow.svelte';
	import Link from './menus/Link.svelte';
	import slashcommand from '../extensions/slash-command/slashcommand.js';
	import SlashCommandList from './components/SlashCommandList.svelte';

	import { EdraToolBar } from './index.js';
	import EdraToolBarIcon from './components/ToolBarIcon.svelte';
	import { isMac } from '../utils.js';
	import DragHandle from '../components/DragHandle.svelte';
	import Bold from '@lucide/svelte/icons/bold';
	import '../themes/default-light.css';
	import '../themes/default-dark.css';
	import '../themes/modern-light.css';
	import '../themes/modern-dark.css';
	import '../themes/professional-light.css';
	import '../themes/professional-dark.css';
	import '../themes/inherit.css';

	const lowlight = createLowlight(all);

	/**
	 * Bind the element to the editor
	 */
	let element = $state<HTMLElement>();
	let {
		editor = $bindable(),
		editable = true,
		content,
		onUpdate,
		autofocus = false,
		class: className,
		theme = 'default',
		themeMode = 'light'
	}: EdraEditorProps = $props();

	onMount(() => {
		// Always include all extensions to maintain schema compatibility
		// but they'll respect the editable prop internally
		const extensions = [
			CodeBlockLowlight.configure({
				lowlight
			}).extend({
				addNodeView() {
					return SvelteNodeViewRenderer(CodeBlock);
				}
			}),
			ImagePlaceholder(ImagePlaceholderComp),
			ImageExtended(ImageExtendedComp),
			VideoPlaceholder(VideoPlaceHolderComp),
			VideoExtended(VideoExtendedComp),
			AudioPlaceholder(AudioPlaceHolderComp),
			AudioExtended(AudioExtendedComp),
			IFramePlaceholder(IFramePlaceHolderComp),
			IFrameExtended(IFrameExtendedComp),
			slashcommand(SlashCommandList)
		];

		editor = initEditor(element, content, extensions, {
			onUpdate,
			onTransaction(props) {
				editor = undefined;
				editor = props.editor;
			},
			editable,
			autofocus
		});
	});

	// Reactively update theme classes when theme or themeMode changes
	$effect(() => {
		if (element) {
			// Remove all old theme classes
			element.classList.remove(
				'theme-default-light',
				'theme-default-dark',
				'theme-modern-light',
				'theme-modern-dark',
				'theme-professional-light',
				'theme-professional-dark',
				'theme-inherit'
			);

			// Add new theme class if theme is not 'inherit'. if it's 'inherit', we rely on the parent element's theme and don't add any class
			if (theme !== 'inherit') {
				element.classList.add(`theme-${theme}-${themeMode}`);
				element.setAttribute('data-theme', theme);
				element.setAttribute('data-mode', themeMode);
			}
		}
	});

	onDestroy(() => {
		if (editor) editor.destroy();
	});
</script>

{#if editor && !editor.isDestroyed}
	<Link {editor} />
	<TableCol {editor} />
	<TableRow {editor} />
{/if}

{#if editor && !editor.isDestroyed && editor.isEditable}
	<EdraToolBar {editor} />

	<!-- Customized Edra toolbar -->
	<EdraToolBar {editor}>
		<div class="border-r px-3 text-sm">Customized toolbar</div>
		<EdraToolBarIcon
			command={{
				icon: Bold,
				name: 'bold',
				tooltip: 'Bold',
				shortCut: isMac ? '⌘+B' : 'Ctrl+B',
				onClick: (editor) => {
					editor.chain().focus().toggleBold().run();
				}
			}}
			{editor}
		/>
	</EdraToolBar>
	<DragHandle {editor} />
{/if}
<div
	bind:this={element}
	role="button"
	tabindex="0"
	onclick={(event) => focusEditor(editor, event)}
	onkeydown={(event) => {
		if (event.key === 'Enter' || event.key === ' ') {
			focusEditor(editor, event);
		}
	}}
	class={`edra-editor ${className}`}
></div>
